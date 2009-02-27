#!perl -T

use strict;
use warnings;
use Test::More tests => 4;
use Test::NoWarnings;
use Test::Builder::Tester;
use Test::Builder::Tester::Color;

BEGIN {
	use_ok( 'Test::XML::Deep' );
}


{   # good test
    my $file = File::Spec->catfile('t', 'example.xml');
    my $expected = { 'sometag' => [
                                   {
                                     'attribute' => 'value',
                                     'content' => 'some data'
                                   },
                                   {
                                     'attribute' => 'other',
                                     'content' => 'more data'
                                   },
                                 ]
                   };

    cmp_xml_deeply($file, $expected);
}

{   # bad test against same file
    my $file = File::Spec->catfile('t', 'example.xml');
    my $expected = { 'sometag' => [
                                   {
                                     'attribute' => 'value',
                                     'content' => 'some data'
                                   },
                                 ]
                   };

    test_out("not ok 1");
    test_fail(+4);
    test_diag('Compared array length of $data->{"sometag"}
#    got : array with 2 element(s)
# expect : array with 1 element(s)');
    cmp_xml_deeply($file, $expected);
    test_test("fail works");
}


