# COVID

Programs to visualize data on covid-19

In includes the following

* extractCases.pl

  Program to download (if necessary) a *European CDC* database listing
  the worldwide distribution  of covid-19 cases and deceases, choose
  some countries and prepare some files for easy plotting of the
  results.

  To run the program you need a perl compiler/interpreter and the
  packages Spreadsheet::Read, Spreadsheet::XLSX, Getopt::Long and
  List::Util. You might also need the program wget and libreoffice.

  Run it without arguments or with the argument --help to get
  instruccions: `perl extractCases.pl -h`.

  The result is a list of files that can be fed to gnuplot for
  plotting

* plotcases.g, plotdec.g

  Gnuplot commands that may be loaded by the gnuplot program to plot
  the number of new cases and new deseased as a function of the total
  number of cases. `load 'plotcases.g'` and `load 'plotdec.g'`. May
  need editing according to your choice of countries and the
  positioning of labels and arrows.


This software is copyright (c) 2016 by W. Luis Mochán.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

This work was partially supported by DGAPA-UNAM under grant IN111119.

## Author ##

   - W. Luis Mochán  `mochan@fis.unam.mx`