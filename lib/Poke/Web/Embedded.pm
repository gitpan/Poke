use Web::Simple('Poke::Web::Embedded');
{
    package Poke::Web::Embedded;
BEGIN {
  $Poke::Web::Embedded::VERSION = '1.101040';
}
    use HTML::Zoom;
    use DBIx::Class::ResultClass::HashRefInflator;
    use Poke::ConfigLoader;
    use Perl6::Junction;

my $html = <<HTML;
<html>
<head>
</head>
<body>
<div class="main_container">
<div class="service">
<table>
<thead><tr><th>Job Name</th><th>Job ID</th><th>Job Status</th><th>Job Start</th><th>Job Stop</th></thead>
<tbody id="statuses">
    <tr>
        <td class="job_name"></td><td class="job_uuid"></td><td class="job_status"></td><td class="job_start"></td><td class="job_stop"></td>
    </tr>
</tbody>
<tfoot></tfoot>
</table>
</div>
</div>
</body>
</html>

HTML

    my $logger;
    sub set_logger { shift; $logger = shift; }
    
    my $schema;
    sub set_schema { shift; $schema = shift; }

    dispatch
    {
        sub (GET)
        {
            my $res = $schema->resultset('PokeResults');
            $res->result_class('DBIx::Class::ResultClass::HashRefInflator');
            
            my $repeat = 
            [
                map
                {
                    my $row = $_;
                    sub
                    {
                        shift->select('.job_name')
                        ->replace_content($row->{job_name})
                        ->select('.job_uuid')
                        ->replace_content($row->{job_uuid})
                        ->select('.job_status')
                        ->replace_content($row->{job_status})
                        ->select('.job_start')
                        ->replace_content($row->{job_start})
                        ->select('.job_stop')
                        ->replace_content($row->{job_stop});
                    },
                }
                $res->all()
            ];

            my $output = HTML::Zoom
                ->from_html($html)
                ->select('#statuses')
                ->repeat_content($repeat)
                ->to_fh();

            return [ 200, [ 'Content-type', 'text/html' ], $output ];
        },
        sub ()
        {
            return [ 404, [ 'Content-type', 'text/plain' ], [ 'Error: Not Found' ] ];
        }
    };
}

Poke::Web::Embedded->run_if_script();

__END__
=pod

=head1 NAME

Poke::Web::Embedded

=head1 VERSION

version 1.101040

=head1 AUTHOR

  Nicholas Perez <nperez@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

