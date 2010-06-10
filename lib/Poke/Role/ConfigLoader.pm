package Poke::Role::ConfigLoader;
BEGIN {
  $Poke::Role::ConfigLoader::VERSION = '1.101610';
}
use MooseX::Declare;

role Poke::Role::ConfigLoader
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
        handles =>
        {
            'poke_config'       => [ get => 'Poke'],
            'logger_config'     => [ get => 'Logger'],
            'schema_config'     => [ get => 'Schema'],
            'web_config'        => [ get => 'Web' ],
        },
        lazy_build => 1,
    );
    method _build_config { Poke::Util->load_config($self->config_source) }

    has jobs_configuration =>
    (
        is => 'ro',
        isa => JobConfiguration, #ArrayRef[Tuple[ClassName, HashRef]],
        lazy_build => 1,
    );

    method _build_jobs_configuration
    {
        my $jcfg = $self->config
            ->kv
            ->grep(sub {[qw/Poke Logger Schema Web/]->all != $_->[0]});

        $jcfg->each(sub {Class::MOP::load_class($_->[0])});

        return $jcfg;
    }
    
}
1;


=pod

=head1 NAME

Poke::Role::ConfigLoader

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
