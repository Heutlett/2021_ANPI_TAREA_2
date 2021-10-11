function xk = xk_plus_1(i,A,b,xk)
  
  % Funcion auxiliar que se encarga de calcular los valores independientes de 
  % xk, esta funcion es ejecutada en paralelo por la funcion parte1_p3.
  %
  % Sintaxis:  xk = xk_plus_1(i,A,b,xk)
  %
  %            i = indice del x_i de xk que sera calculado
  %            A = matriz de coeficientes 
  %            b = vector de terminos independientes
  %            xk = se refiere al xk-1 utilizado en la formula de Jacobi 
  %                 utilizada en esta tarea.
  %
  % Parametros de salida:                           
  %            xk = sera el nuevo xk calculado en paralelo
  
  aux = 0;
  m=length(A);

  for j=1:m
    
    if j!=i
     
      aux += A(i,j)*xk(j);
      
    endif

  endfor 
      
  xk = (1/A(i,i))*(b(i)-aux);
  
endfunction
