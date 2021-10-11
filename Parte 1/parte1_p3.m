##% Ejemplo tarea, descomentar con ctrl + shift + r
##
##function ejemplo_parte1_p3
##  
##  p=q=[1:0.1:25];
##  m=242;
##  b=ones(m,1);
##  x0=zeros(242,1);
##  A = tridiagonal(p, q, m);
##  tol = 10^-5;
##  iterMax = 1000;
##
##  % Metodo paralelo
##  [xk,k,error] = parte1_p3(A,b,tol,iterMax,x0,8)
##  
##endfunction


function [xk,k,error]=parte1_p3(A,b,tol,iterMax,x0,cpus)
  
  % Funcion que implementa el metodo de Jacobi en paralelo para resolver un 
  % sistema de ecuaciones lineales Ax = b.
  %
  % Sintaxis:  [xk,k,error]=parte1_p3(A,b,tol,iterMax,x0,cpus)
  %
  % Parametros de entrada: 
  %            A = matriz de coeficientes 
  %            b = vector de terminos independientes
  %            tol = un número positivo que representa a la tolerancia 
  %                 para el criterio ||A * xk - b|| < tol
  %            iterMax= cantidad de iteraciones maximas
  %            x0 = vector de valores iniciales
  %            cpus = cantidad de procesadores que se utilizaran en el calculo
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
    
    ni = 1:m;    # Crea un vector de los indices i que se utilizaran en el 
                 # calculo en paralelo
    
    # Se llama la funcion que se ejecutara en paralelo y se le pasa ni como el
    # arreglo al que se va a evaluar en la funcion xk_plus_1, este arreglo va
    # desde 1 hasta m, y sus valores seran utilizados como el indice i
    xk = pararrayfun(cpus,@(i) xk_plus_1(i,A,b,xk),ni);
    
    error = norm((A*xk')-b);
    
    if error < tol | k >= iterMax
        return
      endif
      
    k+=1;
    
  endwhile
end
