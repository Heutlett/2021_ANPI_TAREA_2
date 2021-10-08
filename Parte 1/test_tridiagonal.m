clc;clear;

% Test tridiagonal
 
m=5;
p=[0 ; 1 ; 2; 5; 1];
q=[6 ; 7 ; 3; 6; 8];

A=tridiagonal(p(2:m),q(1:m-1),m);

A