data childrendata;
input CHILDID$	VISITTYPE$	AGE	GENDER$	BMI_Percent_CDC;
cards;
100B	BASELINE	11	M	83
100B	POST-INT	11	M	84
100B	3MONTHFU	11	M	70
100B	6MONTHFU	12	M	62
100B	9MONTHFU	12	M	70
101B	BASELINE	11	F	99
101B	POST-INT	11	F	99
101B	3MONTHFU	11	F	99
101B	6MONTHFU	12	F	99
101B	9MONTHFU	12	F	98
102B	BASELINE	10	F	99
102B	POST-INT	10	F	98
102B	3MONTHFU	10	F	98
102B	6MONTHFU	10	F	98
102B	9MONTHFU	11	F	98
105B	BASELINE	8	F	86
105B	POST-INT	9	F	92
105B	3MONTHFU	9	F	88
105B	6MONTHFU	9	F	88
105B	9MONTHFU	9	F	86
105C	BASELINE	11	M	46
105C	POST-INT	11	M	48
105C	3MONTHFU	11	M	49
105C	6MONTHFU	12	M	51
105C	9MONTHFU	12	M	50
106B	BASELINE	11	F	70
106B	POST-INT	11	F	74
106B	3MONTHFU	12	F	80
106B	6MONTHFU	12	F	79
106B	9MONTHFU	12	F	81
;

data adultsdata;
input ADULTID$	VISITTYPE$	BMI;
cards;
100A	BASELINE	35.9
100A	POST-INT	35.6
100A	3MONTHFU	34.4
100A	6MONTHFU	36.5
100A	9MONTHFU	35.5
101A	BASELINE	43.2
101A	POST-INT	42.9
101A	3MONTHFU	42.9
101A	6MONTHFU	42.9
101A	9MONTHFU	42.5
102A	BASELINE	31.1
102A	POST-INT	30.6
102A	3MONTHFU	29.2
102A	6MONTHFU	28.0
102A	9MONTHFU	28.1
102C	BASELINE	30.8
105A	BASELINE	31.8
105A	POST-INT	31.3
105A	3MONTHFU	31.0
105A	6MONTHFU	31.2
105A	9MONTHFU	31.3
106A	BASELINE	50.6
106A	POST-INT	50.6
106A	3MONTHFU	50.4
106A	6MONTHFU	50.2
106A	9MONTHFU	49.5
106C	BASELINE	26.6
106D	BASELINE	26.4
;
/* Limit the data for children to only those whose percent BMI 
at baseline is 85% or above or whose percent BMI at the baseline is 75% (75% to <85%)
and the parent’s BMI is at least 25. */

proc sql;
 create table temp as
  select a.childid, a.visittype, a.age, 
a.gender, a.bmi_percent_cdc, b.adultid, b.visittype as avisittype, b.bmi
   from childrendata as a, adultsdata as b
   where substr(a.childid,1,3)=substr(b.adultid,1,3) and
a.visittype=b.visittype and substr(b.adultid,4,1)='A';
select * from temp;
quit;

proc sql;
create table cleandata as
  select childid, visittype, age, gender, bmi_percent_cdc, bmi 
   from temp
   where childid in (select childid from temp where(bmi_percent_cdc>=85 
    or (bmi_percent_cdc>=75 and bmi>=25) and visittype='BASELINE'));
select * from cleandata;
quit;
