function [Out_X, loss] = hubreg_repli(X_Omega, array_Omega, rank, maxiter)
%% Initialization
[n1, n2] = size(X_Omega);
c = 1.345;
U_1 = rand(n1, rank);
V_1 = zeros(rank, n2);
[indices_col, indices_row] = get_row_col_indices(array_Omega);

u_cell = cell(1, maxiter);
u_cell{1} = U_1;

v_cell = cell(1, maxiter);
V_1 = rand(rank, n2);
v_cell{1} = V_1;

final_sigmas = cell(1, maxiter);

% For storing loss
loss = zeros(1, maxiter);
%%
% Implementing the Algorithm here
for i = 1:maxiter
    sigma_cell_for_v = cell(1, n2 + 1);
    sigma_cell_for_v{1} = rand(1);

    v_upd = v_cell{i};
    % Apped random guess initially
    for j = 1: n2
        [vj_kupd, scale_kupd, iter, ~] = hubreg(getxj(X_Omega, indices_col, j), get_u(u_cell{i}, indices_col, j), c, sigma_cell_for_v{j}, v_upd(:, j), n2);
        v_upd(:, j) = vj_kupd;
        sigma_cell_for_v{j + 1} = scale_kupd;
    end
    v_cell{i + 1} = v_upd;

    sigma_for_u = cell(1, n1 + 1);
    sigma_for_u{1} = sigma_cell_for_v{end};
    
    u_upd = u_cell{i};
    for z = 1:n1
       [ui_upd, scale_kupd, iter, ~] = hubreg(getxi(X_Omega, indices_row, z), (get_v(v_cell{i + 1}, indices_row, z))', c, sigma_for_u{z}, (u_upd(z, :))', n1);
        u_upd(z, :) = ui_upd;
        sigma_cell_for_v{z + 1} = scale_kupd;
    end
    u_cell{i + 1} = u_upd;
    final_sigmas{i} = sigma_for_u{end};

    squared_differences = (u_cell{i + 1} * v_cell{i + 1} - X_Omega).^2;

    % Step 2: Calculate the mean of squared differences
    mean_squared_difference = mean(squared_differences(:));
    
    % Step 3: Take the square root to obtain RMSE
    rmse = sqrt(mean_squared_difference);
    
    % Step 4: Store rmse
    loss(i) = rmse;
    fprintf("Loss at iteration %d: %f\n", i, rmse)
end
% After the iterations, take the last updated UV and return their dot
% product as the final prediction
Out_X = u_cell{end} * v_cell{end};
end
