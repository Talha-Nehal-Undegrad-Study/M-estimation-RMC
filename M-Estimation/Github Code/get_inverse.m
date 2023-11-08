function mat = get_inverse(mat)
mat = ((mat' *  mat)) \ mat';
end
