#!perl

use strict;
use warnings;

## Nまでの10進数の2進数を計算して1の個数を求める

my $s = $ARGV[0];
my $l = $ARGV[1];
if( !defined($s) || !defined($l) ) { die $!; }

my $cnt = 0;
my $Ns;
if( $s == 0 ) { $Ns = $s }
else { $Ns = 10 ** $s + 1; }
my $Nl = 10 ** $l;

for($cnt = $Ns; $cnt <= $Nl; $cnt++ ) {

    my $num = one_count($cnt);

    print "$cnt $num\n";
}

# decimal to binary and count one num
sub one_count {
    my $dec = shift;

    my $one_num = 0;
    my $q = $dec;
    my $r = 0;
    while(1)  {
        my $q_tmp = int($q / 2);
        $r = $q % 2;

        if( $r == 1 ) { $one_num++; }
        if( $q_tmp == 0 ) { last; }

        $q = $q_tmp;
    }

    return $one_num;
}
