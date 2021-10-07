pkg load parallel
nmax = 10;

ni = 1:nmax; # Arreglo de valores que se utilizaran en cada calculo

B=5; # Variable numerica

A = pararrayfun(4,@(n) myfun(n,B),ni) 