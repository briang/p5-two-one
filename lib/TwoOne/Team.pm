package TwoOne::Team;

use 5.028; use strict; use warnings; use autodie;

use Data::Dump;
use Moo;
use namespace::clean;
use MooX::StrictConstructor;
use experimental 'signatures';
########################################################################
use List::Util 'sum';

has name    => qw(is ro required 1);
has players => qw(is ro), default => sub { [] };

sub add_player($self, $player) {
    push $self->players->@*, $player
}

sub gk_rating($self) {
    return $self->goalkeeper->gk_skill,
}

sub def_rating($self) {
    return sum map( { $_->def_skill     } $self->defenders ),
               map( { $_->def_skill / 2 } $self->midfielders )
}

sub mid_rating($self) {
    return sum map( { $_->mid_skill } $self->midfielders )
}

sub atk_rating($self) {
    return sum map( { $_->atk_skill     } $self->attackers),
               map( { $_->atk_skill / 2 } $self->midfielders )
}

sub attackers($self)   { @{$self->players}[8..10] }
sub midfielders($self) { @{$self->players}[5..7] }
sub defenders($self)   { @{$self->players}[1..4] }
sub goalkeeper($self)  { @{$self->players}[0] }

1;
