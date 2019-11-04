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

# use File::Spec; Test::Most->builder->output(File::Spec->devnull);
################################################################################
use Test::Most;

use TwoOne::Player;
use TwoOne::Team;

my $team = TwoOne::Team->new(
    name => 'New New York Manglers',
    formation => 433,
);

# keeper
$team->add_player( TwoOne::Player->new( name => 'player01', G => 3, D => 1, M => 1, A => 1 ) );

# defenders
$team->add_player( TwoOne::Player->new( name => 'player02', G => 1, D => 2, M => 1, A => 1 ) );
$team->add_player( TwoOne::Player->new( name => 'player03', G => 1, D => 3, M => 1, A => 1 ) );
$team->add_player( TwoOne::Player->new( name => 'player04', G => 1, D => 3, M => 1, A => 1 ) );
$team->add_player( TwoOne::Player->new( name => 'player05', G => 1, D => 3, M => 1, A => 1 ) );

# mid
$team->add_player( TwoOne::Player->new( name => 'player06', G => 1, D => 1, M => 3, A => 1 ) );
$team->add_player( TwoOne::Player->new( name => 'player07', G => 1, D => 1, M => 2, A => 1 ) );
$team->add_player( TwoOne::Player->new( name => 'player08', G => 1, D => 1, M => 2, A => 2 ) );

# attack
$team->add_player( TwoOne::Player->new( name => 'player09', G => 1, D => 1, M => 1, A => 3 ) );
$team->add_player( TwoOne::Player->new( name => 'player10', G => 1, D => 1, M => 1, A => 3 ) );
$team->add_player( TwoOne::Player->new( name => 'player11', G => 1, D => 1, M => 1, A => 2 ) );

diag "433";

is $team->goalkeeper_rating, 3, '3 goalkeeping';
is $team->defence_rating, 11 + 3/2, '12.5 defence';
is $team->midfield_rating, 7, '7 midfield';
is $team->attack_rating, 8 + 2, '10 attack';

diag "541";

$team->formation(541);

is $team->goalkeeper_rating, 3, '3 goalkeeping';
is $team->defence_rating, 12 + 2, '14 defence';
is $team->midfield_rating, 6, '6 midfield';
is $team->attack_rating, 2 + 9/2, '6.5 attack';

done_testing;
