proc import out=tanitadata
datafile="C:/Users/dlam1/OneDrive/Desktop/TanitaData.csv"
dbms=csv replace;
run;

proc import out=moretanitadata
datafile="C:/Users/dlam1/OneDrive/Desktop/MoreTanitaData.csv"
dbms=csv replace;
run;

proc import out=surveydata
datafile="C:/Users/dlam1/OneDrive/Desktop/SurveyData.csv"
dbms=csv replace;
run;

/* concatenate)=combine vertically) the two tanita data files*/
data tanitadata;
set tanitadata 
moretanitadata (rename=(id=childid));
run;

/* merge horizontally the tanita file and the survey files*/
proc sort data=tanitadata;
by childid visittype;
run;

proc sort data=surveydata;
by ID visittype;
run;

data alldata;
merge tanitadata surveydata (rename=(id=childid));
by childID visittype;
run;

proc print data=alldata;
run;

data alldata_clean;
set alldata;
if visitdate ne .;
run;

proc print;
run;

