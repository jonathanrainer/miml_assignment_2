function at_matrix = at_transform(input_matrix, mode)
%AT_TRANSFORM This function takes in a random matrix and then augments it,
%based on the passed in mode flag, so that it meets the specification laid
%down in Allesina and Tang.
    switch mode 
        case 0
            % Do nothing as there is no transformation
            at_matrix = input_matrix;
        case 1
            % Extract the positive elements in the upper diagonal elements
            % A_(ij) where j > i and then create a mask that indicates the
            % location of positive elements in the upper diagonal.
            upper_portion_pos = triu(input_matrix, 1) > 0;
            % Transpose the mask so we know what elements of the lower
            % diagonal need inverting and then extract the elements that
            % are already negative in the lower diagonal so that you don't
            % change elements that don't need to be changed. This also will
            % show up (as -1's) any elements that are negative in the upper
            % diagonal and negative in the lower so they can be inverted
            % too
            replacement_mask = upper_portion_pos' - ...
                (tril(input_matrix, -1) < 0);
            % Take all elements of the mask that are positive and turn them
            % into -1 such that they will invert the correct elements.
            replacement_mask(replacement_mask == 1) = -1;
            % Take the other elements to 1 such that all the other elements
            % are maintained.
            replacement_mask(replacement_mask == 0) = 1;
            % Invert the selected elements
            at_matrix = input_matrix .* replacement_mask;
        case 2
            upper_sign_mask = (triu(input_matrix, 1) > 0) - ... 
                (triu(input_matrix, 1) < 0);
            lower_sign_mask = (tril(input_matrix, -1) > 0) - ... 
                (tril(input_matrix, -1) < 0);
            sign_mask = (upper_sign_mask' - lower_sign_mask)/2;
            sign_mask(sign_mask == 1) = -1;
            sign_mask(sign_mask == 0) = 1;
            at_matrix = sign_mask .* input_matrix;
    end

