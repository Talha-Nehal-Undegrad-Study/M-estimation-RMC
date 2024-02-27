% Dependancies: algo_synthetic_generation, ORMC
% Initialization

db = [3, 5, 6, 9]; % DB values cant be negative for some reason - loss was in millions!
observation_ratio = [0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8];

r = 150;
c = 300;
rank = 10;
maxiter = 500;
num_trials = 1;

% Preallocate arrays to hold the averaged normalized loss
loss_normalized_ORMC = zeros(length(db), length(observation_ratio));

% Main loops
for i = 1:length(db)
    for j = 1:length(observation_ratio)
        % loss_L1 = zeros(1, num_trials);
        loss_ORMC = zeros(1, num_trials);
        
        for trial = 1:num_trials
            % Generate the matrices
            [M, M_Omega, array_Omega] = algo_synthetic_generation(r, c, rank, db(i), observation_ratio(j), '');
            
            % Run ORMC regression
            Out_X_ORMC = (ORMC(M_Omega, array_Omega, rank, maxiter));

            % Compute normalized MSE loss for L2
            loss_ORMC(trial) = norm(Out_X_ORMC - M, 'fro')^2 / (r*c);
        end
        
        % Average the loss over trials
        loss_normalized_ORMC(i, j) = mean(loss_ORMC);
        fprintf('Average Normalized Loss with ORMC regression with DB = %f, Observation Ratio = %f is %f\n', db(i), observation_ratio(j), loss_normalized_ORMC(i, j));
        
        % NOTE: for each value of SNR, loss values initially decrease with
        % increasing obs. ratio, but then start to increase. This is
        % intriguing.
    end
end

% Plotting
% For a comprehensive plot, we might plot each observation ratio as a separate line
figure;
hold on;
colors = jet(length(observation_ratio)); % Color scheme for different observation ratios
for j = 1:length(observation_ratio)
    plot(db, loss_normalized_ORMC(:, j), 'x--', 'Color', colors(j,:), 'DisplayName', ['ORMC, Ratio ' num2str(observation_ratio(j))]);
end
legend('show');
xlabel('dB Level');
ylabel('Average Normalized MSE Loss');
title('ORMC Regression Loss');
grid on;
hold off;
