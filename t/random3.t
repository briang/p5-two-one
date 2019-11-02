#!/usr/bin/env perl

#:TAGS:

use 5.020; use strict;  use warnings;  use autodie;

BEGIN {
    if ($ENV{INSIDE_EMACS}) {
        chdir '..' until -d 't';
        use lib 'lib';
    }
}

use Data::Dump;

if (0) {
    no strict 'refs';
    diag($_), $_->() for grep { /^test_/ } keys %::
}
################################################################################
use Test::Most qw(no_plan);

# XXX The following will only display failing tests
# use File::Spec;
# Test::Most->builder->output(File::Spec->devnull); # XXX # only display fails!

use Math::Random ();
sub random3 { Math::Random::random_normal((1, @_)) }

sub is_approx {
    my ($actual, $expected, $msg) = @_;

    our $EPSILON //= 0.001;
    if (abs($actual - $expected) <= $EPSILON)
         { pass $msg }
    else { fail $msg }
}

my $SAMPLES = 1_000_000;

sub stats {
    my ($mean, $sd) = @_;

    my %sigma;
    my ($sx, $sxx);
    for (1..$SAMPLES) {
        my $x = random3($mean, $sd);
        $sx  += $x;
        $sxx += $x * $x;
        abs($x-$mean) <= $_ and $sigma{$_} += 1
          for 1..3;
    }

    $_ /= $SAMPLES for values %sigma;
    diag "sigmas: ", Data::Dump::pp(\%sigma);

    return
      $sx / $SAMPLES, # mean
      sqrt +( $sxx - $sx ** 2 / $SAMPLES ) / $SAMPLES; # SD
}

our $EPSILON = 0.01;

my ($mean, $sd) = stats(0, 1);
diag "mean, sd: ", Data::Dump::pp($mean, $sd);

is_approx $mean, 0, "N(0, 1) mean is ~0";
is_approx $sd,   1, "N(0, 1) SD is ~1";

($mean, $sd) = stats(2, 0.5);
diag "mean, sd: ", Data::Dump::pp($mean, $sd);

is_approx $mean, 2,   "N(2, 0.5) mean is ~2";
is_approx $sd,   0.5, "N(2, 0.5) SD is ~0.5";

done_testing;
