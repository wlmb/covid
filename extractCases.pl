#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(say);
use Spreadsheet::Read;
use Getopt::Long;
use List::Util qw{sum0 none};

my $site= "https://www.ecdc.europa.eu/sites/default/files/documents/";
my $sheetname;
my $ids;
my $ws;
GetOptions("sheet=s"=>\$sheetname, "ids=s"=>\$ids, "ws=i"=>\$ws) or usage('Bad options');
usage("missing --sheet") unless defined $sheetname;
usage("missing --ws") unless defined $ws;
usage("ws should be positive") unless $ws>0;
$ids=lc $ids;
my @ids=split /\s*,\s*/, $ids;
system "wget $site$sheetname" unless -r $sheetname;
my $book=Spreadsheet::Read->new($sheetname) or die "Couldn't open spreadsheet";
my $sheet=$book->sheet(1);
my $maxcol=$sheet->maxcol;
my $maxrow=$sheet->maxrow;
my @colnames=$sheet->row(1);
#dateRep, day, month, year, cases, deaths, countriesAndTerritories,
#geoId, countryterritoryCode, popData2018
my %cols;
map {$cols{lc $colnames[$_]}=$_} (0..$maxcol-1);
#say "maxcol $maxcol maxrow $maxrow";
my %data;
for my $r(2..$maxrow){
    my @row=$sheet->row($r);
    my $geoid=lc $row[$cols{geoid}];
    next if none {$_ eq $geoid} @ids;
    #next unless $row[$cols{cases}];
    push @{$data{$geoid}}, [map {$row[$cols{$_}]} qw(day month year cases deaths)];
}

for my $id(@ids){
    open (OUT, "> $id.txt") or die "Couldn't open $id.txt";
    my @data=@{$data{$id}};
    @data=reverse @data;
    my $totalcases=0;
    my @recent; #keep a few for a moving window average
    foreach(@data){
	my ($day, $month, $year, $cases, $deaths)=@$_;
	$totalcases+=$cases;
	push @recent, [($cases, $deaths)];
	next if scalar @recent <=$ws;
	shift @recent;
	my @avg=map {my $i=$_; sum0(map {$_->[$i]} @recent)/@recent} (0,1);
	say OUT join " ", $totalcases, @avg;
    }
}



sub usage{
    say @_;
    say <<FIN;
    GetOptions("sheet=s"=>\$sheetname, "ids=s"=>\$ids, "ws=>i"=>\$ws)
FIN
    exit 1;
}
