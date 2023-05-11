data sales;
input id$ sale amount dollar5.0;
cards;
001  1  $150
001  2  $165
001  3  $345
002  1  $135
002  2  $95
002  3  $110
002  4  $245
003  1  $380
003  2  $250
003  3  $220
004  1  $350
004  2  $100
;

data raise; *for mean amount per sale;
input tier percent;
cards;
100   0.5
150   1.0
200   1.5
250   2.0
300   2.5
;

/* (a) Order salespersons' ids with respect to the average amount 
per sale, from largest to smallest. */

proc sql;
 create table meansales as
 select  id, mean(amount) as mean_amount
  from sales
   group by id
     order by mean_amount desc;
 select * from meansales;
quit;

/* (b) Calculate percent raise for each 
salesperson.*/

proc sql;
select *
 from meansales, raise
  where mean_amount>tier
   group by id
    having tier=max(tier);
quit;
