#!perl

use strict;
use warnings;

## テーブルを参照して解答する
my $txt = "10_0-10_4.txt";
open my $th, '<', $txt or die "cannot open $txt... : $!";

my %table;
while( my $line = <$th> ) {
    chomp($line);
    my ($num, $cnt) = split(/ /, $line);
    $table{$num} = $cnt;
}

## 問題ファイル
my $f = $ARGV[0];
if( !defined($f) ) { die "please specify the input file... : $!"; }
open my $fh, '<', $f or die "cannot open $f... : $!";

## 問題数
my $T = <$fh>; #print $T;
chomp($T);

## 解答
my $case = 1;
while( $case <= $T ) {

    my $N = <$fh>;
    my $P = f($N);

    print "Case #$case: $P\n";

    $case++;
}

sub f {
    my $num = shift;

    my $max = 0;

    for(my $i=0; $i <= int($num / 2); $i++ ) {
        my $cand = $table{$i} + $table{$num-$i};

        if( $max < $cand ) { $max = $cand; }
    }

    return $max;
}
