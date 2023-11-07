function [Out_X, loss] = rmc_huber(X_Omega, array_Omega, rank, maxiter)
%%
% Implementing the Algorithm here

%% 
% Intialize U_1 of dimensions n1 x r and V_1 of dimensions rank x n2
[n1, n2] = size(X_Omega);
U_1 = rand(n1, rank);
V_1 = zeros(rank, n2);
c = 1.345; % for huber
% Intialize a dummy cell array for u and v of size maxiter and each will
% contain updated u and v after each iteration. First index will therefore
% contain the initilizations above

u_cell = cell(1, maxiter);
u_cell{1} = U_1;

v_cell = cell(1, maxiter);
v_cell{1} = V_1;

% For storing loss
loss = zeros(1, maxiter);

% Determine the set of indices where each column of the matrix array_Omega
% is 1 and store it in a cell array where element at index i will correspond
% to an array of indices where the column i of array_Omega is 1. Do the
% same for each row.

[indices_col, indices_row] = get_row_col_indices(array_Omega);

for iter = 1 : maxiter
    % Update V while fixing U column wise
    v_upd = v_cell{iter};
    for j = 1 : n2
        % Get num outlier 
        num_col_outliers = get_num_outliers_cols(X_Omega, c, indices_col, j);
        % Get sum < c for X_Omega
        sumlessc_col = getxsumlessc_col(X_Omega, indices_col, j, c);
        % Get sum of I_j U transpose rows
        u_sum = utransposesum(u_cell{iter}, indices_col, j);
        val = (num_col_outliers + sumlessc_col) ./ u_sum;
        v_upd(:, j) = (num_col_outliers + sumlessc_col) ./ u_sum;
    end
    % Store updated v
    v_cell{iter + 1} = v_upd;
    
    % Update U while fixing Vk+1 row wise

    u_upd = zeros(n1, rank);
    for i = 1 : n1
        % Get num outlier 
        num_row_outliers = get_num_outliers_row(X_Omega, c, indices_row, i);
        % Get sum < c for X_Omega
        sumlessc_row = getxsumlessc_row(X_Omega, indices_row, i, c);
        % Get sum of I_j U transpose rows
        v_sum = vsum(v_cell{iter + 1}, indices_row, i);
        u_upd(i, :) = ((num_row_outliers + sumlessc_row) ./ v_sum)';
    end
    % Store updated u
    u_cell{iter + 1} = u_upd;

    % After one iteration and one update of U and V compute UV and check
    % RMSE with original
    squared_differences = (u_cell{iter + 1} * v_cell{iter + 1} - X_Omega).^2;

    % Step 2: Calculate the mean of squared differences
    mean_squared_difference = mean(squared_differences(:));
    
    % Step 3: Take the square root to obtain RMSE
    rmse = sqrt(mean_squared_difference);
    
    % Step 4: Store rmse
    loss(iter) = rmse;
        
end
% After the iterations, take the last updated UV and return their dot
% product as the final prediction
Out_X = u_cell{end} * v_cell{end};
end


