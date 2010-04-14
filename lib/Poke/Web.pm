package Poke::Web;
BEGIN {
  $Poke::Web::VERSION = '1.101040';
}
use MooseX::Declare;
class Poke::Web
{
    use Poke::Web::Embedded;
    use POEx::Types::PSGIServer(':all');
    
    with 'POEx::Role::PSGIServer';

    has logger =>
    (
        is => 'ro',
        isa => 'Poke::Logger',
        required => 1,
        handles => [qw/ debug info notice warning error /]
    );

    has schema =>
    (
        is => 'ro',
        isa => 'Poke::Schema',
        required => 1, 
    );

    after _start
    {
        Poke::Web::Embedded->set_logger($self->logger);
        Poke::Web::Embedded->set_schema($self->schema);
        $self->register_service(Poke::Web::Embedded->run_if_script());
    }
}
1;


=pod

=head1 NAME

Poke::Web

=head1 VERSION

version 1.101040

=head1 AUTHOR

  Nicholas Perez <nperez@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__
