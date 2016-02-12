function [] = phase_portrait_trajectories(deriv_func, ...
    x_range, y_range, num_points, x_vals, y_vals, time_span)
%PHASE_PORTRAIT_TRAJECTORIES A function to create a phase portrait plot and
%to superimpose trajectories on top of it to see how the dynamics develops
%over time.
    hold on
    % Plot the phase portrait in its raw form
    phase_portrait(deriv_func, x_range, y_range, num_points);
    % Iterate over both sets of parameter values, allows the parameters to
    % be either vectors or single numbers.
    for i = x_vals
        for j = y_vals
            % Solve the differential equations for the combination of x and
            % y values.
            [~, sols] = ode45(deriv_func,[0,time_span], [i;j]);
            % Plot the trajectory on top of the phase portrait
            plot(sols(:,1),sols(:,2));
            % Add indicators for the start and end of the trajctory
            plot(sols(1,1),sols(1,2),'bo')
            plot(sols(end,1),sols(end,2),'ks')
        end
    end
    % Set the axis so we're not plotting outside of the given range and
    % then take off the hold so that other figures are free to use the
    % drawing space.
    axis([x_range, y_range]);
    hold off
end

