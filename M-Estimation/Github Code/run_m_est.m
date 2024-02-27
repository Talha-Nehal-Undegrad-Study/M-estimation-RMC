clear variables
close all hidden

[r, c, rank] = deal(400, 500, 10);
db = [3];%, 5, 6, 9];
per = [0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8];
matrix = zeros(length(db), length(per));

for p = 1:length(per)
    for d = 1:length(db)
        M = randn(r, rank) * randn(rank, c);
        array_Omega = binornd(1, per(p), [r, c]);
        M_Omega = M .* array_Omega;
        omega = find(array_Omega(:) == 1);
        noise = Gaussian_noise(M_Omega(omega), 'GM', db(d));
        Noise = zeros(size(M_Omega));
        Noise(omega) = noise;
        M_Omega = M_Omega + Noise;
        maxiter = 50;

        [X, U, V] = M_Est(M_Omega, array_Omega == 1, rank, 10^(-4), maxiter);
        % Ms(p, :, :) = M;
        % M_Omegas(p, :, :) = M_Omega;
        % array_Omegas(p, :, :) = array_Omega;

        MSE = norm(X - M, 'fro')^2 / (r * c);
        matrix(d, p) = MSE;
    end
end

figure;
bar(matrix);
title('MSE vs Percentage of Observed Data', 'SNR = 3 | Matrix Size = (150 x 300) | Rank = 10');
xticklabels(per);
xlabel('Percentage of Observed Data');
ylabel('MSE');
legend('M-Estimation', 'Interpreter', 'LaTex');