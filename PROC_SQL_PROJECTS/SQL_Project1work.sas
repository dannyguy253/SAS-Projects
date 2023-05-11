proc import out = meddata
datafile = "C:/Users/dlam1/OneDrive/Desktop/SQL_Project1_Data.csv"
dbms = csv replace; 
run;


proc sql;
create table visitdata as
 select Medical_Record_Number, count(*) as nvisits 
  from meddata
   group by Medical_Record_Number;

select * from visitdata;
quit;


proc sql;
select nvisits, count(*) as npatients 
from visitdata
group by nvisits;
quit;
