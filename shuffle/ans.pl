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

    # cards
    my @cards = (1..$M);
    
    # swap
    for(my $i=1; $i<=$C; $i++) {
        $line = <$fh>;
        chomp($line);
        my ($A, $B) = split(/ /, $line);

        my @part = splice(@cards, $A-1, $B);
        push(@part, @cards);
        @cards = @part;
    }
    
    # answer
    print "Case #$cnt: " . $cards[$W-1] . "\n";

    $cnt++;
}
