% Initialization

db = [-9, -6, -3];
observation_ratio = [0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8];

r = 150;
c = 300;
rank = 10;
maxiter = 1000;
num_trials = 1;

% Preallocate arrays to hold the averaged normalized loss
% loss_normalized_L1 = zeros(length(db), length(observation_ratio));
loss_normalized_L2 = zeros(length(db), length(observation_ratio));

% Main loops
for i = 1:length(db)
    for j = 1:length(observation_ratio)
        % loss_L1 = zeros(1, num_trials);
        loss_L2 = zeros(1, num_trials);
        
        for trial = 1:num_trials
            % Generate the matrices
            [M, M_Omega, array_Omega] = lp_reg_generation(r, c, rank, db(i), observation_ratio(j));
            
            % Run L1 regression
            % Out_X_L1 = LP1(M_Omega, array_Omega, rank, maxiter);

            % Compute normalized MSE loss for L1
            % loss_L1(trial) = norm(Out_X_L1 - M, 'fro')^2 / (r*c);
            
            % Run L2 regression
            Out_X_L2 = LP2(M_Omega, array_Omega, rank, maxiter);
            % Compute normalized MSE loss for L2
            loss_L2(trial) = norm(Out_X_L2 - M, 'fro')^2 / (r*c);
        end
        
        % Average the loss over trials
        % loss_normalized_L1(i, j) = mean(loss_L1);
        loss_normalized_L2(i, j) = mean(loss_L2);
        % fprintf('Average Normalized Loss with L1 regression with DB = %f, Observation Ratio = %f is %f\n', db(i), observation_ratio(j), loss_normalized_L1(i, j));
        fprintf('Average Normalized Loss with L2 regression with DB = %f, Observation Ratio = %f is %f\n', db(i), observation_ratio(j), loss_normalized_L2(i, j));

    end
end

% Plotting
% For a comprehensive plot, we might plot each observation ratio as a separate line
figure;
hold on;
colors = jet(length(observation_ratio)); % Color scheme for different observation ratios
for j = 1:length(observation_ratio)
    % plot(db, loss_normalized_L1(:, j), 'o-', 'Color', colors(j,:), 'DisplayName', ['L1, Ratio ' num2str(observation_ratio(j))]);
    plot(db, loss_normalized_L2(:, j), 'x--', 'Color', colors(j,:), 'DisplayName', ['L2, Ratio ' num2str(observation_ratio(j))]);
end
legend('show');
xlabel('dB Level');
ylabel('Average Normalized MSE Loss');
title('L1 vs. L2 Regression Loss');
grid on;
hold off;

% Note: Finally, it is worth pointing out that the n2 problems
% of (19) and n1 problems of (22) are independent and hence can
% be realized in a parallel or distributed manner. As the number of
% processors increases, the complexity reduces
