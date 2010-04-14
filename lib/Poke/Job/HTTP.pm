package Poke::Job::HTTP;
BEGIN {
  $Poke::Job::HTTP::VERSION = '1.101040';
}
use MooseX::Declare;

class Poke::Job::HTTP with Poke::Role::Job
{
    use Moose::Util::TypeConstraints;
    use MooseX::Types::URI('Uri');
    use HTTP::Request;
    use LWP::UserAgent;

    has uri =>
    (
        is => 'ro',
        isa => Uri,
        coerce => 1,
        required => 1,
    );

    has agent =>
    (
        is => 'ro',
        isa => class_type('LWP::UserAgent'),
        lazy_build => 1,
        handles => ['simple_request'],
    );

    sub _build_agent { return LWP::UserAgent->new(); }

    method setup
    {
        $self->agent();
    }

    method run
    {
        my $response = $self->simple_request($self->_build_request);
        die unless $response->is_success;
    }

    method _build_request
    {
        return HTTP::Request->new('GET', $self->uri);
    }
}
1;

__END__
=pod

=head1 NAME

Poke::Job::HTTP

=head1 VERSION

version 1.101040

=head1 AUTHOR

  Nicholas Perez <nperez@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

