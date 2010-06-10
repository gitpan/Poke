package Poke::Web::Middleware::Schema;
BEGIN {
  $Poke::Web::Middleware::Schema::VERSION = '1.101610';
}
use MooseX::Declare;

class Poke::Web::Middleware::Schema
{
    with 'Poke::Web::Middleware';
    use MooseX::Types::Moose(':all');
    
    has schema => (is => 'ro', isa => 'Poke::Schema', required => 1);

    after preinvoke()
    {
        $self->env->{'poke.web.middleware.schema'} = $self->schema;
    }
}
1;


=pod

=head1 NAME

Poke::Web::Middleware::Schema

=head1 VERSION

version 1.101610

=head1 AUTHOR

  Nicholas Perez <nperez@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__
