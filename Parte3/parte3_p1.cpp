
#define ARMA_USE_LAPACK
#include <armadillo>
#include <iostream>

using namespace arma;

/**
Funcion que generada una matriz de 45 x 30 segun las condiciones dadas en la especificacion
*/
mat generarMatriz()
{
    int row = 45;
    int column = 30;

    mat A = zeros(row, column);

    for (int i=0; i< row; i++){

        for (int j=0; j<column; j++){

            A(i, j) = pow(i+1,2) + pow(j+1,2); //Calcula el valor de la posicion i,j de la matriz
            

        }
    }

    return A;


}



/**
 Metado que calcula la pseudoinversa de una matriz meidiante un metodo iterativo 
 desarrollado en el articulo Generalized Inverses Estimations by Means of Iterative Methods with Memory

 Sintaxis:  pseudoInversas(A)

 Parametros iniciales: 
            A = matriz a la cual se le desea calcular la pseudoinversa

 Parametros de salida:                           
            error = error de la funcion

*/
mat pseudoInversa(mat A)
{


    double alpha_0 = 5e-10;
    double alpha_1 = 2e-11;
    double tol = 1e-5 + 1;
    double error = tol + 1;

    //Calculo de los valores iniciales
    mat X0 = alpha_0*A.t();
    mat X1 = alpha_1*A.t();


    mat X = X1;
    mat X_prev = X0; 

    int iterMax = 1000;

    for (int k=0; k < iterMax; k++){


        mat temp = X;

        X = X_prev + X - X_prev*A*X; //Definicion del metodo iterativo para obtener la pseudoInversa
        
        X_prev = temp;


        error = norm(A*X*A - A, "fro"); //Calculo del error

        if (error < tol){ //Verifica la condicion del error y la tolerancia 
            break;
        }



    }

    std::cout << "El error esta dado por " << error <<  "\n";
    return X;

}

int main(){

    mat A = generarMatriz();
    mat x = pseudoInversa(A);




}

