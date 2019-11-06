package TwoOne::Player;

use 5.024; use strict; use warnings; use autodie;

use Data::Dump;
use Moo;
use namespace::clean;
use MooX::StrictConstructor;
use experimental 'signatures';
########################################################################
has name => qw(is ro required 1);

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

1;
