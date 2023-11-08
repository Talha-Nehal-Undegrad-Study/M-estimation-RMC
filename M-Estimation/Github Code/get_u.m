function u = get_u(U, indices, col)
[~, rank] = size(U);
% Iterate through each column's indices and columns
% for j = 1:dim
indices = indices{col};  % Get the indices for the j-th column
u = zeros(length(indices), rank);
for i = 1: length(indices)
    % Find the values in the X matrix for the i-th index and j-th column
    vector = U(indices(i), :);
    u(i, :) = vector;
end
% end