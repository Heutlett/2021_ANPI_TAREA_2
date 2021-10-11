clc;clear;
warning off;
pkg load parallel

% Test parte1_p2 y parte1_p3

%Ejemplo tarea

p=q=[1:0.1:25];
m=242;
b=ones(m,1);
x0=zeros(242,1);
A = tridiagonal(p, q, m);
tol = 10^-5;
iterMax = 1000;

% Metodo paralelo
tic
[xk_1,k_1,error_1] = parte1_p3(A,b,tol,iterMax,x0,8);
t1_parallel = toc
primeros5 = xk_1(1:5)
ultimos5 = xk_1(m-5:m)

disp("##################################################################################################################################")

% Metodo normal
tic
[xk_2,k_2,error_2] = parte1_p2(A, b, tol, iterMax,x0);
t2_normal = toc
primeros5 = xk_2(1:5)
ultimos5 = xk_2(m-5:m)

% Respuesta correcta con inversa

correcta = inv(A)*b;

disp("##################################################################################################################################")
disp("Respuesta correcta con inversa")
primeros5 = correcta(1:5)'
ultimos5 = correcta(m-5:m)'



