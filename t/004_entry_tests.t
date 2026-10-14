use strict;
use warnings;
use Test::More;
use Plack::Test;
use HTTP::Request::Common;
use JSON::MaybeXS qw(decode_json encode_json);

# Mock the database plugin before loading the app
use Test::MockModule;
use Test::MockObject;

# Because Dancer2::Plugin::Database injects the keyword into the app namespace,
# mocking it directly might not be straightforward if it checks config.
# So we mock the database call itself.
my $mock_db = Test::MockObject->new();
my $mock_sth1 = Test::MockObject->new();
my $mock_sth2 = Test::MockObject->new();

$mock_db->mock('prepare', sub {
    my ($self, $sql) = @_;
    if ($sql =~ /FROM entry_test_session/) {
        return $mock_sth1;
    } else {
        return $mock_sth2;
    }
});

$mock_sth1->mock('execute', sub { return 1; });
$mock_sth1->mock('fetchall_arrayref', sub {
    return [
        { id => 1, date => '2023-01-01', time => '10:00', limit_students => 10, onlinelink => 'link', password => 'pass', status => 1 }
    ];
});

$mock_sth2->mock('execute', sub { return 1; });
my $fetch_called = 0;
$mock_sth2->mock('fetchrow_hashref', sub {
    if (!$fetch_called) {
        $fetch_called = 1;
        return { session_id => 1, student_id => 2, name => 'John', surname => 'Doe', email => 'john@example.com', status => 1 };
    }
    return undef;
});


my $module = Test::MockModule->new('SgeoAPI');
$module->mock('database', sub { return $mock_db; });

use SgeoAPI;

my $app = SgeoAPI->to_app;
my $test = Plack::Test->create($app);

# Authenticate to get a token
my $res_login = $test->request( POST '/api/auth/login', Content_Type => 'application/json', Content => encode_json({username=>'test_user'}) );
is( $res_login->code, 200, 'Login successful' );

my $body = decode_json($res_login->content);
my $token = $body->{token};

# Test GET /api/entryTests
my $req = GET '/api/entryTests';
$req->header('Authorization' => "Bearer $token");
my $res = $test->request($req);

is( $res->code, 200, 'Request with valid token passes authorization and returns 200' );
my $res_data = decode_json($res->content);
is( ref $res_data, 'ARRAY', 'Result is an array');
is( scalar @$res_data, 1, 'Array has 1 element');
is( $res_data->[0]->{id}, 1, 'Session ID matches');
is( scalar @{$res_data->[0]->{bookings}}, 1, 'Session has 1 booking');
is( $res_data->[0]->{bookings}->[0]->{name}, 'John', 'Booking name matches');


done_testing();
