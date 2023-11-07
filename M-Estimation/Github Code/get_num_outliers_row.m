function [counts] = get_num_outliers_row(c, indices, row)
counts = 0;
% Iterate through each column's indices and columns
% for i = 1:dim
indices = indices{row};  % Get the indices for the j-th column
for j = indices
    % Find the values in the X matrix for the i-th index and j-th column
    value = X(row, j);
    % Count the elements greater than c
    if value > c
        counts = counts + 1;
    end
end
% end