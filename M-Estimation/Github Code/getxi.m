function vector = getxi(mat, indices, row)

    indices = indices{row};  % Get the indices for the j-th column
    vector = zeros(length(indices), 1);
    for i = 1: length(indices)
        % Find the values in the X matrix for the i-th index and j-th column
        value = mat(row, indices(i));
        vector(i) = value;
    end
end