function at_matrix = generate_at_matrix(matrix_size, ...
    interaction_prob, d, mode)
%GENERATE_AT_MATRIX This function should generate random matrices that
%correspond to the conditions laid down in Allesian & Tang
%
%Params:
%   mode - This is a flag to indicate which type of A-T Matrix should be
%   generated. The flag settings are:
%       0 = None 
%       1 = Predator/Prey
%       2 = Mutualism
%
    at_matrix = randn(matrix_size, matrix_size);
    at_matrix = matrix_replacement(at_matrix, interaction_prob, mode);
    assert(mode == 0 || mode == 2 || ...
        isequal((triu(at_matrix, 1) == 0)', (tril(at_matrix,-1) == 0)));
    at_matrix = at_transform(at_matrix, mode);
    assert(mode == 0 || mode == 2 ||  ... 
        isequal((triu(at_matrix, 1) > 0)', (tril(at_matrix,-1) < 0)) ...
        && isequal((triu(at_matrix, 1) < 0)', (tril(at_matrix,-1) > 0)))
    zero_mask = (at_matrix ~= 0);
    pos_compare = isequal((triu(at_matrix,1).*tril(zero_mask,-1)') > 0, ...
        (tril(at_matrix,-1).*triu(zero_mask,1)' > 0)');
    neg_compare = isequal((triu(at_matrix,1).*tril(zero_mask,-1)') < 0, ...
        (tril(at_matrix,-1).*triu(zero_mask,1)' < 0)');
    assert(mode == 0 || mode == 1 || (pos_compare && neg_compare));
    at_matrix = (at_matrix .* (ones(matrix_size) - eye(matrix_size)) ...
        + (eye(matrix_size).*-d));
end

