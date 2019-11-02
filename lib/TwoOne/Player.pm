package TwoOne::Player;

use 5.024; use strict; use warnings; use autodie;

use Data::Dump;
use Moo;
use namespace::clean;
use MooX::StrictConstructor;
use experimental 'signatures';
########################################################################
has name => qw(is ro required 1);

has [qw<atk_skill def_skill mid_skill gk_skill>] => qw(is ro required 1);

sub BUILDARGS($self, %args) {
    return {
        gk_skill  => delete $args{G},
        def_skill => delete $args{D},
        mid_skill => delete $args{M},
        atk_skill => delete $args{A},
        %args
    }
}

1;
