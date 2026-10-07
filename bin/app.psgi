#!/usr/bin/perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";


# use this block if you don't need middleware, and only have a single target Dancer app to run here
use SgeoAPI;

SgeoAPI->to_app;

=begin comment
# use this block if you want to include middleware such as Plack::Middleware::Deflater

use SgeoAPI;
use Plack::Builder;

builder {
    enable 'Deflater';
    SgeoAPI->to_app;
}

=end comment

=cut

=begin comment
# use this block if you want to mount several applications on different path

use SgeoAPI;
use SgeoAPI_admin;

use Plack::Builder;

builder {
    mount '/'      => SgeoAPI->to_app;
    mount '/admin'      => SgeoAPI_admin->to_app;
}

=end comment

=cut
