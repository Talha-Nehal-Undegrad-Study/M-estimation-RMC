%% Creat a function which takes the dimensions of the matrix r x c and its rank along with the observation ratio and db noise
function [M, M_Omega, array_Omega] = algo_synthetic_generation(r, c, rank, db, sampling_rate, algo)
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
%% Generate Omega in the format discussed if lp_reg or lp_admm algorithm is used
switch algo
    case 'lpreg'
        array_Omega = findNonZeroIndices(M_Omega);
    case 'lpadmm'
        array_Omega = findNonZeroIndices(M_Omega);
end
