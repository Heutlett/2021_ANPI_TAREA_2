function xk = xk_plus_1(n,A,b,xk)
  
  aux = 0;
  m=length(A);

  for j=1:m
    
    if j!=n
     
      aux += A(n,j)*xk(j);
      
    endif

  endfor 
      
  xk = (1/A(n,n))*(b(n)-aux);
  
endfunction
