function [PSNR, SSIM] = image_inpainting(M, M_Omega, rak, maxiter, model)

%% Get array_Omega for L0-BCD format and Lp-reg/Lp-admm format
array_Omega_L0 = (M_Omega ~= 0); % L0-BCD Format
array_Omega_Lp = findNonZeroIndices(M_Omega); %Lp-reg/Lp-admm

% Condition on Model
switch model
    case 'L0-BCD'
        [X, ~, ~] = L0_BCD(M, M_Omega, array_Omega_L0, rak, maxiter);
    case 'Lp-reg'
        X = LP1(M_Omega, array_Omega_Lp, rak, maxiter);
    case 'Lp-ADMM'
        X = lpadmm(M_Omega, array_Omega_Lp, rak, 10^-2, maxiter);
    case 'ORMC'
        X = ORMC(M_Omega, array_Omega_L0, rak, maxiter);
    case 'M-Estimation'
        [X, ~, ~] = M_Est(M_Omega, array_Omega_L0, rak, 10^-2, maxiter);
end
PSNR = psnr(X, M);
SSIM = ssim(X, M);
end