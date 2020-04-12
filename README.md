# COVID

Programs to visualize data on covid-19

It includes the following

* extractCases.pl

  Program to download (if necessary) a *European CDC* database listing
  the worldwide distribution  of covid-19 cases and deceases, choose
  some countries and prepare some files for easy plotting of the
  results.

  To run the program you need a perl compiler/interpreter and the
  perl packages Spreadsheet::Read, Spreadsheet::XLSX, Getopt::Long and
  List::Util. You might also need the programs wget, libreoffice and gnuplot.

  Run it without arguments or with the argument --help to get
  instruccions: `perl extractCases.pl --help`.

  The result is a list of files that can be fed to gnuplot for
  plotting

* plotcases.g, plotdec.g, plotcasesN.g, plotdecN.g

  Gnuplot commands that may be loaded by the gnuplot program to plot
  the number of new cases and new deseased as a function of the total
  number of cases. `load 'plotcases.g'` and `load 'plotdec.g'`. May
  need editing according to your choice of countries and the
  positioning of labels and arrows. The names with an *N* plot the
  same information, but normalized to the total population of the
  country.


* mx.txt, us.txt, cn.txt...

  Extracted data files for some countries. They consist of space
  separated columns (appropriate for using as gnuplot's input) with
  1-the accumulated number of confirmed cases
  2-the daily number of confirmed cases
  3-daily number of deceased
  4-the daily number of confirmed cases divided by population
  5-daily number of deceased divided by population

* cases.png dec.png casesN.png decN.png

  Plots of data: daily cases, daily deceases, and the same but
  normalized to population.

## Author

   - W. Luis Mochán  `mochan@fis.unam.mx`

## Licence

This software is copyright (c) 2020 by W. Luis Mochán.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

## Acknowledgment

This work was partially supported by DGAPA-UNAM under grant IN111119.
