function at_matrix = generate_at_matrix(matrix_size, c, d, mode, sigma)
%GENERATE_AT_MATRIX Generate Allesina and Tang matrices of various types.

    % Generate a set of random numbers from the distribution U[0,1] as a
    % matrix rather than having to generate them all individually.
    uniform_rands = rand(matrix_size, matrix_size);
    % Switch based on the mode that the function has been called in, these
    % are listed as comments above each switch case.
    switch mode
        % mode = 0 -> Random Matrices
        case 0
            % Form a mask that consists of the positions where the random
            % numbers generated are less than or equal to C, the
            % connectance property. Then take out the diagonal elements so
            % they can be added in later
            creation_mask = (uniform_rands <= c) .* ~eye(matrix_size);
            % Using the mask created pull out random numbers from the
            % distribution N(o,sigma^2) to form the matrix.
            at_matrix = normrnd(0,sigma,matrix_size,matrix_size)  ... 
                .* creation_mask;
        % mode = 1 -> Predator/Prey Matrices
        case 1
            % Form the creation mask from the upper half of the
            % uniform_rands matrix, where the entries are less than or
            % equal to C.
            creation_mask = triu(uniform_rands <= c, 1);
            % Form a mask to show the location of zeroes so that we don't
            % pick up false positives later.
            zero_mask = creation_mask == 0;
            % Generate a second set of random numbers
            uniform_rands_2 = rand(matrix_size, matrix_size);
            % Create two masks, one that shows the generated random numbers
            % greater than 0.5 and the other that shows the ones that are
            % lower, taking out those numbers below the central diagonal
            % that should be zero anyway.
            pos_mask = (uniform_rands_2 .* creation_mask) >= 0.5;
            neg_mask = ((uniform_rands_2 .* creation_mask) < 0.5) ...
                - zero_mask;
            % Turn these masks into upper triangular random matrices with
            % numbers draw from the correct distributions.
            pos_random_numbers =  ...
                abs(normrnd(0,sigma,matrix_size,matrix_size));
            neg_random_numbers = ...
                -abs(normrnd(0,sigma,matrix_size,matrix_size));
            % Glue together the matrix by matching entries in a mask with
            % their corresponding generated random numbers as well as
            % matching their transposes with the opposite generated random
            % numbers to produce the +/-, -/+ pairs that are required.
            at_matrix = ((pos_mask + neg_mask') .* pos_random_numbers) + ...
                ((pos_mask' + neg_mask) .* neg_random_numbers);
        % mode = 2 -> Mixture Case 
        case 2
            % Similar process to case 1
            creation_mask = triu(uniform_rands <= c, 1);
            zero_mask = creation_mask == 0;
            uniform_rands_2 = rand(matrix_size, matrix_size);
            pos_mask = ...
                (uniform_rands_2 .* creation_mask) <= 0.5 - zero_mask;
            neg_mask = ...
                (uniform_rands_2 .* creation_mask) > 0.5;
            pos_random_numbers = ...
                abs(normrnd(0,sigma,matrix_size,matrix_size));
            neg_random_numbers = ...
                -abs(normrnd(0,sigma,matrix_size,matrix_size));
            % Difference here is that instead of matching to create
            % complementary sign pairs we create pairs of the same sign. So
            % we get +/+ and -/- pairs 
            at_matrix = ((pos_mask + pos_mask') .* pos_random_numbers) ... 
                 + ((neg_mask + neg_mask') .* neg_random_numbers);
        % mode = 3 -> Mutualism
        case 3
            % Create a creation mask formed from the upper triangular part
            % of the uniform_rands matrix, where the entries are less then
            % or equal to C. 
            creation_mask = triu(uniform_rands <=c, 1);
            % Generate the random numbers to combine with the creation
            % mask.
            norm_rnds = abs(normrnd(0,sigma,matrix_size,matrix_size));
            % Multiply the mask and it's transpose by the normally
            % distributed random numbers to produce the +/+ pairs required
            % in the matrix.
            at_matrix = ((creation_mask + creation_mask') .* norm_rnds);
    end
    % Set all the diagonals to -d within the matrix.
    at_matrix = at_matrix + (eye(matrix_size) .* -d);
end

