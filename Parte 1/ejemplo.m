function ej 
  
  p=q=[1:0.1:25];
  m=242;
  b=ones(m,1);
  x0=zeros(242,1);
  A = tridiagonal(p, q, m);
  tol = 10^-5;
  iterMax = 1000;


  [xk,k,error] = ejemplo(A,b,tol,iterMax,x0);


  
end


function [xk,k,error]=ejemplo(A,b,tol,iterMax,x0)
  m=length(A);
  xk=x0;
  error = tol+1;
  k=0;
  
  while k<iterMax & error>tol
    
    for i=1:m
      
      xk = xk_plus(i,A,b,xk);
      
    endfor
 
    
    error = norm((A*xk')-b);
    
    if error < tol | k >= iterMax
        #xk = transpose(xk);
        return
      endif
      
    k+=1;
    
  endwhile
  #xk = transpose(xk);
end

function xk = xk_plus(i,A,b,xk)
  
  aux = 0;
  m=length(A);

  for j=1:m
    
    if j!=i
     
      aux += A(i,j)*xk(j);
      
    endif

  endfor 
      
  xk = (1/A(i,i))*(b(i)-aux);
  
endfunction

