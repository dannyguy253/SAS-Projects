/* import the SPSS data file. */
proc import out=proj2
datafile='C:/Users/dlam1/OneDrive/Desktop/Project2Data.sav'
dbms=spss replace;
run;

proc contents varnum;
run;
/* Select data between Jan. 1, 2018
and Sep. 1, 2019. */
data proj2_clean;
set proj2;
if (visitdate >'01jan2018'd) and (visitdate < '01sep2019'd);
run;

proc print;
run;

/* For how many children were the baseline 
data collected?*/
proc freq;
table visittype/nopercent nocum;
where visittype='BASELINE';
run;
/* How many boys and how many girls? */
proc freq;
tables gender/nopercent nocum;
where visittype='BASELINE';
run;

/* What's the distribution by age? */
proc freq;
table age/nopercent nocum;
where visittype='BASELINE';
run;
/* What are the data collection points and 
what is the distribution of the number 
of responses? */
proc format;
value $visittypefmt 'BASELINE'='a. BASELINE'
				   'POST-INT'='b. POST-INT'
				   '3MONTHFU'='c. 3MONTHFU'
				   '6MONTHFU'='d. 6MONTHFU'
				   '9MONTHFU'='e. 9MONTHFU'
				   ;
run;

proc freq order=data;
tables visittype/nopercent nocum;
*format visittype $visittypefmt.;
run;
/* Compute basic statistics for weekly 
TV time,  computer time, number of fruits consumed,
number of veggies consumed, and 
number of sugary drinks consumed. */

proc means n mean std order=data;
var TVtime ComputerTime NFruits NVeggies NSugaryDrinks;
class visittype;
run;

