function G = Matrice_generale_def(M,N,L,D,a)

    G = zeros(3*M*N,3*M*N);
    A = Matrice_LaplacienX_def(M,N,L,D);
    A_1= Matrice_LaplacienY_def(M,N,L,D);
    B = Matrice_DerivX_P_def(M,N,L);
    B_1 = Matrice_DerivY_P_def(M,N,D);
    C = Matrice_DerivX_def(M,N,L);
    C_1 = Matrice_DerivY_def(M,N,D);
    P = Matrice_P_def(M,N);
    
    G(1:M*N,1:M*N) = a*A;
    G(1:M*N,2*M*N +1:3*M*N) =-B;
    G(M*N +1:2*M*N,M*N +1:2*M*N) = a*A_1;
    G(M*N +1:2*M*N,2*M*N +1:3*M*N) =-B_1;
    G(2*M*N +1:3*M*N,1:M*N) = C;
    G(2*M*N +1:3*M*N,M*N+1:2*M*N) = C_1;
    G(2*M*N +1:3*M*N,2*M*N +1:3*M*N) = P;
end
