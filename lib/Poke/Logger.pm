package Poke::Logger;
BEGIN {
  $Poke::Logger::VERSION = '1.101610';
}
use MooseX::Declare;

class Poke::Logger
{
    with 'MooseX::LogDispatch::Levels';
    
    has config =>
    (
        is => 'ro',
        isa => 'Poke::ConfigLoader',
        predicate => 'has_config',
    );

    has log_dispatch_conf =>
    (
        is => 'ro',
        isa => 'HashRef',
        lazy_build => 1,
    );

    method _build_log_dispatch_conf
    {
        if($self->has_config)
        {
            my %hash = %{$self->config->logger_config};
            return \%hash;
        }
        
        return
        +{
            class => 'Log::Dispatch::File',
            min_level => 'info',
            filename => 'poked.log',
            mode => '>>',
            close_after_write => 1,
            newline => 1,
        };
    }
}

__END__
=pod

=head1 NAME

Poke::Logger

=head1 VERSION

version 1.101610

=head1 AUTHOR

  Nicholas Perez <nperez@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

