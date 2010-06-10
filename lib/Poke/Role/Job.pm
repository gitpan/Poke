package Poke::Role::Job;
BEGIN {
  $Poke::Role::Job::VERSION = '1.101610';
}
use MooseX::Declare;

role Poke::Role::Job
{
    use MooseX::Types::Moose(':all');
    use Scalar::Util('weaken');
    requires qw/setup run/;

    has frequency => (is => 'ro', isa => Int, default => sub { 60 });
    has name => (is => 'ro', isa => Str, required => 1);

    method init_job
    {
        weaken($self);
        $self->setup(); 
        $self->enqueue_step
        (
            [
                sub{ $self->run() }, 
                [] 
            ]
        );
    }

    with 'POEx::WorkerPool::Role::Job';
}

1;


=pod

=head1 NAME

Poke::Role::Job

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
