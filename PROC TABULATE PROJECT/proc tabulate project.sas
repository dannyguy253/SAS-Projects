data internet;
input gender $ electronics $ 6-13 hours;
cards;
boy  computer 30
boy  laptop   18
boy  iphone   24
girl computer 20
girl laptop   32
girl iphone   17
;

/*proc freq;*/
/*table gender*electronics /nopercent norow nocolumn;*/
/*weight hours;*/
/*run;*/

proc format;
value $genderfmt  'boy'='C:/Users/dlam1/OneDrive/Desktop/boy.jpg'
'girl'='C:/Users/dlam1/OneDrive/Desktop/girl.jpg';
run;

proc format;
value $electronicsfmt
'computer'='C:/Users/dlam1/OneDrive/Desktop/computer.jpg'
'laptop'='C:/Users/dlam1/OneDrive/Desktop/laptop.jpg'
'iphone'='C:/Users/dlam1/OneDrive/Desktop/iphone.jpg';
run;


proc tabulate ;
class gender electronics;
classlev gender/s=[foreground=white background=green just=r postimage=$genderfmt.];
classlev electronics/s=[foreground=white background=blue just=r postimage=$electronicsfmt.];
var hours;
table gender={s=[foreground=red background=pink just=c]}, electronics={s=[foreground=white background=magenta just=c]}*hours=''*sum=''/box='# of hours';
run;




/*/*Practice*/*/
/*proc tabulate;*/
/*class gender electronics;*/
/*classlev gender/s=[foreground=white background=green just=r postimage=$genderfmt.];*/
/*classlev electronics/s=[foreground=white background=blue just=r postimage=$electronicsfmt.];*/
/**/
/*var hours;*/
/*table gender, electronics*hours=''*sum='';*/
/*run;*/
