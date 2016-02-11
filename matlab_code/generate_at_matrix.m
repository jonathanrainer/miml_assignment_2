function at_matrix = generate_at_matrix(matrix_size, c, d, mode, sigma)
%GENERATE_AT_MATRIX This function should generate random matrices that
%correspond to the conditions laid down in Allesian & Tang
%
%Params:
%   mode - This is a flag to indicate which type of A-T Matrix should be
%   generated. The flag settings are:
%       0 = None 
%       1 = Predator/Prey
%       2 = Mixture of Competition and Mutualism
%       3 = Mutualism
%

    uniform_rands = rand(matrix_size, matrix_size);
    switch mode
        case 0
            creation_mask = (uniform_rands <= c) .* ~eye(matrix_size);
            at_matrix = normrnd(0,sigma,matrix_size,matrix_size)  ... 
                .* creation_mask;
            at_matrix = at_matrix + (eye(matrix_size) .* -d);
        case 1
            creation_mask = triu(uniform_rands <= c, 1);
            zero_mask = creation_mask == 0;
            uniform_rands_2 = rand(matrix_size, matrix_size);
            pos_mask = (uniform_rands_2 .* creation_mask) >= 0.5;
            neg_mask = (uniform_rands_2 .* creation_mask) < 0.5 - zero_mask;
            pos_random_numbers = abs(normrnd(0,sigma,matrix_size,matrix_size));
            neg_random_numbers = -abs(normrnd(0,sigma,matrix_size,matrix_size));
            at_matrix = (pos_mask .* pos_random_numbers) + ...
                (pos_mask' .* neg_random_numbers) + ... 
                (neg_mask .* neg_random_numbers) + ...
                (neg_mask' .* pos_random_numbers);
            at_matrix = at_matrix + -d * eye(matrix_size);
        case 2
            creation_mask = triu(uniform_rands <= c, 1);
            zero_mask = creation_mask == 0;
            uniform_rands_2 = rand(matrix_size, matrix_size);
            pos_mask = (uniform_rands_2 .* creation_mask) <= 0.5 - zero_mask;
            neg_mask = (uniform_rands_2 .* creation_mask) > 0.5;
            pos_random_numbers = abs(normrnd(0,sigma,matrix_size,matrix_size));
            neg_random_numbers = -abs(normrnd(0,sigma,matrix_size,matrix_size));
            at_matrix = ((pos_mask + pos_mask') .* pos_random_numbers) + ... 
                ((neg_mask + neg_mask') .* neg_random_numbers);
            at_matrix = at_matrix + -d * eye(matrix_size);
        case 3
            creation_mask = triu(uniform_rands <=c, 1);
            norm_rnds = abs(normrnd(0,sigma,matrix_size,matrix_size));
            at_matrix = (creation_mask .* norm_rnds) + ... 
                (-d .* eye(matrix_size)) + (creation_mask' .* norm_rnds);
    end
end

