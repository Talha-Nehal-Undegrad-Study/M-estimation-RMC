%%
% If you use this code, please cite the following paper in your corresponding work. Thanks!
% X. P. Li, Z.-L. Shi, Q. Liu and H. C. So, "Fast robust matrix completion
% via ?0-norm minimization" IEEE Transactions on Cybernetics, 2022.

%%
clear variables
close all hidden
[r, c, rak] = deal(400,500,10);
M = randn(400, 10)* randn(10,500);

% per = 0.5;  % Obervation ratio
% dB =3;      % SNR

dB = [3, 5, 6, 9];
per = [0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8];

%%

matrix = zeros(length(dB), length(per));

for p = 1:length(per)
    for d = 1:length(dB)
        array_Omega = binornd( 1, per(p), [ r, c ] );
        M_Omega = M.*array_Omega;
        omega = find(array_Omega(:)==1);
        noise = Gaussian_noise(M_Omega(omega),'GM',dB(d));
        Noise = zeros(size(M_Omega));
        Noise(omega) = noise;
        M_Omega = M_Omega + Noise;
        maxiter = 50;
        
        [X, MSE, loss] = L0_BCD(M,M_Omega,array_Omega,rak, maxiter);
        matrix(d, p) = min(MSE);
    end
end

%%

% figure
% semilogy(MSE,'k--','LineWidth',1.2);
% 
% xlabel('Iteration number');
% ylabel('MSE');
% legend('$\ell_0$-BCD','Interpreter','LaTex');

% Plotting
% For a comprehensive plot, we might plot each observation ratio as a separate line
figure;
hold on;
colors = jet(length(per)); % Color scheme for different observation ratios
for j = 1:length(per)
    plot(dB, matrix(:, j), 'x--', 'Color', colors(j,:), 'DisplayName', ['L_0-BCD, Ratio ' num2str(per(j))]);
end
legend('show');
xlabel('dB Level');
ylabel('Average Normalized MSE Loss');
title('L_0-BCD Regression Loss');
grid on;
hold off;