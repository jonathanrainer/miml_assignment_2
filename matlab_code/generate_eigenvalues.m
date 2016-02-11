function eigenvalues = generate_eigenvalues(iterations, matrix_size, ...
    interaction_prob, d, mode, sigma)
%GENERATE_EIGENVALUES Generate sets of eigenvalues to be plotted.
    
    % Create a structure to hold the eigenvalues generated.
    eigenvalues = zeros(matrix_size, iterations);
    % Generate one matrix per iteration and extract it's eigenvalues into
    % one column of the matrix defined.
    for i=1:iterations
        M = generate_at_matrix(matrix_size, interaction_prob, d, mode, ...
            sigma);
        eigenvalues(:,i) = eig(M);
    end
end

