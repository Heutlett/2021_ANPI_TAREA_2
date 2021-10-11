import numpy as np
from numpy.lib.function_base import gradient
import sympy as sp
import copy
import matplotlib.pylab as plt 


# Funcion que convierte en simbolicas las variables a utilizar  
#
# Sintaxis:  variables_simbolicas(variables)
#
# Parametros iniciales: 
#            variables = array que contiene las variables de las funciones 
#
# Parametros de salida:                           
#            v_var = Array con las varaibles convertidas en simbolicas 

def variables_simbolicas(variables):

    n=len(variables)
    tam=np.arange(n)
    v_var=[]

    for i in tam:
        v_var.append(sp.Symbol(variables[i]))

    return v_var


# Funcion que convierte las funciones a utilizar en simbolicas 
#
# Sintaxis:  funciones_simbolicas(f)
#
# Parametros iniciales: 
#            f = array que contiene las funciones a utilizar  
#
# Parametros de salida:                           
#            f_var = Array con las funciones convertidas en simbolicas 

def funciones_simbolicas(f):
    n=len(f)
    tam=np.arange(0,n,1)
    f_var=[]
    for i in tam:
        f_var.append(sp.sympify(f[i]))
    return f_var


# Funcion calcula las derivadas parciales dado un array con funciones,
# Se utiliza para como parte del calculo del Jacobiano
#
# Sintaxis:  derivadas_parciales(f, var)
#
# Parametros iniciales: 
#            f = array que contiene las funciones a utilizar 
#            v_var = array que contiene las variables simbolicas a utilizar 
#
# Parametros de salida:                           
#            g = Array con las derivadas parciales de las funciones dadas

def derivadas_parciales(f,v_var):
    n=len(v_var)
    g=[]

    for i in np.arange(0,n,1):
        g.append(sp.diff(f,v_var[i]))

    return g



# Funcion que evalua el Jacobiano dado un conjunto de valores
#
# Sintaxis:  evaluar_jacobiano(f)
#
# Parametros iniciales: 
#            J = Jacobiano
#            x_sym = array que contiene las variables simbolicas 
#            x = array que contiene los valores numericos  
#
# Parametros de salida:                           
#            array con las funciones convertidas en simbolicas 

def evaluar_jacobiano(J, x_sym, xk):

    J_k = J.copy()
    for i in range(len(J_k)):

        for j in range(len(J_k[i])):

            for k in range(len(x_sym)):
            
                J_k[i][j] = J_k[i][j].subs(x_sym[k], xk[k])
            
            J_k[i][j] = float(J_k[i][j])

    return np.array(J_k).astype(np.float64)


# Funcion que evalua un array de funciones dado un conjunto de valores
#
# Sintaxis:  evaluar_jacobiano(f)
#
# Parametros iniciales: 
#            f = array que contiene las funciones a utilizar
#            x_sym = array que contiene las variables simbolicas 
#            x = array que contiene los valores numericos  
#
# Parametros de salida:                           
#             array con las funciones convertidas en simbolicas
def evaluar_funciones(f, x_sym, xk):

    f_k = f.copy()
    for i in range(len(f_k)):
        for k in range(len(x_sym)):
            
            f_k[i] = f_k[i].subs(x_sym[k], xk[k])

        f_k[i] = float(f_k[i])

    return np.array(f_k).astype(np.float64)




# Funcion que calcula la matriz Jacobiana dado un conjunto de funciones
#
# Sintaxis:  jacobiano(f, x)
#
# Parametros iniciales: 
#            f = array que contiene las funciones a utilizar 
#            x_sym = array que contiene las variables simbolicas 
#
# Parametros de salida:                           
#            array con las funciones convertidas en simbolicas

def jacobiano(f, x_sym):
    
    m = len(f)
    J = []

    for i in range(m):
        z = derivadas_parciales(f[i], x_sym)
        J.append(z)

    return np.array(J)



# Variacion metodo de newton_raphson para resolver un sistemas de 
# ecuaciones lineales 
#
# Sintaxis:  newton_raphson(x0, f, x, tol, iterMax)
#
# Parametros iniciales: 
#            x0 = vector con los valores iniciales
#            f = array que contiene las funciones a utilizar 
#            x = array que contiene las variables a utilizar
#            tol = tolerancia 
#            iterMax = numero de iteraciones maximas 
#
# Parametros de salida:                           
#            xk = vector los valores
def newton_raphson(x0, f, x, tol, iterMax):


    k = 0
    xk = x0
    err = []

    x_sym = variables_simbolicas(x) #Convierte a simbolicas las variables dadas 
    J = jacobiano(f,x_sym) #Calcula el Jacobiano de la funcion
    f_n = funciones_simbolicas(f) #Convierte en simbolicas las funciones dadas


    while(k < iterMax):


        f_k = evaluar_funciones(f_n, x_sym, xk).astype(np.float64) #Evalua las funciones con el valor de xk actual
        J_k = evaluar_jacobiano(J, x_sym, xk).astype(np.float64) #Evalua el Jacobiano con el valor de xk actual

        y = np.linalg.solve(J_k, f_k) #Resuelve la ecuacion y = J^(-1) * f_k 

        xk = xk - y #Calcula el nuevo valor de xk dado por xk =  xk - J^(-1) * f_k 

        f_k = evaluar_funciones(f_n, x_sym, xk) #Se evaluan las funciones con el valor de xk


        e_k = np.linalg.norm(f_k, 2)  #Se calcula la norma 2 de f_k 

        if (e_k < tol): #Verifica el punto de parada 
            break

        err.append(e_k)
        k += 1

        
    print("La solucion del sistema de ecuaciones esta dado por el vector x = ", xk.transpose(), " con ", k, " iteraciones y con un error de ", e_k)
    
    #Graficacion       
    plt.rcParams.update({'font.size': 14})
    ejex=np.arange(1,k+1,1)
    fig, graf=plt.subplots()
    graf.plot(ejex,err,'b',marker='o',markerfacecolor='red',markersize=10)
    graf.set_xlabel('Iteraciones ($k$)')
    graf.set_ylabel('$|f(x_k)|$')
    graf.set_title('Metodo de Newton-Raphson (Iteraciones vrs Error)')
    graf.grid(True)
    plt.show()

    
    return xk, k, e_k, 
    



#Fuciones a ejemplo obtenidas a partir del pdf
f = ["x1^2 - 2*x1 - x2 + 0.5", "x1^2 + 4*x2^2 - 4"]
x = ['x1', 'x2'] #Variables 
x0 = [1.6, 0] #Vector inicial 
tol = 10**-5 #Tolerancia 
iterMax = 1000 #Iteraciones maximas

res = newton_raphson(x0, f, x, tol, iterMax)

       









