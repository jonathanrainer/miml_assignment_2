function eigenvalues = generate_eigenvalues_augmented(iterations, ...
    matrix_size, interaction_prob, d, mode, sigma)
%GENERATE_EIGENVALUES_AUGMENTED Summary of this function goes here
%   Detailed explanation goes here
    eigenvalues = zeros(matrix_size, iterations);
    for i=1:iterations
        M = generate_at_matrix(matrix_size, interaction_prob, d, mode, sigma);
        scalars = repmat((2*(rand(matrix_size, 1))), 1, matrix_size);
        M_t = scalars.*M;
        eigenvalues(:,i) = eig(M_t);
    end
end

