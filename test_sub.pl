#!/usr/bin/perl

use strict;
use warnings;

use Test::Simple tests => 4;

use lib qw(C:/Users/yousefh/workspace-po/play_ground/Test);
use MySub ;

#ok( Test::MySub::numeric_month( 1, "Januarry") == 1 ,'Januarry' );
#ok( Test::MySub::numeric_month(1, "Jan") == 1 ,'Jan');
#ok( Test::MySub::numeric_month( 1, "jun") ==  6 ,'jun');
#ok( Test::MySub::numeric_month(1, "June") == 6 ,'June');


ok( Test::MySub::skip_junk( '  1X') eq 'no match' ,'  1X' );
ok( Test::MySub::skip_junk('1LTR15261') eq 'match' ,'1LTR15261');
ok( Test::MySub::skip_junk( '1LTr15261   ') eq  'no match' ,'1LTr15261   ');
