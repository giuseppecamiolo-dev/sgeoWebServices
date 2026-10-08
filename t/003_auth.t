use strict;
use warnings;

# Mock the database plugin before loading the app
use Test::MockModule;

my $module = Test::MockModule->new('Dancer2::Plugin::Database');
$module->mock('database', sub { return 1; }); # Return something true to bypass the actual db connection

use SgeoAPI;
use Test::More tests => 6;
use Plack::Test;
use HTTP::Request::Common;
use JSON::MaybeXS qw(decode_json);

# Wait, the route also does prepare/execute, so let's just make the test access a simpler route, or just catch the 500 and ignore since auth succeeded (we got past 401).

my $app = SgeoAPI->to_app;
my $test = Plack::Test->create($app);

# Test 1: Access without token
my $res_unauth = $test->request( GET '/api/clienti' );
is( $res_unauth->code, 401, 'Request to protected route without token fails' );

# Test 2: Login and get token
my $res_login = $test->request( POST '/api/auth/login', Content_Type => 'application/json', Content => '{"username":"test_user"}' );
is( $res_login->code, 200, 'Login successful' );

my $body = decode_json($res_login->content);
ok( exists $body->{token}, 'Login response contains a token' );
my $token = $body->{token};

# Test 3: Access with invalid token
my $res_invalid = $test->request( GET '/api/clienti', Authorization => 'Bearer invalid_token' );
is( $res_invalid->code, 401, 'Request with invalid token fails' );

# Test 4: Access with valid token
my $res_auth = $test->request( GET '/api/clienti', Authorization => "Bearer $token" );
# Since database will fail, we just want to ensure it's not 401
isnt( $res_auth->code, 401, 'Request with valid token passes authorization' );

# Test 5: OPTIONS request shouldn't require auth (CORS preflight)
my $res_options = $test->request( OPTIONS '/api/clienti' );
# SgeoAPI might not have OPTIONS mapped, but it should return 404/405 not 401 if it gets past the hook
isnt( $res_options->code, 401, 'OPTIONS request bypasses authentication' );
