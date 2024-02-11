function non_zero_elements = getNonZeroElements(A, idx)
    % getNonZeroElements Extracts non-zero elements from a matrix given their indices.
    %
    % Inputs:
    % - A: A n1 x n2 matrix from which to extract non-zero elements.
    % - idx: A 2 x m matrix of indices, where the first row contains the row
    %   indices and the second row contains the column indices of the non-zero elements.
    %
    % Output:
    % - non_zero_elements: A vector containing all the non-zero elements of A
    %   specified by the indices in idx.

    % Extract row indices of non-zero elements
    row_indices = idx(1,:);
    
    % Extract column indices of non-zero elements
    col_indices = idx(2,:);
    
    % Use the row and column indices to extract the non-zero elements from A
    non_zero_elements = A(sub2ind(size(A), row_indices, col_indices));
end
