% Dependancies: None
function M_masked = maskMatrix(M, idx)
    % maskMatrix Sets elements of M to zero except for those specified in idx.
    %
    % Inputs:
    % - M: A matrix to be masked.
    % - idx: A 2xN matrix of indices, where the first row contains row indices
    %   and the second row contains column indices of elements in M that should not be set to zero.
    %
    % Output:
    % - M_masked: The masked matrix with only the elements specified by idx retained; all other elements set to zero.

    % Create a copy of M to avoid modifying the original matrix
    M_masked = zeros(size(M));
    
    % Linear indices of elements to retain
    linIdx = sub2ind(size(M), idx(1,:), idx(2,:));
    
    % Retain only the specified elements in M_masked
    M_masked(linIdx) = M(linIdx);
end
