%%
% Robust M-Estimation Using Huber's Loss
%%
clear variables
close all hidden
[n1, n2, rank] = deal(150, 300, 10);
X = randn(n1, rank) * randn(rank, n2);

sampling_rate = 0.45;  % Obervation ratio
dB = 9;      % SNR
%%

% Get X_Omega which is sampled but noise free
array_Omega = binornd(1, sampling_rate, [n1, n2]);
X_Omega = X.*array_Omega;

% Get sampling projection matrix wherever its 1. But I believe the algorithm requires array_Omega containing both 1's and 0's
% not just 1's. But to generate the GMM noise, it will be added to the
% whole matrix no or just the non-zero elements? Now that I see that the
% equation has X = M + S + N hence noise added to M i.e. the non-zero
% entries only I believe.

% We get the noise and generate a dummy noise matrix and enter its non-zero
% indexes witht the noise we get and then add it to X_Omega
omega = find(array_Omega(:) == 1);
noise = Gaussian_noise(X_Omega(omega),'GM',dB);

Noise = zeros(size(X_Omega));
Noise(omega) = noise;

X_Omega = X_Omega + Noise;
maxiter = 1000;

% Pass corrputed matrix X_Omega, the sampling matrix, array_Omega and rank
% and maxiter
% r
[X_recovered, loss_recovered] = rmc_huber(X_Omega, array_Omega, rank, maxiter);

fprintf('\nMinimum MSE Loss with Huber M Estimation: %d', min(loss_recovered))

figure
semilogy(loss_recovered,'r','LineWidth',1.2);
% hold on
% semilogy(MSE,'k--','LineWidth',1.2);

xlabel('Iteration number');
ylabel('RMSE');
legend('Huber Estimation RMC','Interpreter','LaTex');
figure_setting(1.5, 15, 600, 500)



