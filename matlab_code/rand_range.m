function range = rand_range(min, max, number)
%RAND_RANGE Create a list of random variables between 2 fixed numbers.
    range = (max - min).* rand(number,1) + min;
end

