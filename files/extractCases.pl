#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(say);
#use Spreadsheet::Read;
use Text::CSV;
use Getopt::Long;
use List::Util qw{sum0 none all};

# Not sure if the site address or the name prefix will work allways. Check.
#Downloads address
#my $site= "https://www.ecdc.europa.eu/sites/default/files/documents/";
#File name. Notice orthograpic mistake. Might have to change.
my $nameprefix0="COVID-19-geographic-disbtribution-worldwide-";
#my $nameprefix1="COVID-19-geographic-distribution-worldwide-";
my $sheetname; #user supplied and actual sheetname
my $date; #user supplied date
my $ids; #user supplied comma separated country codes
my $ws; #user supplied averaging window size
my $rt; #user supplied average recovery time
my $help; #help flag
GetOptions("sheet=s"=>\$sheetname, "date=s"=>\$date, "ids=s"=>\$ids,
	   "ws=i"=>\$ws, "rt=f"=>\$rt, "help|?"=>\$help) or usage('Bad options');
# check options
usage() if $help;
usage("missing --sheet or --date") unless defined $sheetname or
    defined $date;
usage("Only one of --sheet or --date allowed") if defined $sheetname
    and defined $date;
usage("missing --ws") unless defined $ws;
usage("ws should be positive") unless $ws>0;
usage("missing --rt") unless defined $rt;
usage("rt should be positive") unless $rt>0;
usage("missing country ids") unless defined $ids;
my $factorrt=exp(-1/$rt); #daily percentage of recoveries.
$ids=lc $ids; #normalize to lower case
my @ids=split /\s*,\s*/, $ids; #get list of comma separated codes.
# possible sheet names (accounting for orthographic mistake above)
#my ($sheetname0, $sheetname1)=map {"$_$date.csv"} ($nameprefix0,$nameprefix1) if defined $date;
# test each possible sheetname
#foreach($sheetname, $sheetname0, $sheetname1){
#    next unless defined;
#    $sheetname=$_,last if -r $_; #already downloaded
#    $sheetname=$_,last if system("wget", "$site$_")==0; #download it
#}
$sheetname="${nameprefix0}_${date}.csv" if defined $date;
my $pagename="https://opendata.ecdc.europa.eu/covid19/casedistribution/csv/";
-r $sheetname # already downloaded
    or !system "wget -O $sheetname $pagename"
    or die "couldn't download $pagename";
#my $book=Spreadsheet::Read->new($sheetname) or die "Couldn't open spreadsheet";
#my $sheet=$book->sheet(1);
#my $maxcol=$sheet->maxcol;
#my $maxrow=$sheet->maxrow;
#my @colnames=$sheet->row(1);
my $sheet=Text::CSV->new({binary=>1});
open my $fh, "<:encoding(UTF-8)", $sheetname
    or die "Couldn't read spreadsheet $sheetname: $!";
my $colnames_ref=$sheet->getline($fh); #read all column names.
die "Couldn't read headers" unless defined $colnames_ref;
my  @colnames=map {lc $_} @{$colnames_ref};

# Validate headers
my %expected_headers_set;
map {$expected_headers_set{lc $_}=1} qw(
    dateRep day month year cases deaths countriesAndTerritories geoId
    countryterritoryCode popData2019 continentExp
    Cumulative_number_for_14_days_of_COVID-19_cases_per_100000
    );
die "unexpected header" unless all {$expected_headers_set{$_}} @colnames;

my $row={};
$sheet->bind_columns(\@{$row}{@colnames});
#my %cols;
#map {$cols{lc $colnames[$_]}=$_} (0..$maxcol-1); #array of column names
#say "maxcol $maxcol maxrow $maxrow";
my %data;
while($sheet->getline($fh)){
    my $geoid=lc $row->{geoid};
    next if none {$_ eq $geoid} @ids; #skip other countries
    # one data array for each country
    # each entry is an array of values: day month year cases deaths
    push @{$data{$geoid}},
	[map {$row->{$_}} qw(day month year cases deaths popdata2019)];
}

for my $id(@ids){ #for each country
    #writed one file per country
    open (OUT, "> $id.txt") or die "Couldn't open $id.txt";
    say OUT "# totalCases dailyCases dailyDeceased " .
	"totalCasesNormalized dailyCasesNormalized dailyDeceasedNormalized ",
	"totalDeceased Sick totalCasesAveraged totalDeathsAv";
    my @data=@{$data{$id}}; #country data
    @data=reverse @data; #put in temporal order
    my $totalcases=0;
    my $totaldeaths=0;
    my @recent=([0,0,0,0]) x $ws; #keep a fifo for the moving window average
    my $sick=0;
    foreach(@data){
	my ($day, $month, $year, $cases, $deaths, $popData2019)=@$_; #fetch data
	#Beware:spain had undefined deaths and negative cases 2020-05-25!
	$cases//=0;
	$deaths//=0;
	$totalcases+=$cases; #accumulate
	$totaldeaths+=$deaths;
	push @recent, [($cases, $deaths, $totalcases, $totaldeaths)]; #push into fifo
	shift @recent; #throw oldest
	#average new cases and deaths
	my @avg=map {my $i=$_; sum0(map {$_->[$i]} @recent)/@recent}(0..3);
	my ($casesAv, $deceasedAv, $totalCasesAv, $totalDeathsAv)=@avg;
	$sick=$factorrt*$sick+$cases; #remaining sick + new sick.
	say OUT join " ", $totalcases, $casesAv, $deceasedAv, (map {$_/$popData2019}
	($totalcases, $casesAv, $deceasedAv)), $totaldeaths, $sick,
	    $totalCasesAv, $totalDeathsAv,
	    (map {$_/$popData2019}($totalCasesAv, $totalDeathsAv));
	#write to output file. Order is historical accident.
    }
}



sub usage{
    say @_;
    say <<FIN;
Usage:

    ./extractCases.pl --date 2020-02-25 --ids=cn,de,es,it,jp,kr,mx,ru,us --ws=5
    ./extractCases.pl \
       --sheet COVID-19-geographic-disbtribution-worldwide-2020-02-25.xlsx \
       --ids=cn,de,es,it,jp,kr,mx,ru,us --ws=5 --rt=14

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
        --rt     Recovery time in days.
FIN
    exit 1;
}
