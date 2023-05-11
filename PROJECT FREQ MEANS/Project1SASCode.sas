/* (a) import data "Project1Data.csv" */
proc import out=proj1 
datafile='C:\Users\dlam1\OneDrive\Desktop\Project1Data.csv'
dbms=csv replace;
run;

proc contents varnum;
run;
/* Answer the following questions: */
/* (b) How many patients are there? */
proc means n;
var patientID;
run;
/* (c) Compute age for each patient. */
data proj1;
set proj1;
age = (date_discharge - DOB)/365.25;
run;

proc print; 
var patientID age;
run;
/* (d) Compute length of stay for each patient. */
data proj1;
set proj1;
length_of_stay = date_discharge - date_admission;
run;

proc print;
var patientID length_of_stay;
run;

/* (e) Compute frequencies for gender. */
proc freq;
tables gender/nopercent nocum;
run;
/* (f) Compute frequencies for insurance types. */
proc freq;
tables insurance/nopercent nocum;
run;
/* (g) Compute basic descriptives for payment. */
proc means n mean median std q1 q3 min max;
var payment;
run;
/* (h) Compute frequencies of recovery program 
       (biogel - yes/no) by surgery site. */
proc freq;
tables biogel*site/nopercent norow nocol;
run;
/* (i) Compute BMI. */
data proj1;
set proj1;
BMI=weight/((height/100)**2);
run;

proc print;
var BMI;
run;
/* (j) Categorize each patient into 
Underweight (BMI is less than 18.5), Normal (BMI 
is 18.5 to 24.9), Overweight (BMI is 25 to 29.9),
and Obese (BMI is 30 or more) and compute frequencies.*/
proc format;
value BMIfmt low-<18.5='underweight'
			18.5-<25='normal'
			25-<30='overweight'
			30-high='obese'
			;
proc freq;
tables BMI/nopercent nocum;
format BMI BMIfmt.;
run;
