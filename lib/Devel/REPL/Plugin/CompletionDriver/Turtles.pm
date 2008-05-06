#!/usr/bin/perl

package Devel::REPL::Plugin::CompletionDriver::Turtles;
use Devel::REPL::Plugin;

with qw(
  Devel::REPL::Plugin::Completion
  Devel::REPL::Plugin::Turtles
);

around complete => sub {
  my $orig = shift;
  my ($self, $text, $document) = @_;

  my $prefix = $self->default_command_prefix;
  my $line_re = qr/^($prefix)(\w+)/;

  my @orig = $self->$orig($text, $document);

  if ( my ( $pre, $method ) = ( $text =~ $line_re ) ) {
    my $filter = qr/^\Q$method/;
    return (
      @orig,
      (
        map { "$pre$_" }
        grep { $_ =~ $filter }
        map { /^expr?_command_(\w+)/ ? $1 : () }
        map { $_->{name} }
        $self->meta->compute_all_applicable_methods
      ),
    );
  } else {
    return @orig;
  }
};

__PACKAGE__

__END__

