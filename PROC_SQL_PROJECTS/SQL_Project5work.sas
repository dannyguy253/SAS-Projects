data visit1;
input ID$ visit_date mmddyy8. @19 bdate mmddyy8.  race$ score;
cards;
198650  11/28/11  04/29/87 Hispanic  24
232738  09/19/11  03/22/54 Hispanic  33
233880  09/23/11  05/15/67 White  74
234127  11/07/11  07/03/72 Black  85
234152  09/27/11  11/08/50 Hispanic  28
234385  09/15/11  06/06/68 Black  85
;

data visit2;
input ID$ @9 visit_date mmddyy8. score;
cards;
232738  10/18/11  66
233880  09/26/11  37
234127  12/16/11  85
234152  01/10/12  38
;

data visit3;
input ID$ @9 visit_date mmddyy8. score;
cards;
232738  10/29/11  75
234127	12/29/11  45
234152	02/27/11  35
;

/* Assignment is to combine the three data sets into one long-form data set */

/* Without PROC SQL */
data mergeddata; 
merge visit1 (rename=(visit_date=visit_date1 score=score1))
visit2 (rename=(visit_date=visit_date2 score=score2))
visit3 (rename=(visit_date=visit_date3 score=score3));
by id;
run;

data longform;
 set mergeddata;
 array vd[3] visit_date1-visit_date3;
 array sc[3] score1-score3;
  do visit=1 to 3;
   visit_date=vd[visit];
   score=sc[visit];
   output;
 end;
 keep id bdate race visit visit_date score;
run;

data longformclean;
 set longform;
  if score ne .;
run;
title 'OUTPUT WITHOUT PROC SQL';
proc print noobs;
format bdate mmddyy10. visit_date mmddyy10.;
run;


/* With PROC SQL */

/* add demo variables to visit2 data set */

proc sql;
 create table visit2demo as
  select b.id, a.bdate, a.race, 2 as visit, 
b.visit_date, b.score
     from visit1 as a, visit2 as b
where a.id=b.id;
select * from visit2demo;
quit;

/* add demo variables to visit3 data set */

proc sql;
 create table visit3demo as
  select b.id, a.bdate, a.race, 3 as visit, 
b.visit_date, b.score
     from visit1 as a, visit3 as b
where a.id=b.id;
select * from visit3demo;
quit;

/* concatenating visit1, visit2demo, and visit3demo */

title 'OUTPUT WITH PROC SQL';
proc sql;
 create table longform as
  select id, bdate, race, 1 as visit, visit_date, score
   from visit1
    union 
   select *
    from visit2demo
	union
	select *
	 from visit3demo;
select id, bdate format mmddyy10., race, visit, visit_date format
mmddyy10., score from longform; 
	quit;
