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
set key fixed right top vertical Right noreverse enhanced autotitle nobox
set key noinvert samplen 4 spacing 1 width 0 height 0
set key maxcolumns 0 maxrows 0
set key noopaque
unset key
unset label
set label 1 "EUA" at 84540, 231 right norotate back nopoint
set label 2 "China" at 77504.0, 25.0000, 0.00000 right norotate back nopoint
set label 3 "Korea" at 10554.00, 4.3 left norotate back nopoint
set label 4 "España" at 24684, 153 left norotate back nopoint
set label 5 "Italia" at 8571,91 right norotate back nopoint
set label 6 "México" at 307,3.67 right norotate back nopoint
set label 7 "Rusia" at 3904.00, 1.37, 0.00000 left norotate back nopoint
set label 8 "Japón" at 2502, 4.01, 0.00000 left norotate back nopoint
unset arrow
set arrow 4 from 31283,126 to 16316,107
set arrow 6 from 307,3.67 to 693.7,2 head back nofilled linewidth 1.000 dashtype solid
set arrow 7 from 3904, 1.37 to 1537,1.37
set arrow 8 from 2500, 4 to 1187, 2.61 head back nofilled linewidth 1.000 dashtype solid
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
set title "Promedio con ventana móvil de 5 días " . date
set title  font "" textcolor lt -1 norotate
set timestamp bottom
set timestamp ""
set timestamp  font "" textcolor lt -1 norotate
set trange [ * : * ] noreverse nowriteback
set urange [ * : * ] noreverse nowriteback
set vrange [ * : * ] noreverse nowriteback
set xlabel "Casos totales confirmados"
set xlabel  font "" textcolor lt -1 norotate
set x2label ""
set x2label  font "" textcolor lt -1 norotate
set xrange [ 100 : * ] noreverse writeback
set x2range [ * : * ] noreverse writeback
set ylabel "Decesos diarios promediados"
set ylabel  font "" textcolor lt -1 rotate
set y2label ""
set y2label  font "" textcolor lt -1 rotate
set yrange [ 1 : * ] noreverse writeback
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
set linetype 7 linewidth 2
GNUTERM = "qt"
## Last datafile plotted: "jp.txt"
#plot "kr-dec.txt" u 1:2 w l, "cn-dec.txt" u 1:2 w l, "es-dec.txt" u 1:2 w l, "it-dec.txt" u 1:2 w l, "mx-dec.txt" u 1:2 w l, "us-dec.txt" u 1:2 w l, "ru-dec.txt" u 1:2 w l, "jp-dec.txt" u 1:2 w l
plot "kr.txt" u 1:3 w l, "cn.txt" u 1:3 w l, "es.txt" u 1:3 w l, "it.txt" u 1:3 w l, "ru.txt" u 1:3 w l, "us.txt" u 1:3 w l, "mx.txt" u 1:3 w l, "jp.txt" u 1:3 w l
#    EOF
