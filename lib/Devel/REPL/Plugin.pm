use strict;
use warnings;
package Devel::REPL::Plugin;

use Devel::REPL::Meta::Plugin;
use Moose::Role ();
use namespace::autoclean;

sub import {
  my $target = caller;
  Devel::REPL::Meta::Plugin->initialize($target);
  goto &Moose::Role::import;
}

1;
