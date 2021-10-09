##% Ejemplo tarea, descomentar con ctrl + shift + r
##
##function ejemplo_tridiagonal
##  clc;clear;
##
##  % Test tridiagonal
##   
##  m=5;
##  p=[0 ; 1 ; 2; 5; 1];
##  q=[6 ; 7 ; 3; 6; 8];
##
##  A=tridiagonal(p(2:m),q(1:m-1),m)
##  
##endfunction

function A=tridiagonal(p,q,m)
  % Esta funcion crea una matriz tridiagonal condicionada
  %
  % Sintaxis: A=tridiagonal(p,q,m)
  %
  % Parametros iniciales: 
  %            p = vector
  %            q = vector
  %            m = es un numero entero mayor o igual a 3
  %   
  % Parametros de salida:                           
  %            A = matriz de tamano mxm
  A=zeros(m);
  
  
  A(1,1) = 2*q(1);
  A(1,2) = q(1);
  
  n = 1;
  
  for i=2:m-1
     A(i,n) = p(i-1);
     A(i,n+1) = 2*(p(i-1)+q(i));
     A(i,n+2) = q(i);
     n+=1;
  endfor

  A(m,m-1) = p(m-1);
  A(m,m) = 2*p(m-1);
  
end
