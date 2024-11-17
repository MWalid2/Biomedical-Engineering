function A = Matrice_P_def(M, N)

    % Initialiser la matrice A de taille (M*N) x (M*N)
    totalSize = M * N;
    % Define the range parameters
    xmin = 5; xmax = 10; ymax = 5;
    xmin2 = 10; xmax2 = 15; ymax2 = 10;
    xmin3 = 15; xmax3 = 20; ymax3 = 15;
    xmin4 = 30; xmax4 = 35;
    xmin5 = 35; xmax5 = 40;
    xmin6 = 40; xmax6 = 45;
    

    A = zeros(totalSize, totalSize);
    be = @(i, j, N) j + (i-1)*N; % Bijection formula
    inverse_be = @(K, N) [floor((K-1)/N) + 1, mod(K-1, N) + 1];
    for k = 1:M*N
        x = inverse_be(k,N);
        i = x(1);
        j = x(2);   
        if i == 1 || i == M
            A(k,k)=1;
        end
        if j== 1
            if i ~= 1 && i ~= M 
                A(k, be(i, j+2, N)) = 1;
                A(k, be(i, j+1, N)) = -2;
                A(k,k) = 1;
            end
        end
        if i == 2 && j~=1 
            A(k, be(i-1, j, N)) =1;
            A(k, be(i+1, j, N)) = 1;
            A(k,k) =-2;
        end
        if i == xmax3 && j~=1 && N-j>ymax3 || i == xmax6 && j~=1 && N-j>ymax3 || i == xmax2 && j~=1 && N-j>ymax2 || i == xmax5 && j~=1 && N-j>ymax2 || i == xmax && j~=1 && N-j>ymax || i == xmax4 && j~=1 && N-j>ymax || i == xmax3 && j~=1 && N-j>ymax3 || i == xmax6 && j~=1 && N-j>ymax3 || i == xmax2 && j~=1 && N-j>ymax2 || i == xmax5 && j~=1 && N-j>ymax2 || i == xmin && j~=1 && N-j>ymax || i == xmin4 && j~=1 && N-j>ymax
            A(k, be(i-1, j, N)) =1;
            A(k, be(i+1, j, N)) = 1;
            A(k,be(i, j, N)) =-2;
        end
        if N-j == ymax && i == xmax|| N-j == ymax2 && i == xmax2 || N-j == ymax3 && i == xmax3 || N-j == ymax && i == xmax4|| N-j == ymax2 && i == xmax5 || N-j == ymax3 && i == xmax6
            A(k, be(i, j, N)) = 1;
            A(k, be(i, j-1, N)) = -1;
            A(k, be(i, j+2, N)) = 1;
            A(k, be(i, j+1, N)) = -2;
        end
        if N-j <= ymax && i<xmax && xmin<i ||N-j < ymax2 && i<xmax2 && xmin2<i ||N-j < ymax3 && i<xmax3 && xmin3<i || N-j <= ymax && i<xmax4 && xmin4<i ||N-j < ymax2 && i<xmax5 && xmin5<i ||N-j < ymax3 && i<xmax6 && xmin6<i
            A(k,k)=1;
            if N-j == ymax || N-j == ymax2 || N-j == ymax3
                A(k, be(i, j-1, N)) = -1;
            end
        end
        if  N-j <ymax && i == xmin || N-j <ymax2 && i == xmin2 || N-j <ymax3 && i == xmin3 || N-j <ymax && i == xmin4 || N-j <ymax2 && i == xmin5 || N-j <ymax3 && i == xmin6
            A(k, be(i, j, N)) = 1;
            A(k, be(i-1, j, N)) = -1;
        end
        if  N-j <ymax && i == xmax || N-j <ymax2 && i == xmax2 || N-j <ymax3 && i == xmax3 || N-j <ymax && i == xmax4 || N-j <ymax2 && i == xmax5 || N-j <ymax3 && i == xmax6
            A(k, be(i, j, N)) = -1;
            A(k, be(i+1, j, N)) = 1;
        end
     end
end