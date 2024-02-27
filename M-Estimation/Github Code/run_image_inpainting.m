%%
% If you use this code, please cite the following paper in your corresponding work. Thanks!
% X. P. Li, Z.-L. Shi, Q. Liu and H. C. So, "Fast robust matrix completion
% via ?0-norm minimization" IEEE Transactions on Cybernetics, 2022.

%%
clear variables
close all hidden
[r, c, rak] = deal(321, 481, 10);
% M = randn(r, rak) * randn(rak, c);

dB = 5;
per = 0.5;
models = {'l0_bcd'};
PSNRs = zeros(length(models), 8);
SSIMs = zeros(length(models), 8);

%%

for m = 1:length(models)
    for i = 1:8
        M = rgb2gray(im2double(imread(['C:\Users\HP\GitHub Workspace\M-estimation-RMC\M-Estimation\Image_Inpainting_Dataset\', num2str(i)], 'jpg')));
        array_Omega = binornd(1, per, [r, c]);
        M_Omega = M .* array_Omega;
        omega = find(array_Omega(:) == 1);
        noise = Gaussian_noise(M_Omega(omega), 'GM', dB);
        Noise = zeros(size(M_Omega));
        Noise(omega) = noise;
        M_Omega = M_Omega + Noise;
        maxiter = 50;
        
        [PSNR, SSIM] = image_inpainting(M, M_Omega, rak, maxiter, models{m});
        PSNRs(m, i) = PSNR;
        SSIMs(m, i) = SSIM;
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