%% Creat a function which takes the dimensions of the matrix r x c and its rank along with the observation ratio and db noise
function [M, M_Omega, array_Omega] = lp_reg_generation(r, c, rank, db, sampling_rate)
%% Define sampling projection matrix array_Omega
array_Omega = binornd(1, sampling_rate, [r, c]);
%% generate noisy + sampled data
M = randn(r, rank) * randn(rank, c);
M_Omega = M .* array_Omega;
omega = find(array_Omega(:) == 1);
sampling_rate = Gaussian_noise(M_Omega(omega), 'GM', db);
Noise = zeros(size(M_Omega));
Noise(omega) = sampling_rate;
M_Omega = M_Omega + Noise;
%% Generate Omega in the format discussed
% linear_indices = find(M_Omega);

% [row_indices, col_indices] = ind2sub(size(M_Omega), linear_indices);

% Combine row and column indices into the Omega format
% array_Omega = [row_indices'; col_indices'];
