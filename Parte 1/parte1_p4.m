function ejemplo_parte1_p4
  
  clc;clear;
  warning off;
  
  SpList = parte1_p4(8);
  
endfunction


function SpList = parte1_p4(p_max)
  
  % Funcion que calcula la acelaracion del metodo de Jacobi en paralelo
  %
  % Sintaxis:  SpList = parte1_p4(p_max)
  %
  % Parametros de entrada: 
  %            p_max = cantidad maxima de procesadores logicos de la PC
  %
  % Parametros de salida:                           
  %            SpList = lista de valores obtenidos de acelaracion usando
  %                     de 1...p_max procesadores

  pkg load parallel
  
  %Ejemplo tarea

  p=q=[1:0.1:25];
  m=242;
  b=ones(m,1);
  x0=zeros(242,1);
  A = tridiagonal(p, q, m);
  tol = 10^-5;
  iterMax = 1000;
  
  SpList = [];
  
  disp("Este metodo esta implementado para mostrar unicamente resultados de aceleracion.")
  disp("Si se desea ver los resultados numericos se deben descomentar las lineas 64 y 65.");
  disp("");
  
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
    
    Sp = T_s/T_p
    SpList = [SpList Sp];
    
    disp("")
    
  endfor
  
   % Descomentar las siguientes lineas si se desean mostrar los resultados
   % xk_1  
   % xk_2
  
   % Graficar
   plot(1:length(SpList),SpList,'g','LineWidth',2)
   set(gca, "fontsize", 20)
   title('Aceleracion del metodo de Jacobi implementado en paralelo')
   xlabel('Procesadores utilizados (p)')
   ylabel('Aceleracion (Ts/Tp)')
   grid on

endfunction
