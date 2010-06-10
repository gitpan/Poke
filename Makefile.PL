
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'A monitoring daemon framework',
  'AUTHOR' => 'Nicholas Perez <nperez@cpan.org>',
  'BUILD_REQUIRES' => {
    'Test::More' => '0'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'Poke',
  'EXE_FILES' => [
    'bin/poked'
  ],
  'LICENSE' => 'perl',
  'NAME' => 'Poke',
  'PREREQ_PM' => {
    'Bread::Board' => '0',
    'Config::Any' => '0',
    'Config::Tiny' => '0',
    'DBIx::Class' => '0',
    'DBIx::Class::InflateColumn::Object::Enum' => '0',
    'DBIx::Class::ResultClass::HashRefInflator' => '0',
    'DBIx::Class::Schema' => '0',
    'DateTime' => '0',
    'DateTime::Format::SQLite' => '0',
    'FindBin' => '0',
    'HTML::Zoom' => '0',
    'HTTP::Request' => '0',
    'JSON::Any' => '0',
    'LWP::UserAgent' => '0',
    'List::AllUtils' => '0',
    'Moose::Autobox' => '0',
    'Moose::Util' => '0',
    'Moose::Util::TypeConstraints' => '0',
    'MooseX::Declare' => '0',
    'MooseX::Getopt' => '0',
    'MooseX::LogDispatch::Levels' => '0',
    'MooseX::Types' => '0',
    'MooseX::Types::Moose' => '0',
    'MooseX::Types::Structured' => '0',
    'MooseX::Types::URI' => '0',
    'POE' => '0',
    'POEx::Role::PSGIServer' => '0',
    'POEx::Role::SessionInstantiation' => '0',
    'POEx::Types' => '0',
    'POEx::Types::PSGIServer' => '0',
    'POEx::WorkerPool' => '0',
    'POEx::WorkerPool::Types' => '0',
    'POEx::WorkerPool::Worker' => '0',
    'POEx::WorkerPool::WorkerEvents' => '0',
    'Perl6::Junction' => '0',
    'Scalar::Util' => '0',
    'TryCatch' => '0',
    'Web::Simple' => '0',
    'aliased' => '0'
  },
  'VERSION' => '1.101610',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



