package TwoOne::Team;

use 5.028; use strict; use warnings; use autodie;

use Data::Dump;
use Moo;
use namespace::clean;
use MooX::StrictConstructor;
use experimental 'signatures';
########################################################################
use List::Util 'sum';
use Carp 'croak';

has name               => qw(is ro required 1);
has players            => qw(is ro), default => sub { [] };
has formation          => qw(is rw required 1 trigger 1);

has attacker_indices   => qw(is rwp);
has defender_indices   => qw(is rwp);
has goalkeeper_indices => qw(is rwp);
has midfielder_indices => qw(is rwp);

sub _trigger_formation($self, $formation) {
    croak "formation is a single integer"
      unless @_ == 2;

    my @formation = split //, $formation;
    croak "formation must be three digit integer whose digits sum to 10"
      unless $formation =~ /^\d{3}$/ and sum(@formation) == 10;

    my @indices = [0];

    my $start = 1;
    for my $count (@formation) {
        push @indices, [ $start .. $start + $count - 1 ];
        $start += $count;
    }

    $self->_set_goalkeeper_indices( $indices[0] );
    $self->_set_defender_indices  ( $indices[1] );
    $self->_set_midfielder_indices( $indices[2] );
    $self->_set_attacker_indices  ( $indices[3] );
}

sub add_player($self, $player) {
    push $self->players->@*, $player
}

sub goalkeeper_rating($self) {
    return sum map( { $_->goalkeeper_skill } $self->goalkeeper );
}

sub defence_rating($self) {
    return sum map( { $_->defence_skill     } $self->defenders ),
               map( { $_->defence_skill / 2 } $self->midfielders )
}

sub midfield_rating($self) {
    return sum map( { $_->midfield_skill } $self->midfielders )
}

sub attack_rating($self) {
    return sum map( { $_->attack_skill     } $self->attackers),
               map( { $_->attack_skill / 2 } $self->midfielders )
}

sub goalkeeper($self)  { @{$self->players}[$self->goalkeeper_indices->@*] }
sub defenders($self)   { @{$self->players}[$self->defender_indices->@*  ] }
sub midfielders($self) { @{$self->players}[$self->midfielder_indices->@*] }
sub attackers($self)   { @{$self->players}[$self->attacker_indices->@*  ] }

1;
