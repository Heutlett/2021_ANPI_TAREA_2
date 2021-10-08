import numpy as np
from numpy.lib.function_base import gradient
import sympy as sp
import copy
import matplotlib.pylab as plt 

def variables_simbolicas(variables):
    n=len(variables)
    tam=np.arange(n)
    v_var=[]
    for i in tam:
        v_var.append(sp.Symbol(variables[i]))
    return v_var


def funciones_simbolicas(f, x_sym):
    n=len(f)
    tam=np.arange(0,n,1)
    f_var=[]
    for i in tam:
        f_var.append(sp.sympify(f[i]))
    return f_var



def derivadas_parciales(f,v_var):
    n=len(v_var)
    g=[]
    for i in np.arange(0,n,1):
        g.append(sp.diff(f,v_var[i]))

    return g


def evaluar_jacobiano(J, x_sym, xk):

    J_k = J.copy()
    for i in range(len(J_k)):

        for j in range(len(J_k[i])):

            for k in range(len(x_sym)):
            
                J_k[i][j] = J_k[i][j].subs(x_sym[k], xk[k])
            
            J_k[i][j] = float(J_k[i][j])

    return np.array(J_k).astype(np.float64)


def evaluar_funciones(f, x_sym, xk):

    f_k = f.copy()
    for i in range(len(f_k)):
        for k in range(len(x_sym)):
            
            f_k[i] = f_k[i].subs(x_sym[k], xk[k])

        f_k[i] = float(f_k[i])

    return np.array(f_k).astype(np.float64)



def jacobiano(f, x):
    
    m = len(f)
    J = []

    for i in range(m):
        z = derivadas_parciales(f[i], x)
        J.append(z)

    return np.array(J)

#f = ["x^2 + y^2 + z^2 - 1", "2*x^2 + y^2 - 4*z", "3*x^2 - 4*y + z^2"]
#x = ['x', 'y', 'z']


def newton_raphson(x0, f, x, tol, iterMax):


    k = 0
    xk = x0
    err = []

    x_sym = variables_simbolicas(x)
    J = jacobiano(f,x_sym)
    f_n = funciones_simbolicas(f, x_sym)




    while(k < iterMax):


        f_k = evaluar_funciones(f_n, x_sym, xk).astype(np.float64)
        J_k = evaluar_jacobiano(J, x_sym, xk).astype(np.float64)

        y = np.linalg.solve(J_k, f_k)


        xk = xk - y

        f_k = evaluar_funciones(f_n, x_sym, xk)


        e_k = np.linalg.norm(f_k) 
        if (e_k < tol):
            break

        err.append(e_k)
        k += 1

        
    print("La solucion del sistema de ecuaciones esta dado por el vector x = ", xk)
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

    
    return xk
    


f = ["x1^2 - 2*x1 - x2 + 0.5", "x1^2 + 4*x2^2 - 4"]
x = ['x1', 'x2']
x0 = [3,2]
tol = 10**-1
iterMax = 1000

res = newton_raphson(x0, f, x, tol, iterMax)

       









