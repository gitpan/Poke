package Poke::Types;
BEGIN {
  $Poke::Types::VERSION = '1.101610';
}
use warnings;
use strict;

use MooseX::Types -declare =>
[qw/
    JobConfiguration
    JobConfigurations
    PokeConfig
/];
use MooseX::Types::Moose(':all');
use MooseX::Types::Structured(':all');
use Moose::Autobox;

subtype PokeConfig,
    as HashRef,
    where { $_->keys->length >= 5 && [qw/Poke Logger Schema Web/]->all eq $_->keys->any };

subtype JobConfiguration,
    as Tuple[Str, HashRef];

subtype JobConfigurations,
    as ArrayRef[JobConfiguration];

1;

__END__
=pod

=head1 NAME

Poke::Types

=head1 VERSION

version 1.101610

=head1 AUTHOR

  Nicholas Perez <nperez@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

