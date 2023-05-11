/* Question 1.           | 1 2 3 |  */
/* Consider the matrix A=| 4 5 6 |. */
/*                       | 7 8 1 |  */

/*(a) Compute the determinant of A.*/

/*(b) Compute the inverse of A.*/

/*(c) Compute the transposed matrix A'*/

/*(d) Consider vector v=[1 -1 2] and let B be a 3x3 unity matrix. Compute
v(A+B)^{-1}A'Bv'.*/


proc iml; *IML stands for interactive matrix language;
A={1 2 3, 4 5 6, 7 8 1};
d=det(A);
A_inv=inv(A);
A_tr=t(A); * transpose of A;
B={1 1 1, 1 1 1, 1 1 1};
v={1 -1 2};
Result=v*inv(A+B)*t(A)*B*t(v);
print d;
print A_inv;
print A_tr;
print Result;




/* Question 2.        | 1 2 3 |       | 9 3 1 |*/
/* Consider matrice A=| 4 5 6 | and B=| 5 7 4 |. */
/*                    | 7 8 1 |       | 0 4 5 | */

/* Evaluate the expression: 
[2*trace(A)+trace(B)]*(A'+B')^{-1} */

proc iml;
A={1 2 3, 4 5 6, 7 8 1};
B={9 3 1, 5 7 4, 0 4 5};
expression=(2*trace(A)+trace(B))*inv(t(A)+t(B));
print expression;

/* Bonus Part */
proc iml; * Solve Ax=b;
A={1 2 3, 4 5 6, 7 8 1};
b = {9, 3, 1};
x = inv(A)*b;
print x;
