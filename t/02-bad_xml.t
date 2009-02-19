#!perl -T

use XML::Simple;
use Data::Dumper;
use Test::Deep;
use Test::More tests => 3;
use Test::Builder::Tester;
use Test::Builder::Tester::Color;
use Test::More;

BEGIN {
	use_ok( 'Test::XML::Deep' );
}


{
    my $xml = <<EOXML;
<?xml version="1.0" encoding="UTF-8"?>
<example>
    <sometag>
</example>
EOXML

    test_out("not ok 1");
    test_diag(qq{XML parsing failed: Opening and ending tag mismatch: sometag line 3 and example.  Premature end of data in tag example line 2});
    test_fail(+1);
    cmp_xml_deeply($xml, { });
    test_test("fail works");
}

{
    my $xml = <<EOXML;
<?xml version="1.0" encoding="UTF-8"?>
<example>
    <som
</example>
EOXML

    test_out("not ok 1 - half a tag");
    test_diag("XML parsing failed: error parsing attribute name.  attributes construct error.  xmlParseStartTag: problem parsing attributes.  Couldn't find end of Start Tag som line 3");
    test_fail(+1);
    cmp_xml_deeply($xml, { }, 'half a tag');
    test_test("fail works");
}

