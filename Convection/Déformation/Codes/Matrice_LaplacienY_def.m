function A = Matrice_LaplacienY_def(M, N, L, D)

    % Paramètres de discrétisation
    delta_x = L / (M - 1);
    delta_y = D / (N - 1);
    be = @(i, j, N) j + (i-1)*N; % Bijection formula
    inverse_be = @(K, N) [floor((K-1)/N) + 1, mod(K-1, N) + 1];
    % Coefficients a, b, c
    b = 1/delta_x;
    c = 1/delta_y;
    B = b^2;
    C = c^2;
    a = -2 * (B+ C);
    % Define the range parameters
    xmin = 5; xmax = 10; ymax = 5;
    xmin2 = 10; xmax2 = 15; ymax2 = 10;
    xmin3 = 15; xmax3 = 20; ymax3 = 15;
    xmin4 = 30; xmax4 = 35;
    xmin5 = 35; xmax5 = 40;
    xmin6 = 40; xmax6 = 45;
    
    % Example of using these ranges with a deformer function
    L1 = deformation(xmin, xmax, ymax,N);
    L2 = deformation(xmin2, xmax2, ymax2,N);
    L3 = deformation(xmin3, xmax3, ymax3,N);
    L4 = deformation(xmin4, xmax4, ymax,N);
    L5 = deformation(xmin5, xmax5, ymax2,N);
    L6 = deformation(xmin6, xmax6, ymax3,N);
    L = [L1; L2; L3; L4; L5; L6];
    % Initialiser la matrice A de taille (M*N) x (M*N)
    totalSize = M * N;
    A = zeros(totalSize, totalSize);

    for k = 1:M*N
        x = inverse_be(k,N);
        i = x(1);
        j = x(2);
        if i ~= 1 && i ~= M && j ~= 1 && j ~= N && ~ismember(x, L,'rows')
            A(k, be(i+1, j, N)) = B;
            A(k, be(i-1, j, N)) = B;
            A(k, be(i, j+1, N)) = C;
            A(k, be(i, j-1, N)) = C;
            A(k, k) = a;
        end
        if j == 1 || j == N || i == 1 || i == M
            A(k,k) = 1;
        end
        if ismember(x, L1, 'rows') || ismember(x, L2, 'rows') || ismember(x, L3, 'rows') || ismember(x, L4, 'rows') || ismember(x, L5, 'rows') || ismember(x, L6, 'rows')
            A(k,k)=1;
        end
    end
end