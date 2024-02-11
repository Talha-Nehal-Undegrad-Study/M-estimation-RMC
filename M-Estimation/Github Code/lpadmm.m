function [Out_X] = lpadmm(M_Omega,Omega, rank, tolerance)
% This matlab code implements the lp - ADMM 
% method for Matrix Completion.
%
% M - m x n matrix of observations/data (required input)
%
% Omega is the subset
%
% maxIter - maximum number of iterations
%         - DEFAULT 500, if omitted or -1.

% Initialization
[n1, n2] = size(M_Omega);
[~, card_omega] = size(Omega); % card_omega denotes the cardinality of the Omega aka the number of nonzero entries
e = zeros(card_omega);         % Denotes the observed entries of the expression (UV)_omega - X_omega therefore its of shape card_omega
lambda = zeros(card_omega);    % Denotes the lagrange multiplies or dual variables of only the nonzero entries therefore of shape card_omega

E_omega = zeros(n1, n2);       % Since e for now is zeros, E_omega is also zeros
Lambda_omega = zeros(n1, n2)   % Since lambda for now is zeros, Lambda_omega is also zeros

mu = 5;                        % penalty parameter taken to be the same value as in the paper


while true % When tolerance level is achieved we stop.
    % Solve LS factorization X as (E_omega -  Lambda_omega / mu + X_omega)
    [~, U, V] = LP2((E_Omega - (Lambda_omega ./ mu) + M_Omega), Omega, rank);

    % Compute Y_omega as (T)_omega + Lambda_Omega / mu - X_Omega where
    % T_Omega = (U * V)
    T_omega = (U * V);
    Y_omega = T_omega + (Lambda_omega ./ mu) - M_Omega;

    % Form y_omega and t_omega as the nonzero elements of their big letter
    % counterparts
    y_omega = getNonZeroElements(Y_omega, Omega);
    t_omega = getNonZeroElements(T_omega, Omega);

    % Apply soft-thresholding on e
    % Calculate the element-wise sign of y
    sgn_y = sign(y);
    
    % Calculate the modified magnitude of each element in y
    magnitude = max(abs(y) - 1/mu, 0);
    
    % Apply the sign back to the modified magnitudes
    e = sgn_y .* magnitude;

    % Update dual variables using gradient ascent
    lambda = lambda + mu(t_omega - e - getNonZeroElements(M_Omega));
    
    X = U * V;
    if norm(t_omega - e - getNonZeroElements(M_Omega), 2) <= tolerance
        break;
    end

end
Out_X = X;
end

