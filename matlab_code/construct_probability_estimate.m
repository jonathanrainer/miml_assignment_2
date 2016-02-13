function [outcomes, fails]  = construct_probability_estimate(iterations, ...
    zero_threshold, timespan)
%CONSTRUCT_PROBABILITY_ESTIMATE Estimate the probability of extinction
    
    % Set up the structure to track the outcomes, successes (extinction)
    % and failures (survivial) in columns 1 and 2 respectively.
    outcomes = zeros(1,2);
    % Set up a structure to track the conditions that led to failure so
    % they can be adequately explored.
    fails = zeros(iterations, 9);
    for i=1:iterations
       % Set the parameters for each of the ranges as defined in the paper.
       alpha_A = rand_range(-0.3, -0.1, 1);
       alpha_P = rand_range(-0.2, -0.001, 1);
       beta = rand_range(1, 2, 1);
       % Flip a coin to decide if the mutualistic interaction is weak or
       % strong.
       if rand() >= 0.5
           gamma = rand_range(0.2, 0.3, 1);
       else
           gamma = rand_range(2, 3, 1);
       end
       h = rand_range(0.1,1, 1);
       % For the chosen random set of parameters iterate 10 times to see
       % where ode45 converges to.
       for j = 1:10
           [~,y] = ode45(@(t,y) tfderivs(t, y, 1, alpha_A, alpha_P, beta, ... 
               gamma, h), 1:timespan, rand(1,2));
           % Since we know that there must be a fixed point at (0,0) from
           % the analytical analysis we simply need to check if the system
           % is converging to it every time, so we check that the outcome
           % at the end of the timespan is close enough to zero to be
           % considered converging and then we add to our successes.
           if (y(timespan,:) <= zero_threshold)
               outcomes(1) = outcomes(1) + 1;
           % Otherwise we add to the failures and then store out the
           % details that led us to that conclusion.
           else
               outcomes(2) = outcomes(2) + 1;
               fails(i, :) = [alpha_A, alpha_P, beta, gamma, h, ...
                   y(timespan, :), y(timespan-100, :)];
           end
       end
    end
    % Eliminate any 0 rows in the failures because we've allocated enough
    % space to assume that every experiment will fail so we won't run out
    % of space.
    fails( ~any(fails,2), : ) = [];
end

