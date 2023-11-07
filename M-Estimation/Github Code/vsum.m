function [v_sum] = vsum(V, indices, row)
[rank, ~] = size(V);
v_sum = zeros(rank, 1);
% Iterate through each column's indices and columns
% for j = 1:dim
indices = indices{row};  % Get the indices for the j-th column
for j = indices
    % Find the values in the X matrix for the i-th index and j-th column
    vector = V(:, j);
    v_sum = v_sum + vector;
end

% end