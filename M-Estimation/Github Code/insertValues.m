function M_updated = insertValues(M, values, idx)
    % insertValues Inserts values from a vector into specified positions of a matrix.
    %
    % Inputs:
    % - M: A matrix where values are to be inserted.
    % - values: A vector containing the values to be inserted into M.
    % - idx: A 2xN matrix of indices, where the first row contains the row indices
    %   and the second row contains the column indices where values should be inserted.
    %
    % Output:
    % - M_updated: The matrix M after inserting the values at the specified indices.

    % Ensure M is not modified in-place
    M_updated = M;
    
    % Convert the row and column indices to linear indices
    linIdx = sub2ind(size(M), idx(1,:), idx(2,:));
    
    % Insert the values into the specified positions in M_updated
    M_updated(linIdx) = values;
end
