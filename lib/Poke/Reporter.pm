package Poke::Reporter;
BEGIN {
  $Poke::Reporter::VERSION = '1.101040';
}
use MooseX::Declare;

class Poke::Reporter
{
    with 'POEx::Role::SessionInstantiation';
    use aliased 'POEx::Role::Event';

    use POEx::Types(':all');
    use POEx::WorkerPool::Types(':all');
    use POEx::WorkerPool::WorkerEvents(':all');
    use MooseX::Types::Moose(':all');
    use Moose::Autobox;
    use Scalar::Util('blessed');
    use DateTime;

    has logger =>
    (
        is => 'ro',
        isa => 'Poke::Logger',
        required => 1,
        handles => [qw/ debug info notice warning error /]
    );

    has schema =>
    (
        is => 'ro',
        isa => 'Poke::Schema',
        required => 1, 
    );

    has subscribed_workers =>
    (
        is => 'ro',
        isa => ArrayRef[SessionID],
        default => sub { [] },
        writer => '_set_subscribed_workers',
    );

    after _start is Event
    {
        $self->poe->kernel->sig('DIE', 'exception_handler');
        $self->check_db();
    }

    method exception_handler(Str $sig, HashRef $ex) is Event
    {
        $self->poe->kernel->sig_handled();
        $self->error("Exception occured in $ex->{event}: $ex->{error_str}");
    }

    method check_db
    {
        $self->schema->storage->dbh_do
        (
            sub
            {
                my ($storage, $dbh) = @_;
                unless ( @{ $dbh->table_info(undef, undef, 'pokeresults', 'TABLE')->fetchall_arrayref } ) 
                {
                    $self->schema->deploy();
                }
            }
        );
    }

    method subscribe_to_worker(DoesWorker $worker) is Event
    {
        if($self->subscribed_workers->all != $worker->ID)
        {
            $self->poe->kernel->refcount_increment($self->ID, 'SUBSCRIBED_WORKERS');
            $self->info("Subscribing to ${\$worker->ID}");
            my $palias = $worker->pubsub_alias;
            $self->call($palias, 'subscribe', event_name => +PXWP_JOB_START, event_handler => 'job_started');
            $self->call($palias, 'subscribe', event_name => +PXWP_JOB_COMPLETE, event_handler => 'job_completed');
            $self->call($palias, 'subscribe', event_name => +PXWP_JOB_FAILED, event_handler => 'job_failed');
            $self->subscribed_workers->push($worker->ID);
        }
    }

    method unsubscribe_from_worker(DoesWorker $worker) is Event
    {
        if($self->subscribed_workers->any == $worker->ID)
        {
            $self->poe->kernel->refcount_decrement($self->ID, 'SUBSCRIBED_WORKERS');
            $self->info("Unsubscribing from ${\$worker->ID}");
            my $palias = $worker->pubsub_alias;
            $self->call($palias, 'cancel', event_name => +PXWP_JOB_START);
            $self->call($palias, 'cancel', event_name => +PXWP_JOB_COMPLETE);
            $self->call($palias, 'cancel', event_name => +PXWP_JOB_FAILED);
            $self->_set_subscribed_workers($self->subscribed_workers->grep(sub{$worker->ID != $_}));
        }
    }

    method job_started(SessionID :$worker_id, DoesJob :$job) is Event
    {
        my $vals = 
        {
            job_name => blessed($job),
            job_uuid => $job->ID,
            job_start => DateTime->now(),
            job_status => 'inprogress'
        };
        
        $self->info("Job Started: ${\$job->ID}");
        $self->schema->resultset('PokeResults')->new_result($vals)->insert();
    }

    method job_completed(SessionID :$worker_id, DoesJob :$job, Ref :$msg) is Event
    {
        $self->info("Job Completed: ${\$job->ID}");
        my $db_job = $self->schema->resultset('PokeResults')->find($job->ID, { key => 'uuid_of_job' });
        $db_job->job_stop(DateTime->now());
        $db_job->job_status('success');
        $db_job->update();
    }

    method job_failed(SessionID :$worker_id, DoesJob :$job, Ref :$msg) is Event
    {
        $self->info("Job Failed: ${\$job->ID}\n\n $$msg");
        my $db_job = $self->schema->resultset('PokeResults')->find($job->ID, { key => 'uuid_of_job' });
        $db_job->job_stop(DateTime->now());
        $db_job->job_status('fail');
        $db_job->update();
    }
}

__END__
=pod

=head1 NAME

Poke::Reporter

=head1 VERSION

version 1.101040

=head1 AUTHOR

  Nicholas Perez <nperez@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

