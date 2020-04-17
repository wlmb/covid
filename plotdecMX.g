#!/usr/bin/gnuplot -persist
#
#
#    	G N U P L O T
#    	Version 5.2 patchlevel 8    last modified 2019-12-01
#
#    	Copyright (C) 1986-1993, 1998, 2004, 2007-2019
#    	Thomas Williams, Colin Kelley and many others
#
#    	gnuplot home:     http://www.gnuplot.info
#    	faq, bugs, etc:   type "help FAQ"
#    	immediate help:   type "help"  (plot window: hit 'h')
# set terminal qt 0 font "Sans,9"
# set output
date="`date -I`"
unset clip points
set clip one
unset clip two
set errorbars front 1.000000
set border 31 front lt black linewidth 1.000 dashtype solid
set zdata
set ydata
set xdata
set y2data
set x2data
set boxwidth
set style fill  empty border
set style rectangle back fc  bgnd fillstyle   solid 1.00 border lt -1
set style circle radius graph 0.02
set style ellipse size graph 0.05, 0.03 angle 0 units xy
set dummy x, y
set format x "% h"
set format y "% h"
set format x2 "% h"
set format y2 "% h"
set format z "% h"
set format cb "% h"
set format r "% h"
set ttics format "% h"
set timefmt "%d/%m/%y,%H:%M"
set angles radians
set tics back
unset grid
unset raxis
set theta counterclockwise right
set style parallel front  lt black linewidth 2.000 dashtype solid
set key title "" center
set key fixed left top vertical Left noreverse enhanced autotitle nobox
set key noinvert samplen 4 spacing 1 width 0 height 0
set key maxcolumns 0 maxrows 12
set key noopaque
unset label
unset arrow
set style increment default
unset style line
unset style arrow
set style histogram clustered gap 2 title textcolor lt -1
unset object
set style textbox transparent margins  1.0,  1.0 border  lt -1 linewidth  1.0
set offsets 0, 0, 0, 0
set pointsize 1
set pointintervalbox 1
set encoding default
unset polar
unset parametric
unset decimalsign
unset micro
unset minussign
set view 60, 30, 1, 1
set view azimuth 0
set rgbmax 255
set samples 100, 100
set isosamples 10, 10
set surface
unset contour
set cntrlabel  format '%8.3g' font '' start 5 interval 20
set mapping cartesian
set datafile separator whitespace
unset hidden3d
set cntrparam order 4
set cntrparam linear
set cntrparam levels 5
set cntrparam levels auto
set cntrparam firstlinetype 0 unsorted
set cntrparam points 5
set size ratio 0 1,1
set origin 0,0
set style data points
set style function lines
unset xzeroaxis
unset yzeroaxis
unset zzeroaxis
unset x2zeroaxis
unset y2zeroaxis
set xyplane relative 0.5
set tics scale  1, 0.5, 1, 1, 1
set mxtics default
set mytics default
set mztics default
set mx2tics default
set my2tics default
set mcbtics default
set mrtics default
set nomttics
set xtics border in scale 1,0.5 mirror norotate  autojustify
set xtics  norangelimit logscale autofreq
set ytics border in scale 1,0.5 mirror norotate  autojustify
set ytics  norangelimit logscale autofreq
set ztics border in scale 1,0.5 nomirror norotate  autojustify
set ztics  norangelimit logscale autofreq
unset x2tics
unset y2tics
set cbtics border in scale 1,0.5 mirror norotate  autojustify
set cbtics  norangelimit logscale autofreq
set rtics axis in scale 1,0.5 nomirror norotate  autojustify
set rtics  norangelimit autofreq
unset ttics
set title "Promedio con ventana móvil de 7 días ". date
set title  font "" textcolor lt -1 norotate
set timestamp bottom
set timestamp ""
set timestamp  font "" textcolor lt -1 norotate
set trange [ * : * ] noreverse nowriteback
set urange [ * : * ] noreverse nowriteback
set vrange [ * : * ] noreverse nowriteback
set xlabel "Decesos totales"
set xlabel  font "" textcolor lt -1 norotate
set x2label ""
set x2label  font "" textcolor lt -1 norotate
set xrange [ * : * ] noreverse writeback
set x2range [ * : * ] noreverse writeback
set ylabel "Decesos diarios"
set ylabel  font "" textcolor lt -1 rotate
set y2label ""
set y2label  font "" textcolor lt -1 rotate
set yrange [ * : * ] noreverse writeback
set y2range [ * : * ] noreverse writeback
set zlabel ""
set zlabel  font "" textcolor lt -1 norotate
set zrange [ * : * ] noreverse writeback
set cblabel ""
set cblabel  font "" textcolor lt -1 rotate
set cbrange [ * : * ] noreverse writeback
set rlabel ""
set rlabel  font "" textcolor lt -1 norotate
set rrange [ * : * ] noreverse writeback
unset logscale
set logscale z 10
set logscale y 10
set logscale x 10
set logscale cb 10
set logscale y2 10
set logscale x2 10
unset jitter
set zero 1e-08
set lmargin  -1
set bmargin  -1
set rmargin  -1
set tmargin  -1
set locale "en_US.utf8"
set pm3d explicit at s
set pm3d scansautomatic
set pm3d interpolate 1,1 flush begin noftriangles noborder corners2color mean
set pm3d nolighting
set palette positive nops_allcF maxcolors 0 gamma 1.5 color model RGB
set palette rgbformulae 7, 5, 15
set colorbox default
set colorbox vertical origin screen 0.9, 0.2 size screen 0.05, 0.6 front  noinvert bdefault
set style boxplot candles range  1.50 outliers pt 7 separation 1 labels auto unsorted
set loadpath
set fontpath
set psdir
set fit brief errorvariables nocovariancevariables errorscaling prescale nowrap v5
GNUTERM = "qt"
## Last datafile plotted: "estados.txt"
int=3
plot 'estados.txt' index 0 u 3:4 w lp pi int  ti "Ags",\
        '' index 1 u 3:4 w lp pi int  ti "BC",\
        '' index 2 u 3:4 w lp pi int  ti "BCS",\
        '' index 3 u 3:4 w lp pi int  ti "Camp",\
        '' index 4 u 3:4 w lp pi int  ti "Chiapas",\
        '' index 5 u 3:4 w lp pi int  ti "Chih",\
        '' index 6 u 3:4 w lp pi int  ti "CdMx",\
        '' index 7 u 3:4 w lp pi int  ti "Coah",\
        '' index 8 u 3:4 w lp pi int  ti "Col",\
        '' index 9 u 3:4 w lp pi int  ti "Dur",\
        '' index 10 u 3:4 w lp pi int  ti "Gto",\
        '' index 11 u 3:4 w lp pi int  ti "Gro",\
        '' index 12 u 3:4 w lp pi int  ti "Hid",\
        '' index 13 u 3:4 w lp pi int  ti "Jal",\
        '' index 14 u 3:4 w lp pi int  ti "Mex",\
        '' index 15 u 3:4 w lp pi int  ti "Mich",\
        '' index 16 u 3:4 w lp pi int  ti "Mor",\
        '' index 17 u 3:4 w lp pi int  ti "Nay",\
        '' index 18 u 3:4 w lp pi int  ti "NL",\
        '' index 19 u 3:4 w lp pi int  ti "Oax",\
        '' index 20 u 3:4 w lp pi int  ti "Pue",\
        '' index 21 u 3:4 w lp pi int  ti "Que",\
        '' index 22 u 3:4 w lp pi int  ti "QRoo",\
        '' index 23 u 3:4 w lp pi int  ti "SLP",\
        '' index 24 u 3:4 w lp pi int  ti "Sin",\
        '' index 25 u 3:4 w lp pi int  ti "Son",\
        '' index 26 u 3:4 w lp pi int  ti "Tab",\
        '' index 27 u 3:4 w lp pi int  ti "Tam",\
        '' index 28 u 3:4 w lp pi int  ti "Tlax",\
        '' index 29 u 3:4 w lp pi int  ti "Ver",\
        '' index 30 u 3:4 w lp pi int  ti "Yuc",\
        '' index 31 u 3:4 w lp pi int  ti "Zac"

#    EOF
