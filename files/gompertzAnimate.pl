#!/usr/bin/env perl
use warnings;
use strict;
use feature qw(say);

my ($lines)=split ' ', `wc -l mx.txt`;
for my $day (113..$lines){
    my $out_filename=sprintf("rem%03d.txt", $day);
    system "head -$day mx.txt|tail -n +62  >$out_filename";
}
!system "gnuplot gompertzAnimate.g" or die "gnuplot gompertzAnimate.g failed";
!system
    "convert -delay 100 -loop 5 -dispose previous "
    . " rem*.png animateGompertz.gif"
    or die "convert failed";
!system "gnuplot gompertzK.g" or die "gnuplot gompertzK.g failed";
