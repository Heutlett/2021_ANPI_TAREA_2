function ejemplo_parte1_p4
  
  clc;clear;
  warning off;
  
  Sp = parte1_p4(8)
  
endfunction


function Sp = parte1_p4(p_max)
  

  pkg load parallel
  
  %Ejemplo tarea

  p=q=[1:0.1:25];
  m=242;
  b=ones(m,1);
  x0=zeros(242,1);
  A = tridiagonal(p, q, m);
  %A=tridiagonal(p(2:m),q(1:m-1),m);
  tol = 10^-5;
  iterMax = 1000;
  
  Sp = [];
  
  for p=1:p_max
    
    p
    
    % Metodo normal
    tic
    [xk_2,k_2,error_2] = parte1_p2(A, b, tol, iterMax,x0);
    T_s = toc
    
    % Metodo paralelo
    tic
    [xk_1,k_1,error_1] = parte1_p3(A,b,tol,iterMax,x0,p);
    T_p = toc
    
    Sp = [Sp T_s/T_p];
    
    disp("")
    
  endfor
    
  
endfunction
