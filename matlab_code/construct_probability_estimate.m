function [outcomes, fails]  = construct_probability_estimate(iterations, ...
    zero_threshold, timespan)
%CONSTRUCT_PROBABILITY_ESTIMATE Summary of this function goes here
%   Detailed explanation goes here
    outcomes = zeros(1,2);
    fails = zeros(iterations, 9);
    for i=1:iterations
       alpha_A = rand_range(-0.3, -0.1, 1);
       alpha_P = rand_range(-0.2, -0.001, 1);
       beta = rand_range(1, 2, 1);
       if rand() >= 0.5
           gamma = rand_range(0.2, 0.3, 1);
       else
           gamma = rand_range(2, 3, 1);
       end
       h = rand_range(0.1,1, 1);
       for j = 1:10
           [~,y] = ode45(@(t,y) tfderivs(t, y, 1, alpha_A, alpha_P, beta, ... 
               gamma, h), 1:timespan, rand(1,2));
           if (y(timespan,:) <= zero_threshold)
               outcomes(1) = outcomes(1) + 1;
           else
               outcomes(2) = outcomes(2) + 1;
               fails(i, :) = [alpha_A, alpha_P, beta, gamma, h, ...
                   y(timespan, :), y(timespan-100, :)];
           end
       end
    end
    fails( ~any(fails,2), : ) = [];
end

