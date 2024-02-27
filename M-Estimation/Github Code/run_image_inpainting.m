%%
% If you use this code, please cite the following paper in your corresponding work. Thanks!
% X. P. Li, Z.-L. Shi, Q. Liu and H. C. So, "Fast robust matrix completion
% via ?0-norm minimization" IEEE Transactions on Cybernetics, 2022.

%%
clear variables
close all hidden
[r, c, rak] = deal(150, 300, 10);
% M = randn(r, rak) * randn(rak, c);

dB = 5;
per = 0.5;

%%

M = randn(r, rak) * randn(rak, c);
array_Omega = binornd(1, per(p), [r, c]);
M_Omega = M .* array_Omega;
omega = find(array_Omega(:) == 1);
noise = Gaussian_noise(M_Omega(omega), 'GM', dB(d));
Noise = zeros(size(M_Omega));
Noise(omega) = noise;
M_Omega = M_Omega + Noise;
maxiter = 50;

[X, MSE, loss] = L0_BCD(M, M_Omega, array_Omega, rak, maxiter);
matrix(d, p) = min(MSE);

%%

% figure
% semilogy(MSE,'k--','LineWidth',1.2);
% 
% xlabel('Iteration number');
% ylabel('MSE');
% legend('$\ell_0$-BCD','Interpreter','LaTex');

% Plotting
% For a comprehensive plot, we might plot each observation ratio as a separate line