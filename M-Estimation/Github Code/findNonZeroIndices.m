function array_Omega = findNonZeroIndices(M_Omega)
    % findNonZeroIndices Finds the indices of non-zero elements in a matrix and
    % returns them in a specified 2x(number of non-zero elements) format.
    %
    % Input:
    % - M_Omega: A matrix to search for non-zero elements.
    %
    % Output:
    % - array_Omega: A 2xM matrix where the first row contains the row indices and
    %   the second row contains the column indices of the non-zero elements in M_Omega.

    % Find linear indices of non-zero elements in M_Omega
    linear_indices = find(M_Omega);
    
    % Convert linear indices to row and column indices
    [row_indices, col_indices] = ind2sub(size(M_Omega), linear_indices);
    
    % Combine row and column indices into the array_Omega format
    array_Omega = [row_indices'; col_indices'];
end
