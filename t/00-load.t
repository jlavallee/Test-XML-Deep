#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Test::XML::Deep' );
}

diag( "Testing Test::XML::Deep $Test::XML::Deep::VERSION, Perl $], $^X" );
