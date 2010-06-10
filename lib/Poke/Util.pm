package Poke::Util;
BEGIN {
  $Poke::Util::VERSION = '1.101610';
}
use MooseX::Declare;

class Poke::Util
{
    use Config::Any;
    method load_config(ClassName $class: Str $file)
    {
        my $cfg = Config::Any->load_files({ files => [$file], use_ext => 1 })->[0]->{$file};
        return $cfg;
    }
}


__END__
=pod

=head1 NAME

Poke::Util

=head1 VERSION

version 1.101610

=head1 AUTHOR

  Nicholas Perez <nperez@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

