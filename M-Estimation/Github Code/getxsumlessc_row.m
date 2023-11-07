function [sum] = getxsumlessc_row(X_Omega, indices, row, c)
sum = 0;
% Iterate through each column's indices and columns
% for j = 1:dim
indices = indices{row};  % Get the indices for the j-th column
for j = indices
    % Find the values in the X matrix for the i-th index and j-th column
    value = X_Omega(row, j);
    if sum <= c
        sum = sum + value;
    end
end
% end