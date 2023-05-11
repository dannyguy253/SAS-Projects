/* (a) Import salesdata.csv. */

proc import out=salesdata
datafile="C:/Users/dlam1/OneDrive/Desktop/salesdata.csv"
dbms=csv replace;
run;

proc print;
format date date9.;
run;

/* (b) Plot salesamount against date. */

proc gplot;
plot salesamount*date;
run;


/* (c) Compute mean salesamount by date. */

proc sql;
create table means as
select date format=date9., mean(salesamount) as msalesamount
 from salesdata
  group by date;
select * from means;
quit;

/* (d) Plot mean salesamount by date. */

symbol interpol=join value=diamond c=gold width=3;
proc gplot data=means;
plot msalesamount*date;
run;

/* (e) Compute the overall mean of sale amounts and make 
       it a macro variable. */

proc means data=salesdata noprint;
var salesamount;
output out=outmeans mean=overallmean;
run;

data _null_;
 set outmeans;
 call symput('overallmean', round(overallmean, 0.01));
 run;

 %put &overallmean;

/* (f) Plot deviations of mean salesamount per date 
       from the overall mean. */ 

 proc sql number;
 create table sales as
 select date format=date9., msalesamount-&overallmean as devation
   from means;
 select * from sales;
 quit;


symbol interpol=join value=circle;
proc gplot data=sales;
plot devation*date/vref=0;
run;
