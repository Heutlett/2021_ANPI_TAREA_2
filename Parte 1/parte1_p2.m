function [xk,k,error]=parte1_p2(A,b,tol,iterMax,x0)
  % Funcion que implementa el metodo de Jacobi para resolver un sistema de 
  % ecuaciones lineal Ax = b.
  %
  % Sintaxis:  xk=parte1_p2(A,b,tol,iterMax,x0)
  %
  % Parametros iniciales: 
  %            A = matriz de coeficientes 
  %            q = vector de terminos independientes
  %            tol = un número positivo que representa a la tolerancia 
  %                 para el criterio ||A * xk - b|| < tol
  %            iterMax= cantidad de iteraciones maximas
  % Parametros de salida:                           
  %            A = matriz de tamano mxm
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


