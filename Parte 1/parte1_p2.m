##% Ejemplo tarea, descomentar con ctrl + shift + r
##
##function ejemplo_parte1_p2
##  
##  %Ejemplo tarea
##
##  p=q=[1:0.1:25];
##  m=242;
##  b=ones(m,1);
##  x0=zeros(242,1);
##  A = tridiagonal(p, q, m);
##  tol = 10^-5;
##  iterMax = 1000;
##  
##  % Metodo normal
##  [xk,k,error] = parte1_p2(A, b, tol, iterMax,x0)
##  
##endfunction


function [xk,k,error]=parte1_p2(A,b,tol,iterMax,x0)
  % Funcion que implementa el metodo de Jacobi para resolver un sistema de 
  % ecuaciones lineales Ax = b.
  %
  % Sintaxis:  [xk,k,error]=parte1_p2(A,b,tol,iterMax,x0)
  %
  % Parametros de entrada: 
  %            A = matriz de coeficientes 
  %            b = vector de terminos independientes
  %            tol = un número positivo que representa a la tolerancia 
  %                 para el criterio ||A * xk - b|| < tol
  %            iterMax= cantidad de iteraciones maximas
  %            x0 = vector de valores iniciales
  %
  % Parametros de salida:                           
  %            xk = es un vector que representa la solucion de Ax = b.
  %            k = iteracion en la que se cumplio el criterio de la tolerancia
  %            error = entero positivo que representa el error final obtenido
  
  m=length(A);
  xk=x0;
  error = tol+1;
  
  k=0;
  
  while k<iterMax & error>tol
    for i=1:m
      aux=0;
      for j=1:m
        
        if j!=i
          aux=aux+A(i,j)*xk(j);
        endif
        
      endfor
      xk(i)=(1/A(i,i))*(b(i)-aux);
      error = norm(A*xk-b);
      
      if k>=iterMax | error<=tol
        xk = transpose(xk);
        return
      endif
      
    endfor
    k+=1;
  endwhile
  xk = transpose(xk);
end


