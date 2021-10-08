
#define ARMA_USE_LAPACK
#include <armadillo>
#include <iostream>

using namespace arma;



mat generarMatriz()
{
    int row = 2;
    int column = 3;

    mat A = zeros(row, column);
    for (int i=0; i< row; i++){

        for (int j=0; j<column; j++){

            A(i, j) = pow(i+1,2) + pow(j+1,2);    
            

        }
    }

    return A;


}


mat pseudoInversa(mat A)
{


    double alpha_0 = 5e-10;
    double alpha_1 = 2e-11;
    double tol = 10-5;

    mat X0 = alpha_0*A.t();
    mat X1 = alpha_1*A.t();


    mat X = X1;
    mat X_prev = X0; 


    int iterMax = 1000;

    for (int k=0; k < iterMax; k++){


        mat temp = X;

        X = X_prev + X - X_prev*A*X;
        
        X_prev = temp;


        double error = norm(A*X*A - A, "fro");
        
        if (error < tol){
            break;
        }



    }

    return X;

}

int main(){

    mat A = generarMatriz();
    mat x = pseudoInversa(A);

    std::cout << A << "\n";
    std::cout << x << "\n";


}

