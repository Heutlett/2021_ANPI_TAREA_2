function xk = xk_plus_1(i,A,b,xk)
  
  aux = 0;
  m=length(A);

  for j=1:m
    
    if j!=i
     
      aux += A(i,j)*xk(j);
      
    endif

  endfor 
      
  xk = (1/A(i,i))*(b(i)-aux);
  
endfunction
