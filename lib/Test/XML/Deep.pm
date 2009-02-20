package Test::XML::Deep;

use warnings;
use strict;

use XML::Simple;
use Test::Deep;
use Exporter;

my $Test = Test::Builder->new;

use base qw/Exporter/;

our @EXPORT = qw/ cmp_xml_deeply /;

=head1 NAME

Test::XML::Deep = XML::Simple + Test::Deep

=head1 VERSION

Version 0.02

=cut

our $VERSION = '0.02';


=head1 SYNOPSIS

This module can be used to easily test that some XML has the structure and values you desire.

It is particularly useful when some values in your XML document may differ from one test run
to another (for example, a timestamp).

An Example:

    use Test::XML::Deep;

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


Or, you can use Test::Deep and make use of the functions it exports (I.E. array_each(), re()):

    use Test::Deep;
    use Test::XML::Deep;

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


=head1 EXPORT

cmp_xml_deeply 

=head1 FUNCTIONS

=head2 cmp_xml_deeply

=cut

sub cmp_xml_deeply {
    my ( $xml, $expected, $name ) = @_;

    my $test  = eval { XMLin( $xml ); };
    my $not_ok = $@;

	if ($not_ok){
        ( my $message = $not_ok ) =~ s/ at .*//g;   # ick!
        $message =~ s/\n(?=.)/\.  /g;
        chomp $message;
		$Test->diag("XML parsing failed: $message");
        $Test->ok(0, $name);
	}else{
        cmp_deeply( $test, $expected, $name );
    }
}



=head1 AUTHOR

Jeff Lavallee, C<< <jeff at zeroclue.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-test-xml-deep at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Test-XML-Deep>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Test::XML::Deep


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Test-XML-Deep>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Test-XML-Deep>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Test-XML-Deep>

=item * Search CPAN

L<http://search.cpan.org/dist/Test-XML-Deep>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Jeff Lavallee, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 SEE ALSO

L<Test::XML::Simple>


=cut

1; # End of Test::XML::Deep
