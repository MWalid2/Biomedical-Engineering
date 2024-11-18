function Comparaison_def(M, N, L, D, a, P0, P1)
    % Define ranges [xmin, xmax, ymax]
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
        26, 28, 3;
        28, 30, 5;
        30, 32, 7;
        32, 34, 9;
        34, 36, 11;
        36, 38, 13;
        38, 40, 15;
        40, 42, 17;
        42, 44, 19;
    ];

    % Generate deformation list L from all ranges
    L_combined = [];
    for r = 1:size(ranges, 1)
        xmin = ranges(r, 1);
        xmax = ranges(r, 2);
        ymax = ranges(r, 3);
        L_combined = [L_combined; deformation(xmin, xmax, ymax, N)];
    end

    % Compute the velocity components and pressure
    [Ux1, Uy1, P] = vecteur_G_def(M, N, L, D, a, P0, P1);
    [Ux2, Uy2, P] = vecteur_G_def(M, N, L, D, a, P1, P0);

    % Compute the velocity magnitude
    U1 = sqrt(Ux1.^2 + Uy1.^2);
    U1 = reshape(U1, N, M);
    U2 = sqrt(Ux2.^2 + Uy2.^2);
    U2 = reshape(U2, N, M);

    % Initialize the X vector and calculate mean flows
    X = zeros(M, 1);
    Qg = zeros(M, 1);
    Qd = zeros(M, 1);
    delta_y = D / (N - 1); % Step in the y-direction

    for i = 1:M
        % Determine if i is within any range and calculate Dx accordingly
        Dx = D; % Default section
        for r = 1:size(ranges, 1)
            xmin = ranges(r, 1);
            xmax = ranges(r, 2);
            ymax = ranges(r, 3);
            if i >= xmin && i <= xmax
                Dx = D - ymax * delta_y;
                break; % Use the first matching range
            end
        end

        % Exclude elements in L_combined for U1 and U2
        valid_rows = true(N, 1); % Default: all rows are valid
        for j = 1:N
            x = [i, j];
            if ismember(x, L_combined, 'rows')
                valid_rows(j) = false;
            end
        end

        % Compute mean flows excluding invalid points
        Qg(i, 1) = mean(U1(valid_rows, i)) * Dx;
        Qd(i, 1) = mean(U2(valid_rows, i)) * Dx;
        X(i, 1) = (i - 1) * L / (M - 1);
    end

    % Apply smoothing to the flow curves
    smoothing_window = 5; % Number of points for moving average
    Qg= movmean(Qg, smoothing_window);
    Qd= movmean(Qd, smoothing_window);
   

    % Create the first subplot for Debit à gauche and Debit à droite
    subplot(2, 1, 1); % Divide the figure into a 2x1 grid and select the first part
    plot(X, Qg, 'r-', 'DisplayName', 'Debit à gauche');
    hold on;
    plot(X, Qd, 'b-', 'DisplayName', 'Debit à droite ');
    legend('show');
    title('Débit à gauche et à droite');
    xlabel('X');
    ylabel('Débit');
    hold off;

    % Create the second subplot for the difference plot
    subplot(2, 1, 2); % Select the second part of the 2x1 grid
    plot(X, Qd-Qg, 'g-', 'DisplayName', 'Différence');
    legend('show');
    title('Différence de débit');
    xlabel('X');
    ylabel('Différence');
end
