function [eigenvalues, eigenvalues_a] = generate_eigenvalues_augmented(...
    iterations, matrix_size, interaction_prob, d, mode, sigma)
%GENERATE_EIGENVALUES_AUGMENTED Generates the augmented eigenvalues.

    % Create structures to store the eigenvalues in when generated
    eigenvalues = zeros(matrix_size, iterations);
    eigenvalues_a = zeros(matrix_size, iterations);
    for i=1:iterations
        % Generate one matrix per iteration of the required form.
        M = generate_at_matrix(matrix_size, interaction_prob, d, mode, ...
            sigma);
        % Generate a matrix for which each row is made up of repititions of
        % the same random number (drawn from the U[0,2]
        scalars = repmat((2*(rand(matrix_size, 1))), 1, matrix_size);
        % Multiply the scalars by the generated matrix, effectively the
        % same multiplying each row by a random scalar.
        M_t = scalars.*M;
        % Extract the original and augmented sets of eigenvalues.
        eigenvalues(:,i) = eig(M);
        eigenvalues_a(:,i) = eig(M_t);
    end
end

