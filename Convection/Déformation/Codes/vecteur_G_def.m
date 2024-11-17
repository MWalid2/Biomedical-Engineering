function [Ux,Uy,P] = vecteur_G_def(M,N,L,D,a,P0,P1)
    A = Matrice_generale_def(M,N,L,D,a);
    Y = vecteur_valeurG(M,N,P0,P1);
    A = A + eye(size(A)) * 1e-8;
    X = A\Y;
    Ux = X(1:M*N);
    Uy = X(M*N+1:2*M*N);
    P = X(2*M*N+1:3*M*N);
end