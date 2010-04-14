
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t'
                                 },
                       'NAME' => 'Poke',
                       'DISTNAME' => 'Poke',
                       'CONFIGURE_REQUIRES' => {
                                                 'ExtUtils::MakeMaker' => '6.31'
                                               },
                       'AUTHOR' => 'Nicholas Perez <nperez@cpan.org>',
                       'BUILD_REQUIRES' => {
                                             'Test::More' => '0'
                                           },
                       'ABSTRACT' => 'A monitoring daemon framework',
                       'EXE_FILES' => [
                                        'bin/poked'
                                      ],
                       'VERSION' => '1.101040',
                       'PREREQ_PM' => {
                                        'POEx::Types::PSGIServer' => '0',
                                        'DateTime' => '0',
                                        'MooseX::Types::Structured' => '0',
                                        'aliased' => '0',
                                        'Bread::Board' => '0',
                                        'Config::Any' => '0',
                                        'DBIx::Class::Schema' => '0',
                                        'List::AllUtils' => '0',
                                        'HTML::Zoom' => '0',
                                        'Moose::Autobox' => '0',
                                        'DateTime::Format::SQLite' => '0',
                                        'Moose::Util' => '0',
                                        'MooseX::Types' => '0',
                                        'DBIx::Class::InflateColumn::Object::Enum' => '0',
                                        'HTTP::Request' => '0',
                                        'POE' => '0',
                                        'POEx::Types' => '0',
                                        'MooseX::Types::Moose' => '0',
                                        'Scalar::Util' => '0',
                                        'POEx::Role::SessionInstantiation' => '0',
                                        'MooseX::Declare' => '0',
                                        'POEx::Role::PSGIServer' => '0',
                                        'Moose::Util::TypeConstraints' => '0',
                                        'Perl6::Junction' => '0',
                                        'MooseX::Types::URI' => '0',
                                        'MooseX::Getopt' => '0',
                                        'POEx::WorkerPool::Types' => '0',
                                        'DBIx::Class::ResultClass::HashRefInflator' => '0',
                                        'DBIx::Class' => '0',
                                        'Web::Simple' => '0',
                                        'TryCatch' => '0',
                                        'MooseX::LogDispatch::Levels' => '0',
                                        'LWP::UserAgent' => '0',
                                        'POEx::WorkerPool::WorkerEvents' => '0',
                                        'POEx::WorkerPool' => '0',
                                        'Config::Tiny' => '0'
                                      },
                       'LICENSE' => 'perl'
                     );


delete $WriteMakefileArgs{BUILD_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.56) };

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



