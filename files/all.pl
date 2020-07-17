#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(say);
use Getopt::Long;
use List::Util qw(none);

my $help;
my $download_1_flag;
my $download_7_flag;
my $download_mx_flag;
my $skip_extract_flag;
my $clean_flag;

my $options=q(
    1=>\$download_1_flag,     # Use non averaged data. Download if required
    7=>\$download_7_flag,     # Use 7 day moving average. Download if req.
    m=>\$download_mx_flag,    # Download Mexico's data
    s=>\$skip_extract_flag,   # Skip (slow) extract phase
    c=>\$clean_flag,          # Clean all rem temporal files
    'h|help|?'=>\$help,       # Print help.
);
my %options=(eval $options); # not kosher but simple
die "Bad option definition: $@" if $@;
GetOptions(
	   %options
    )
    or usage($options, "Bad options");
usage($options, "Usage") if $help;
usage($options, "Usage") if none {defined ${$_}} values %options;


chomp(my $today=`date -I`);
die "Date failed" unless defined $today;

if($download_1_flag){
    if(!$skip_extract_flag){
	!system("./extractCases.pl --date $today -ws 1 "
		. "-ids kr,cn,es,it,ru,us,jp,ar,pe,pa,co,mx,de,se,ua,br " .
		" --rt=6.08"
	    ) or die "extractCases failed";
    }
    !system "gnuplot gompertz.g" or die "gnuplot gompertz.g failed";
    !system "gnuplot gompertzdec.g" or die "gnuplot gompertzdec.g failed";
    !system "./gompertzAnimate.pl" or die "./gompertzAnimate failed";
}

if($download_7_flag){
    if(!$skip_extract_flag){
	!system("./extractCases.pl --date $today -ws 7 "
		. "-ids kr,cn,es,it,ru,us,jp,ar,pe,pa,co,mx,de,se,ua,br " .
		" --rt=6.08"
	    ) or die "extractCases failed";
    }
    !system "gnuplot plotcases.g" or die "gnuplot plotcases.g failed";
    !system "gnuplot plotdec.g" or die "gnuplot plotdec.g failed";
    !system "gnuplot plotcasesN.g" or die "gnuplot plotcasesN.g failed";
    !system "gnuplot plotdecN.g" or die "gnuplot plotdecN.g failed";
    !system "gnuplot plotdecvsdec.g" or die "gnuplot plotdecvsdec.g failed";
    !system "gnuplot plotsick.g" or die "gnuplot plotsick.g failed";
}
if($download_mx_flag){
    !system "cd latam; git pull; cd .." or die "git failed";
    !system "./extractMX.pl -dir latam -ws=7 >states.txt"
	or die "extactMX.pl failed";
    !system "gnuplot plotcasesMX.g" or die "gnuplot plotcasesMX.g failed";
    !system "gnuplot plotdecMX.g" or die "gnuplot plotdecMX.g failed";
}
if($clean_flag){
    !system "rm rem*.png rem*.txt" or die "Clean rem files failed";
}


sub usage {
    my ($options, $message)=@_;
    say $message;
    say $options;
    die;
}
