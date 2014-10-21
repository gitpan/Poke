package Poke::ConfigLoader;
BEGIN {
  $Poke::ConfigLoader::VERSION = '1.101610';
}
use MooseX::Declare;

class Poke::ConfigLoader
{
    use Moose::Util::TypeConstraints;
    use MooseX::Types::Moose(':all');
    use Poke::Types(':all');
    use Moose::Autobox;
    use Poke::Util;

    has config_source =>
    (
        is => 'ro', 
        isa => subtype(Str, where { -e $_ }),
        required => 1,
    );

    has config =>
    (
        is => 'ro',
        isa => PokeConfig,
        traits => ['Hash'],
        lazy_build => 1,
        handles =>
        {
            'poke_config'       => [ get => 'Poke'],
            'logger_config'     => [ get => 'Logger'],
            'schema_config'     => [ get => 'Schema'],
            'web_config'        => [ get => 'Web'],
            'pool_config'       => [ get => 'WorkerPool'],
        },
    );
    method _build_config { Poke::Util->load_config($self->config_source) }

    has jobs_config =>
    (
        is => 'ro',
        isa => JobConfigurations,
        lazy_build => 1,
    );

    method _build_jobs_config
    {
        my $junc = [qw/Poke Logger Schema Web WorkerPool/]->all;
        my $jcfg = $self->config
            ->kv
            ->grep(sub {$junc ne $_->[0]});

        $jcfg->each_value(sub {Class::MOP::load_class($_->[1]->{class}) unless Class::MOP::is_class_loaded($_->[1]->{class})});

        return $jcfg;
    }
}
1;


=pod

=head1 NAME

Poke::ConfigLoader

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
