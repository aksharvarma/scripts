#
# Gantt Chart maker using gnuplot that shows dependencies
# Modified from the basic demo file offered by gnuplot
#


$DATA << EOD
#Task no., Task, start,	end
1, Feasibility Analysis, 2016-01-21, 2016-01-31
2, Requirements Phase, 2016-01-31, 2016-02-22
3, Client Interviews, 2016-01-27, 2016-02-12      
4, SRS, 2016-02-14, 2016-02-19
5, Traceability Matrix, 2016-02-17, 2016-02-19
6, System Test Plan, 2016-02-18, 2016-02-22
7, Project Plan, 2016-02-15, 2016-02-18
8, SDLC decision, 2016-02-15, 2016-02-22
9, Design, 2016-02-23, 2016-03-10
10, High Level Design, 2016-02-23, 2016-03-03
11, Low Level Design, 2016-03-03, 2016-03-10
12, Coding and Unit Testing, 2016-03-10, 2016-04-10
13, Phase 1, 2016-03-10, 2016-03-28
14, Unit Testing (Phase 1), 2016-03-28, 2016-04-01
15, Phase 2, 2016-03-10, 2016-04-07
16, Unit Testing (Phase 2), 2016-04-07, 2016-04-10
17, Integration Testing, 2016-04-10, 2016-04-17
18, Installation and User Manual, 2016-04-17, 2016-04-24
19, Full Project, 2016-01-23, 2016-04-24
EOD

$DEPENDS << EOD
#date, task1, task2
2016-01-31, 1, 2
2016-02-22, 2, 9
2016-03-10, 9, 12
2016-04-10, 12, 17
2016-04-17, 17, 18
EOD

set datafile separator ","
set terminal png size 1366,768 #1920,1080
set output "gantt.png"
set xdata time
timeformat = "%Y-%m-%d"
set format x "%d\n%b"

set yrange [-1:] reverse

OneDay = strptime("%d","5")

set xtics OneDay nomirror
set xtics scale 2, 0.5
set mxtics 2
set ytics nomirror
set mytics 2
set grid xtics ytics mytics lw 2

unset key
set title "{/=15 Gantt Chart}"
set border 3

T(N) = timecolumn(N,timeformat)

set style arrow 1 filled size screen 0.02, 15 fixed lt 6 lw 4
set style arrow 2 nohead size screen 0.02, 15 fixed lt 7 lw 4

set key off

plot $DATA using (T(3)) : ($1) : (T(4)-T(3)) : (0) : yticlabel(2) with vector as 1, \
     $DEPENDS using (T(1)) : ($2) :(0) : ($3-$2) with vector as 2
