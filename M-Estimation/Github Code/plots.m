clc; clear; close all;

mat_files = {'ormc_loss_results.mat', 'lp_admm_loss_results.mat', 'lp_loss_results.mat', 'm_est_loss_results.mat', 'l0_bcd_loss_results'};
lgd = {'ORMC', '$\ell_p$-ADMM', '$\ell_p$-reg', 'M-estimation', '$\ell_0$-BCD'};
num_files = numel(mat_files);
matrices  = cell(num_files, 1);

for i = 1:num_files
    matrices{i} = load(mat_files{i}).matrix;
end

snr = [3, 5, 6, 9];
obs = [0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8];

folder_name = 'By Observation Rate';

if ~exist(folder_name, 'dir')
    mkdir(folder_name);
end

for i = 1:length(obs)
    figure;
    z = zeros(length(snr), num_files);

    for j = 1:num_files
        z(:, j) = matrices{j}(:, i);
    end

    bar(z);
    title(sprintf('MSE vs SNR | Observation Rate = %f', obs(i)));
    xlabel('SNR');
    ylabel('MSE');
    xticklabels(snr);
    yscale log;
    legend(lgd, 'Interpreter', 'LaTex');

    file_name = sprintf('%s/MSE_vs_SNR_Observation_Rate_%f.png', folder_name, obs(i));
    saveas(gcf, file_name);
end

folder_name = 'By SNR';

if ~exist(folder_name, 'dir')
    mkdir(folder_name);
end

for i = 1:length(snr)
    figure;
    z = zeros(length(obs), num_files);

    for j = 1:num_files
        z(:, j) = matrices{j}(i, :);
    end

    bar(z);
    title(sprintf('MSE vs Observation Rate | SNR = %f', snr(i)));
    xlabel('Observation Rate');
    ylabel('MSE');
    xticklabels(obs);
    yscale log;
    legend(lgd, 'Interpreter', 'LaTex');

    file_name = sprintf('%s/MSE_vs_Observation_Rate_SNR_%f.png', folder_name, snr(i));
    saveas(gcf, file_name);
end