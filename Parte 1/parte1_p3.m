function [xk,k,error]=parte1_p3(A,b,tol,iterMax,x0,cpus)
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
