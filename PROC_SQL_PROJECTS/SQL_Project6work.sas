data cholesterol;
input id gender$ age LDL0 LDL6 LDL9;
cards;
1	M	50	73	71	80
2	M	46	85	86	82
3	F	75	186	177	153
4	F	63	196	188	163
5	M	59	135	120	106
6	F	59	127	126	106
7	F	67	176	150	156
8	M	65	142	117	114
9	F	57	148	131	138
10	M	48	76	65	94
11	F	53	191	185	162
12	M	62	109	104	93
13	M	55	103	94	75
14	F	79	203	204	178
15	F	72	174	164	139
16	F	71	172	150	139
17	F	68	184	169	153
18	M	73	137	137	132
19	M	60	111	110	100
20	M	46	88	87	84
21	F	52	155	135	128
22	F	75	158	143	145
23	M	58	125	111	118
24	M	47	116	108	94
25	F	73	167	165	162
26	F	77	167	164	155
27	F	74	122	126	105
;

/* (a) Create a file with those patients for whom the 
LDL measurement showed an increase (LDL9-LDL0 > 0). */

proc sql;
 create table increase as
  select * 
   from cholesterol
    where LDL9-LDL0>0;
select * from increase;
quit;

/* (b) Remove from the original data set the patients identified 
in part (a). */

proc sql;
 select * from cholesterol
  except
   select * from increase;
quit;


/* Alternatively, without PROC SQL */
data cholesterol1;
 set cholesterol;
 if LDL9-LDL0<=0;
/*  if id not in (1, 10);*/
run;

proc print;
run;
