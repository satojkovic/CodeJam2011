#!perl

use strict;
use warnings;

my $f = shift;
open my $fh, '<', $f or die "cannot open file : $!";

## 問題数
my $T = <$fh>;

my $cnt = 1;
while( my $line = <$fh> ) {
    chomp($line);

    # M, C, W
    my ($M, $C, $W) = split(/ /, $line);

    # make card2pos and pos2card hash array
    my @card2pos; my @pos2card;
    init($M, \@card2pos, \@pos2card);

    # swap
    for(my $i=1; $i<=$C; $i++) {
        $line = <$fh>;
        chomp($line);
        my ($A, $B) = split(/ /, $line);

        swap($M, \@card2pos, \@pos2card, $A, $B);
    }
    
    # answer
    my $slot = whichslot($W);
    my $card = $pos2card[$slot]->{"$W"};
    if( !defined($card) ) { print "error $M, $C, $W\n"; next; }
    print "Case #$cnt: $card\n";

    $cnt++;
}

sub swap {
    my ($M, $c2p_ptr, $p2c_ptr, $A, $B) = @_;

    # $Aよりも手前のカードはpos+B
    posadd($M, $c2p_ptr, $p2c_ptr, $A, $B);
    
    # $Aから$A+$B-1までのカードは1,2...とする
    postop($M, $c2p_ptr, $p2c_ptr, $A, $B);

    # c2p_ptrに基づきp2c_ptrを更新
    update($M, $c2p_ptr, $p2c_ptr);
}

sub update {
    my ($M, $c2p_ptr, $p2c_ptr) = @_;

    for(my $c=1; $c<=$M; $c++) {
        update_core($M, $c2p_ptr, $p2c_ptr, $c);
    }
}

sub update_core {
    my ($M, $c2p_ptr, $p2c_ptr, $c) = @_;

    my $slot = whichslot($c);

    # card -> pos
    my $pos = $c2p_ptr->[$slot]->{"$c"};
    # pos -> card update
    $p2c_ptr->[$slot]->{"$pos"} = $c;
}

sub posadd {
    my ($M, $c2p_ptr, $p2c_ptr, $A, $B) = @_;
    
    # 1から$A-1までのposのカードにプラスB
    # ただし、$A+$B-1>$Mの場合には
    my $cnt = 1;
    for(my $p=$cnt; $p<$A; $p++) {
        posadd_core($p, $c2p_ptr, $p2c_ptr, $B);
    }
}

sub postop {
    my ($M, $c2p_ptr, $p2c_ptr, $A, $B) = @_;

    for(my $p=$A; $p<=($A+$B-1); $p++) {
        postop_core($p, $c2p_ptr, $p2c_ptr, $A); 
    }
}

sub postop_core {
    my ($p, $c2p_ptr, $p2c_ptr, $A) = @_;

    my $slot = whichslot($p);

    # pos -> card
    my $card = $p2c_ptr->[$slot]->{"$p"};
    # card -> pos = ($p - $A + 1)
    $c2p_ptr->[$slot]->{"$card"} = $p - $A + 1;
}

sub whichslot {
    my $p = shift;
    my $slot;

    if( $p <= 10**4 ) { $slot = 0; }
    elsif( $p <= 10**5 ) { $slot = 1; }
    elsif( $p <= 10**6 ) { $slot = 2; }
    elsif( $p <= 10**7 ) { $slot = 3; }
    elsif( $p <= 10**8 ) { $slot = 4; }
    elsif( $p <= 10**9 ) { $slot = 5; }

    return $slot;
}

sub posadd_core {
    my ($p, $c2p_ptr, $p2c_ptr, $B) = @_;
    
    my $slot = whichslot($p);
    
    # pos -> card
    my $card = $p2c_ptr->[$slot]->{"$p"};
    # card -> pos + 1
    $c2p_ptr->[$slot]->{"$card"} += $B;
}

sub init {
    my ($M, $c2p_ptr, $p2c_ptr) = @_;

    my $slot = whichslot($M);

    my %h = (
        "0" => 4,
        "1" => 5,
        "2" => 6,
        "3" => 7,
        "4" => 8,
        "5" => 9
        );
    my $cnt = 1;
    for(my $s=0; $s<$slot; $s++) {
        $cnt = pushdata($cnt, 10**$h{"$s"}, $c2p_ptr, $p2c_ptr);
    }
    pushdata($cnt, $M, $c2p_ptr, $p2c_ptr);
}

sub pushdata {
    my ($cnt, $M, $c2p_ptr, $p2c_ptr) = @_;
    
    my %h;
    while( $cnt <= $M ) {
        $h{"$cnt"} = $cnt;
        $cnt++;
    }
    my %h2 = %h;
    push(@$c2p_ptr, \%h);
    push(@$p2c_ptr, \%h2);

    return $cnt;
}
