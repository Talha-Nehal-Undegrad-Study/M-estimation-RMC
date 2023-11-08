function vector = getxj(mat, indices, col)

    indices = indices{col};  % Get the indices for the j-th column
    vector = zeros(length(indices), 1);
    for i = 1: length(indices)
        % Find the values in the X matrix for the i-th index and j-th column
        value = mat(indices(i), col);
        vector(i) = value;
    end
end