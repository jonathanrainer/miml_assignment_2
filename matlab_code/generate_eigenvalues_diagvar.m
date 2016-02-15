function eigenvalues = generate_eigenvalues_diagvar(iterations, ...
    matrix_size, interaction_prob, d, mode, sigma)
%GENERATE_EIGENVALUES Generate sets of eigenvalues to be plotted.
    
    % Create a structure to hold the eigenvalues generated.
    eigenvalues = zeros(matrix_size, iterations);
    % Generate one matrix per iteration and extract it's eigenvalues into
    % one column of the matrix defined.
    for i=1:iterations
        M = generate_at_matrix(matrix_size, interaction_prob, d, mode, ...
            sigma);
        % Create a vector to hold all the elements that are non diagonal
        elements = zeros((matrix_size^2 - matrix_size), 1);
        % Iterate over the elements of the matrix and if a non-diagonal
        % element is found store it in elements.
        for j=1:matrix_size
            for k=1:matrix_size
                if(j ~= k)
                    elements((j-1)*matrix_size + (k-1)) = M(j,k);
                end
            end
        end
        % Calculate the variance of the non-diagonal elements
        var_offd = var(elements);
        % Generate the augmented matrix by masking out all the non-diagonal
        % elements and then adding to them the identity matrix times a
        % randomly generated matrix to give the diagonal coefficients. In
        % addition you add a small amount to the diagonals so their sum is
        % zero in line with the James paper.
        amount_to_add = (-sum(var_offd))/matrix_size;
        M_aug = (~eye(matrix_size) .* M) + (normrnd(0,sqrt(var_offd), ...
            matrix_size, matrix_size) .* eye(matrix_size)) + ...
            + (eye(matrix_size) .* amount_to_add);
        eigenvalues(:,i) = eig(M_aug);
    end
end

