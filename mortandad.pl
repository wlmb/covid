#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(say);
use Text::CSV_XS;

my $file="../datosAbiertos/INEGI_Exporta_20200422183612.csv";

my $csv=Text::CSV_XS->new({binary=>1, auto_diag=>1});
open my $fh, "<:encoding(utf8)", $file or die "$file: $!";
my $count=0;
my @anhos;
my @monthnames=qw(Enero Febrero Marzo Abril Mayo Junio Julio Agosto
    Septiembre Octubre Noviembre Diciembre);
my %monthnumbers=map {($monthnames[$_], sprintf("%02d",$_+1))} (0..11);
my %data;
while (my $row=$csv->getline($fh)){
    ++$count;
    next if $count<=6; #skip heading
    next if $count>=21; #skip trailer
    if($count==7){ # fetch years;
	@anhos=@$row;
	pop @anhos;
	shift @anhos;
	next;
    }
    my ($month,@data)=@$row;
    @data=map {s/,//g; $_} @data;
    next if $month eq "Total";
    $data{"$anhos[$_]-$monthnumbers{$month}"}=$data[$_] foreach
	(0..scalar @data-1);
}
say "$_ $data{$_}" foreach sort {$a cmp $b} keys %data;
