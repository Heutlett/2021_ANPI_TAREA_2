pkg load parallel

v_inicial = 1:10; # Arreglo de valores que se utilizaran en cada calculo

a=5; # Variable numerica

v_final = pararrayfun(4,@(n) myfun(n,a),v_inicial) 

