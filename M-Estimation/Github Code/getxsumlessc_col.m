function [sum] = getxsumlessc_col(X_Omega, indices, col, c)
sum = 0;
% Iterate through each column's indices and columns
% for j = 1:dim
indices = indices{col};  % Get the indices for the j-th column
for i = indices
    % Find the values in the X matrix for the i-th index and j-th column
    value = X_Omega(i, col);
    if value <= c
        sum = sum + value;
    end
end
% end