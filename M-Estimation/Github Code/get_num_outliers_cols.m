function [counts] = get_num_outliers_cols(X, c, indices, col)
counts = 0;
% Iterate through each column's indices and columns
% for j = 1:dim
indices = indices{col};  % Get the indices for the j-th column
for i = indices
    % Find the values in the X matrix for the i-th index and j-th column
    value = X(i, col);
    % Count the elements greater than c
    if value > c
        counts = counts + 1;
    end
end
% end