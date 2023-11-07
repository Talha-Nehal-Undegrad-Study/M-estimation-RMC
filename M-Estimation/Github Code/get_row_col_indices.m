function [indices_col, indices_row] = get_row_col_indices(matrix)
% Function for getting the indices row and column wise where matrix is 1
% 
% Get dimensions of matrix
[n1, n2] = size(matrix);

% First Column wise
indices_col = cell(1, n2);

% Iterate through each column
for i = 1 : n2
    % Find the row indices where the value is 1 in the current column
    indices_col{i} = find(matrix(:, i) == 1);
end

% Now Row wise
indices_row = cell(1, n1);

% Iterate through each column
for i = 1 : n1
    % Find the row indices where the value is 1 in the current column
    indices_row{i} = find(matrix(i, :) == 1);
end
% 
% 


