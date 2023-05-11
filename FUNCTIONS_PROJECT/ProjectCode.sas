/* '777' ="Don't Know", '888'="Refuse to Answer",
'99999'="Missing" */

proc import out=concussiondata
datafile="C:/Users/dlam1/OneDrive/Desktop/ConcussionData.csv"
dbms=csv replace;
run;

proc contents varnum;
run;

/* (a) Remove rows with too much missingness
(ID=33, 48, 61, 69, 108, 112, 143, 193, 233,
235, 242, 249, 262, 288, 307, 310, 322, 324, 329,
359, 367, 393, 396, 402, 413, 417) */

data cleaned;
set concussiondata;
if ID not in (33, 48, 61, 69, 108, 112, 143, 193, 233, 
235, 242, 249, 262, 288, 307, 310, 322, 324, 329,
359, 367, 393, 396, 402, 413, 417);
run;

proc print;
run;

 /* (b) Replace with '.':  '888' in Headache and 
BalanceProblems  and '99999' in Fatigue.*/

data cleaned;
 set cleaned;
 if Headache=888 then Headache=.;
 if BalanceProblems=888 then BalanceProblems=.;
 if Fatigue=99999 the Fatigue=.;
 run;

 proc print;
 run;

/* (c) Compute the age of patient at exam.
 Compute the wait between concussion onset
and medical exam.*/

 data cleaned;
 set cleaned;
 age=round(yrdif(DOB,DateOfExam, 'act/act'),0.1);
 wait=datdif(DateOfOnset,DateOfExam, 'act/act');
run; 

proc print;
var ID age wait;
run;

/* (d) What occupations are present? */

proc freq; 
table Occupation;
run;

/* (e) What sports are present? */

proc freq;
table Sport;
run;

/* (f) How many patients had RetrogradeAmnesia? */

proc freq;
table RetrogradeAmnesia;
run;

/* (g) How many patients had AnterogradeAmnesia?*/

proc freq;
table AnterogradeAmnesia;
run;

/* (h) Compute a single score for each patient 
that is the sum of 22 variables: Headache, Nausea, 
Vomiting, BalanceProblems, Dizziness, Fatigue, Drowsiness, 
TroubleFallingAsleep, SleepingMoreThanUsual, 
SleepingLessThanUsual, Numbness, SensititivityToLight, 
SensitivitiyToNoise, VisionProblems, Irritability, Sadness, 
Nervousness, FeelingMoreEmotional, FeelingSlowedDown,
FeelingMentallyFoggy, DifficultyConcentrating,
DifficultyRemembering. Prorate the sum for ID=31 who is 
missing one value and for ID=390 who is missing two values.*/

data cleaned;
 set cleaned;
 score=sum(Headache, Nausea, Vomiting, 
BalanceProblems,  Dizziness, Fatigue, Drowsiness, 
TroubleFallingAsleep, SleepingMoreThanUsual, 
SleepingLessThanUsual, Numbness, 
SensititivityToLight, SensitivitiyToNoise, 
VisionProblems, Irritability, Sadness, Nervousness, 
FeelingMoreEmotional, FeelingSlowedDown,
FeelingMentallyFoggy, DifficultyConcentrating, 
DifficultyRemembering);
if ID=31 then score=score/21*22;
if ID=390 then score=score/20*22;
run;

proc print;
var ID score;
run;
