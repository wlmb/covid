#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(say);
use Getopt::Long;
use Scalar::Util qw(looks_like_number);
my $dir; #directory with data.
my $ws; #user supplied averaging window size
my $help; #help flag
sub usage(;$);

GetOptions("dir=s"=>\$dir, "ws=i"=>\$ws, "help|?"=>\$help) or usage ('Bad options');
usage if $help;
usage "Missing directory" unless defined $dir;
usage "$dir is not a directory" unless -d $dir;
usage("missing --ws") unless defined $ws;
usage("ws should be positive") unless $ws>0;
opendir DIR, $dir or die "Couldn't open directory $dir";
my @files=sort grep /^2020/, readdir(DIR);
my %todos;
for my $file(@files){
    open DATA, "<", "$dir/$file" or die "Couldn't open $file";
    while(<DATA>){
	chomp;
	next unless /^MX/;
	my ($code,$name,$state,$date,$cases,$deceased,$recovered)=map {lc $_} split /,/;
	next unless defined $cases and defined $deceased
	    and looks_like_number $cases and looks_like_number($deceased);
	push @{$todos{$state}},[$cases, $deceased];
    }
}
for my $state (sort {$a cmp $b} keys %todos) {
    say "\n\n# $state";
    my @data=@{$todos{$state}};
    my @recent; #fifos
    my ($prevcases, $prevdec)=(0,0);
    for my $datum (@data) {
	my ($cases, $deceased)=($datum->[0], $datum->[1]);
	next unless $cases>=$prevcases and $deceased >= $prevdec;
	($prevcases, $prevdec)=($cases, $deceased);
	push @recent, [($cases, $deceased)]; #push into fifo
	next if scalar @recent <= $ws; #wait for fifo to grow
	my $old=shift @recent;
	my ($oldcases, $olddeceased)=@$old;
	my $dailycases=($cases-$oldcases)/$ws;
	my $dailydeceased=($deceased-$olddeceased)/$ws;
	say "$cases $dailycases $deceased $dailydeceased";
    }
}


sub usage (;$){
    say STDERR @_;
    say STDERR <<FIN;
Usage:

    ./extractMX.pl --dir=latam_covid-data

    Extracts information about the COVID-19 pandemic in Mexico using data from
    https://github.com/DataScienceResearchPeru/covid-19_latinoamerica.git

    Options:
        --dir    local directory where the data files are located
FIN
    exit 1;
}
