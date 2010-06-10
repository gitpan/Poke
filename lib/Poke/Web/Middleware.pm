package Poke::Web::Middleware;
BEGIN {
  $Poke::Web::Middleware::VERSION = '1.101610';
}
use MooseX::Declare;

role Poke::Web::Middleware
{
    use POEx::Types::PSGIServer(':all');
    use MooseX::Types::Moose(':all');
    use Scalar::Util('weaken');

    has app => (is => 'ro', isa => CodeRef, required => 1);
    has response => (is => 'ro', isa => PSGIResponse);
    has env => (is => 'rw', isa => HashRef);

    method wrap(ClassName $class: CodeRef $app, @args)
    {
        my $self = $class->new(app => $app, @args);
        return $self->to_app;
    }

    method call(HashRef $env)
    {
        $self->env($env);
        $self->preinvoke();
        $self->invoke();
        $self->postinvoke();
    }

    method preinvoke()
    {
        return;
    }

    method invoke()
    {
        $self->response($self->app->($self->env));
    }

    method postinvoke()
    {
        return;
    }

    method to_app()
    {   
        return sub { $self->call(@_) };
    }
}

1;


=pod

=head1 NAME

Poke::Web::Middleware

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
