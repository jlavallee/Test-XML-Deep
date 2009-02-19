#!perl -T

use Test::More tests => 3;
use XML::Simple;
use Data::Dumper;
use Test::Deep;

BEGIN {
	use_ok( 'Test::XML::Deep' );
}


{
    my $xml = <<EOXML;
<?xml version="1.0" encoding="UTF-8"?>
<example>
    <sometag attribute="value">some data</sometag>
    <sometag attribute="other">more data</sometag>
</example>
EOXML

    my $expected = { 'sometag' => [
                                   {
                                     'attribute' => 'value',
                                     'content' => 'some data'
                                   },
                                   {
                                     'attribute' => 'other',
                                     'content' => 'more data'
                                   }
                                 ]
                   };

    cmp_xml_deeply($xml, $expected);
}

{

    my $xml = <<EOXML;
<?xml version="1.0" encoding="UTF-8"?>
<example>
    <sometag attribute="1234">some data</sometag>
    <sometag attribute="4321">more data</sometag>
</example>
EOXML

    my $expected = { 'sometag' => array_each( { 'attribute' => re('^\d+$'),
                                                'content' => re('data$'),
                                               }
                                  )
                   };

    cmp_xml_deeply($xml, $expected);
}



