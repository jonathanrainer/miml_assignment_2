function out_matrix = matrix_replacement(input_matrix, probability, mode)
%MATRIX_REPLACEMENT This function takes in a matrix and then sets to zero a
%paticular proportion of its entries, based on the input probability.
%Specifically the input probability is the probabilty of choosing a
%non-zero entry from this matrix, excluding the diagonal entries. So a
%probability of 0.9 would mean that 10% of the entries in the matrix are 0.

    % Calculate how many elements need to be replaced, rounding an integer
    % figure because you can't replace 0.2 of a matrix entry.
    number_to_replace = round((1 - probability)*...
        (numel(input_matrix)- size(input_matrix,2)));
    out_matrix = input_matrix;
    % While there are still entires that need replacing 
    while(number_to_replace > 0)
        % Generate a random set of indexes and see if they are either on
        % the diagonal or if the element there is 0.
        i = randi([1, size(input_matrix,2)]);
        j = randi([1, size(input_matrix,2)]);
        if (i ~= j && out_matrix(i,j) ~= 0)
            switch mode
                case 1
                    if (out_matrix(j,i) ~= 0)
                        out_matrix(j,i) = 0;
                        number_to_replace = number_to_replace-1;
                    end
            end
            out_matrix(i,j) = 0;
            number_to_replace = number_to_replace-1;
        end
    end
end

