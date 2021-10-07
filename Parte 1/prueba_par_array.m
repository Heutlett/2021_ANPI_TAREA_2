pkg load parallel
nmax = 10; # Number of points where the function is calculated

# Forth method, using parrayfun to call "myfun"

ni = 1:nmax; 
B=5;
A = pararrayfun(4,@(n) myfun(n,B),ni)