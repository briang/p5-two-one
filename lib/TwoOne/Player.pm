package TwoOne::Player;

use 5.024; use strict; use warnings; use autodie;

use Data::Dump;
use Moo;
use namespace::clean;
use MooX::StrictConstructor;
use experimental 'signatures';
########################################################################
use List::Util 'max';
use Math::Random 'random_normal';

has name             => qw(is ro required 1);
has attack_skill     => qw(is ro required 1);
has defence_skill    => qw(is ro required 1);
has goalkeeper_skill => qw(is ro required 1);
has midfield_skill   => qw(is ro required 1);
has position         => qw(is rw), default => '';

sub BUILDARGS($self, %args) {
    return {
        goalkeeper_skill => delete $args{G},
        defence_skill    => delete $args{D},
        midfield_skill   => delete $args{M},
        attack_skill     => delete $args{A},
        %args
    }
}

sub new_random_player($self, $name) {
    return $self->new(
        name             => $name,
        goalkeeper_skill => max( 5, random_normal(1, 20, 10) ),
        defence_skill    => max( 5, random_normal(1, 20, 10) ),
        midfield_skill   => max( 5, random_normal(1, 20, 10) ),
        attack_skill     => max( 5, random_normal(1, 20, 10) ),
    );
}

1;
