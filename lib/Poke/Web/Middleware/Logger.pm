package Poke::Web::Middleware::Logger;
BEGIN {
  $Poke::Web::Middleware::Logger::VERSION = '1.101610';
}
use MooseX::Declare;

class Poke::Web::Middleware::Logger
{
    with 'Poke::Web::Middleware';
    use MooseX::Types::Moose(':all');
    
    has logger => (is => 'ro', isa => 'Poke::Logger', required => 1);

    after preinvoke()
    {
        $self->env->{'poke.web.middleware.logger'} = $self->logger;
    }
}
1;


=pod

=head1 NAME

Poke::Web::Middleware::Logger

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

