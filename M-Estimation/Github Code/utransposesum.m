function [u_sum] = utransposesum(U, indices, col)
[~, rank] = size(U);
u_sum = zeros(1, rank)';
% Iterate through each column's indices and columns
% for j = 1:dim
indices = indices{col};  % Get the indices for the j-th column
for i = 1: length(indices)
    % Find the values in the X matrix for the i-th index and j-th column
    vector = U(indices(i), :)';
    u_sum = u_sum + vector;
end
% end