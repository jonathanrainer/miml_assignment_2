function eigenvalues = generate_eigenvalues(iterations, matrix_size, ...
    interaction_prob, d, mode)
%GENERATE_EIGENVALUES Summary of this function goes here
%   Detailed explanation goes here
    eigenvalues = zeros(matrix_size, iterations);
    for i=1:iterations
        M = generate_at_matrix(matrix_size, interaction_prob, d, mode);
        eigenvalues(:,i) = eig(M);
    end
end

