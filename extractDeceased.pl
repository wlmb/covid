#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(say);
use Spreadsheet::Read;
use Getopt::Long;
use List::Util qw{sum0};

my $sheetname;
my $id;
my $ws;
GetOptions("sheet=s"=>\$sheetname, "id=s"=>\$id, "ws=i"=>\$ws) or usage('Bad options');
usage("missing --sheet") unless defined $sheetname;
usage("missing --ws") unless defined $ws;
usage("ws should be positive") unless $ws>0;
$id=lc $id;
my $book=Spreadsheet::Read->new($sheetname);
my $sheet=$book->sheet(1);
my $maxcol=$sheet->maxcol;
my $maxrow=$sheet->maxrow;
my @colnames=$sheet->row(1);
#dateRep, day, month, year, cases, deaths, countriesAndTerritories,
#geoId, countryterritoryCode, popData2018
my %cols;
map {$cols{lc $colnames[$_]}=$_} (0..$maxcol-1);
#say "maxcol $maxcol maxrow $maxrow";
my @data;
for my $r(2..$maxrow){
    my @row=$sheet->row($r);
    my $geoid=lc $row[$cols{geoid}];
    next unless $geoid eq $id;
    #next unless $row[$cols{cases}];
    push @data, [map {$row[$cols{$_}]} qw(day month year cases deaths)];
}
@data=reverse @data;
my $totalcases=0;
my @recent; #keep a few for a moving window average
foreach(@data){
    my ($day,$month,$year,$cases, $death)=@$_;
    $totalcases+=$cases;
    push @recent, $death;
    next if scalar @recent <=$ws;
    shift @recent;
    my $avg=sum0(@recent)/@recent;
    say "$totalcases $avg";
}


sub usage{
    say @_;
    say <<FIN;
    GetOptions("sheet=s"=>\$sheetname, "id=s"=>\$id, "ws=>i"=>\$ws)
FIN
    exit 1;
}
