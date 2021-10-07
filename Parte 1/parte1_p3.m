function [xk,k,error]=parte1_p3(A,b,tol,iterMax,x0,cpus)
  m=length(A);
  xk=x0;
  error = tol+1;
  k=0;
  
  while k<iterMax & error>tol
    
    ni = 1:m;    # Crea un vector de los indices i que se utilizaran en el 
                 # calculo en paralelo
    
    
    # Se llama la funcion que se ejecutara en paralelo y se le indica que
    # la variable n va a iterar en cada calculo.
    xk = pararrayfun(cpus,@(n) xk_plus_1(n,A,b,xk),ni);
    
    error = norm((A*xk')-b);
    
    if error < tol | k >= iterMax
        #xk = transpose(xk);
        return
      endif
      
    k+=1;
    
  endwhile
  #xk = transpose(xk);
end
