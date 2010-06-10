package Poke::Schema::Result::PokeResults;
BEGIN {
  $Poke::Schema::Result::PokeResults::VERSION = '1.101610';
}
use base 'DBIx::Class';
use DBIx::Class::InflateColumn::Object::Enum;

__PACKAGE__->load_components(qw/InflateColumn::DateTime InflateColumn::Object::Enum Core/);
__PACKAGE__->table('pokeresults');
__PACKAGE__->add_columns
(
    id =>
    {
        data_type => 'INTEGER',
        is_nullable => 0,
        is_auto_increment => 1,
        is_numeric => 1,
    },
    job_name =>
    {
        data_type => 'TEXT',
        is_nullable => 0,
    },
    job_uuid =>
    {
        data_Type => 'TEXT',
        is_nullable => 0,
    },
    job_start =>
    {
        data_type => 'datetime',
        is_nullable => 1,
    },
    job_stop =>
    {
        data_type => 'datetime',
        is_nullable => 1,
    },
    job_status =>
    {
        data_type => 'enum',
        is_enum => 1,
        extra =>
        {
            list => [qw/inprogress success fail/],
        },
    }
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint('uuid_of_job' => ['job_uuid']);


__END__
=pod

=head1 NAME

Poke::Schema::Result::PokeResults

=head1 VERSION

version 1.101610

=head1 AUTHOR

  Nicholas Perez <nperez@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

