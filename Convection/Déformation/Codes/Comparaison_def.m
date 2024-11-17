function Comparaison_def(M,N,L,D,a,P0,P1)
    [Ux1, Uy1, P] = vecteur_G_def(M,N,L,D,a,P0,P1);
    [Ux2, Uy2, P] = vecteur_G_def(M,N,L,D,a,P1,P0);
    U1 = sqrt(Ux1.^2 + Uy1.^2);
    U1 = reshape(U1,M,N);
    U2 = sqrt(Ux2.^2 + Uy2.^2);
    U2 = reshape(U2,M,N);
    X = zeros(N,1);
    for i=1:N
        Qg(i,1)=(mean(U1(:,i)))*D;
        Qd(i,1)=(mean(U2(:,i)))*D;
        X(i,1) = (i-1)*D/(N-1);
    end
    plot(X, Qg, 'r-', 'DisplayName', 'Debit à gauche');
    hold on;
    plot(X, Qd, 'b-', 'DisplayName', 'Debit à droite');
    legend('show');
    hold off;
end