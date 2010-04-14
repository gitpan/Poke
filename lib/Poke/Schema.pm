package Poke::Schema;
BEGIN {
  $Poke::Schema::VERSION = '1.101040';
}
use base qw/DBIx::Class::Schema/;
__PACKAGE__->load_namespaces();
1;

__END__
=pod

=head1 NAME

Poke::Schema

=head1 VERSION

version 1.101040

=head1 AUTHOR

  Nicholas Perez <nperez@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

