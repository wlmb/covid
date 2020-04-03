#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(say);
use Spreadsheet::Read;
use Getopt::Long;
use List::Util qw{sum0 none};

# Not sure if the site address or the name prefix will work allways. Check.
#Downloads address
my $site= "https://www.ecdc.europa.eu/sites/default/files/documents/";
#File name. Notice orthograpic mistake. Might have to change.
my $nameprefix0="COVID-19-geographic-disbtribution-worldwide-";
my $nameprefix1="COVID-19-geographic-distribution-worldwide-";
my $sheetname; #user supplied and actual sheetname
my $date; #user supplied date
my $ids; #user supplied comma separated country codes
my $ws; #user supplied averaging window size
my $help; #help flag
GetOptions("sheet=s"=>\$sheetname, "date=s"=>\$date, "ids=s"=>\$ids,
	   "ws=i"=>\$ws, "help|?"=>\$help) or usage('Bad options');
# check options
usage() if $help;
usage("missing --sheet or --date") unless defined $sheetname or
    defined $date;
usage("Only one of --sheet or --date allowed") if defined $sheetname
    and defined $date;
usage("missing --ws") unless defined $ws;
usage("ws should be positive") unless $ws>0;
usage("missing country ids") unless defined $ids;
$ids=lc $ids; #normalize to lower case
my @ids=split /\s*,\s*/, $ids; #get list of comma separated codes.
# possible sheet names (accounting for orthographic mistake above)
my ($sheetname0, $sheetname1)=map {"$_$date.xlsx"} ($nameprefix0,$nameprefix1) if defined $date;
# test each possible sheetname
foreach($sheetname, $sheetname0, $sheetname1){
    next unless defined;
    $sheetname=$_,last if -r $_; #already downloaded
    $sheetname=$_,last if system("wget", "$site$_")==0; #download it
}
my $book=Spreadsheet::Read->new($sheetname) or die "Couldn't open spreadsheet";
my $sheet=$book->sheet(1);
my $maxcol=$sheet->maxcol;
my $maxrow=$sheet->maxrow;
my @colnames=$sheet->row(1);
#dateRep, day, month, year, cases, deaths, countriesAndTerritories,
#geoId, countryterritoryCode, popData2018
my %cols;
map {$cols{lc $colnames[$_]}=$_} (0..$maxcol-1); #array of column names
#say "maxcol $maxcol maxrow $maxrow";
my %data;
for my $r(2..$maxrow){
    my @row=$sheet->row($r);
    my $geoid=lc $row[$cols{geoid}];
    next if none {$_ eq $geoid} @ids; #skip other countries
    # one data array for each country
    # each entry is an array of values: day month year cases deaths
    push @{$data{$geoid}}, [map {$row[$cols{$_}]} qw(day month year cases deaths)];
}

for my $id(@ids){ #for each country
    #writed one file per country
    open (OUT, "> $id.txt") or die "Couldn't open $id.txt";
    my @data=@{$data{$id}}; #country data
    @data=reverse @data; #put in temporal order
    my $totalcases=0;
    my @recent; #keep a fifo for the moving window average
    foreach(@data){
	my ($day, $month, $year, $cases, $deaths)=@$_; #fetch data
	$totalcases+=$cases; #accumulate
	push @recent, [($cases, $deaths)]; #push into fifo
	next if scalar @recent <=$ws; #wait for fifo to grow
	shift @recent; #throw oldest
	#average new cases and deaths
	my @avg=map {my $i=$_; sum0(map {$_->[$i]} @recent)/@recent}(0,1);
	say OUT join " ", $totalcases, @avg; #write to output file.
    }
}



sub usage{
    say @_;
    say <<FIN;
Usage:

    ./extractCases.pl --date 2020-02-25 --ids=cn,de,es,it,jp,kr,mx,ru,us --ws=5
    ./extractCases.pl \
       --sheet COVID-19-geographic-disbtribution-worldwide-2020-02-25.xlsx \
       --ids=cn,de,es,it,jp,kr,mx,ru,us --ws=5

    Extracts information about the COVID-19 pandemic

    Downloads (if necessary) a data sheet from the European CDC and
    extracts info for the desired countries and writes them into
    country-named files such as cn.txt, es.txt, etc. in three columns:
    total number of cases, averaged number of daily cases and averaged
    number of deceases.

    Options:
        --sheet  Filename of sheet to download
        --date   iso formatted date of the sheet to download
        --ids    Comma separated iso 2-letter country-codes of desired countries
        --ws     Size of the moving average window. 1 means don't average.
FIN
    exit 1;
}
