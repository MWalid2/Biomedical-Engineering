function A = Matrice_DerivY_P_def(M, N, D)

    % Paramètres de discrétisation
    delta_y = D / (N - 1);

    % Coefficients a, b, c
    be = @(i, j, N) j + (i-1)*N; % Bijection formula
    inverse_be = @(K, N) [floor((K-1)/N) + 1, mod(K-1, N) + 1];
    b = 1/(delta_y);
    % Define the range parameters as a matrix
    % Each row is [xmin, xmax, ymax]
    ranges = [
    % First group
    6, 8, 3;
    8, 10, 5;
    10, 12, 7;
    12, 14, 9;
    14, 16, 11;
    16, 18, 13;
    18, 20, 15;
    20, 22, 17;
    22, 24, 19;
    
    % Introduce space by adjusting the second group
    26, 28, 3;  % Space created between 24 and 26
    28, 30, 5;
    30, 32, 7;
    32, 34, 9;
    34, 36, 11;
    36, 38, 13;
    38, 40, 15;
    40, 42, 17;
    42, 44, 19;
    ];

    % Deformations list
    L = [];
    for r = 1:size(ranges, 1)
        xmin = ranges(r, 1);
        xmax = ranges(r, 2);
        ymax = ranges(r, 3);
        L = [L; deformation(xmin, xmax, ymax, N)];
    end

    % Initialiser la matrice A de taille (M*N) x (M*N)
    totalSize = M * N;
    A = zeros(totalSize, totalSize);

    for k = 1:M*N
        x = inverse_be(k,N);
        i = x(1);
        j = x(2);
        if i ~= 1 && i ~= M && j ~= 1 && j ~= N && ~ismember(x,L,'rows')
            A(k, be(i, j+1, N)) = b;
            A(k, be(i, j, N)) = -b;
        end
    end
end

