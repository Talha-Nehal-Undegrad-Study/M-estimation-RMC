%%
% Runs each algorithm on image inpainting task and stores PSNR and SSIM as
% metrics

%%
clear variables
close all hidden
[r, c, rak] = deal(400, 500, 10);
% M = randn(r, rak) * randn(rak, c);

dB = 5;
per = 0.5;
models = {'L0-BCD', 'Lp-reg', 'Lp-ADMM', 'ORMC', 'M-Estimation'};
PSNRs = zeros(length(models), 8);
SSIMs = zeros(length(models), 8);

%%

for m = 1:length(models)
    for i = 1:8
        % Read Image and convert into black and white and reshape into 
        % 150 x 300
        % Nehal' PATH: C:\Users\HP\GitHub Workspace\M-estimation-RMC\M-Estimation\Image_Inpainting_Dataset\
        % Talha's PATH: C:\Users\Talha\OneDrive - Higher Education Commission\Documents\GitHub\M-estimation-RMC\M-Estimation\Image_Inpainting_Dataset\
        M = imresize(rgb2gray(im2double(imread(['C:\Users\Talha\OneDrive - Higher Education Commission\Documents\GitHub\M-estimation-RMC\M-Estimation\Image_Inpainting_Dataset\', num2str(i)], 'jpg'))), [r, c]);

        % Add GMM noise
        array_Omega = binornd(1, per, [r, c]);
        M_Omega = M .* array_Omega;
        omega = find(array_Omega(:) == 1);
        noise = Gaussian_noise(M_Omega(omega), 'GM', dB);
        Noise = zeros(size(M_Omega));
        Noise(omega) = noise;
        M_Omega = M_Omega + Noise;
        maxiter = 50;
        

        [PSNR, SSIM] = image_inpainting(M, M_Omega, rak, maxiter, models{m});
        fprintf('Model: %s, PSNR of Image %i = %f, SSIM of Image %i = %f', models{m}, i, PSNR, i, SSIM);
        
        PSNRs(m, i) = PSNR;
        SSIMs(m, i) = SSIM;
    end
end