function [X, U, V] = M_Est(data, Omega, r, eps, maxiter)
    % Parse input
    [n1, n2] = size(data);
    
    % Initialize
    U = randn(n1, r);
    V = randn(r, n2);
    finished = false;
    counter = 0;     % counts the number of iterations
    
    
    % Optimize U and V
    while ~finished
        % update V
        for j = 1:n2
            % find relevant entries in data for column j
            idx = Omega(:, j);
            U_idx = U(idx, :);
            b_idx = data(idx, j); 
            
            V(:, j) = hubreg(b_idx, U_idx, 1.345, [], V(:, j));
        end
            
        % update U
        U_new = U;
        for i = 1:n1
            % find relevant entries in data for row i
            idx = Omega(i, :);
            V_idx = V(:, idx)';
            b_idx = data(i, idx);
            
            U_new(i, :) = hubreg(b_idx', V_idx, 1.345, [], U(i, :)')';
        end

        counter = counter + 1;
        
        % Check termination conditions
        if counter >= maxiter
            finished = true;
            disp('Maxiter was reached during robust matrix completion. Consider increasing it.');
        end
        
        if sum(abs(U_new - U), 'all') / (n1 * n2) < eps
            finished = true;
        end
        U = U_new;
    end
            
    X = U * V;
end