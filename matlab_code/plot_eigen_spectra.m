function [] = plot_eigen_spectra(eigenvalues, colour)
%PLOT_EIGEN_SPECTRA Given a vector of eigenvales, plot their spectra.

    hold on
    % Calculate the size of the plot which seems to scale with the square
    % of the size of the matrix the eigenvalues came from, with an
    % additional factor so it doesn't look squashed on the page.
    x_min = round(min(min(real(eigenvalues)))*1.2,2);
    x_max = round(max(max(real(eigenvalues)))*1.2,2);
    y_min = round(min(min(imag(eigenvalues)))*1.2,2);
    y_max = round(max(max(imag(eigenvalues)))*1.2,2);
    % Iterate over the eigenvalues
    for i=1:size(eigenvalues,2)
        % If the colour specifier is set then plot everything in one
        % colour, otherwise choose one randomly per set of eigenvalues.
        % This allows us to see how sets of eigenvalues fall or two
        % independent sets look, depednent on context.
        if ~strcmp('random', colour)
            plot(eigenvalues(:,i),'o', 'color', colour)
        else
            plot(eigenvalues(:,i),'o', 'color', rand(1,3))
        end
    end
    hold off
    % Alter the axis so the whole diagram can be seen, add a grid and make
    % sure the axis are equally spaced in the digram.
    axis([x_min x_max y_min y_max])
    grid
    axis equal
    % Add in markers to the scales so it's obvious how large or small the
    % generate spectra are
    if (abs(x_min) + abs(x_max) > 30)
        step_size_x = 10;
    else
        step_size_x = 5;
    end
    if (abs(y_min) + abs(y_max) > 10)
        step_size_y = 5;
    else
        step_size_y = 3;
    end
    set(gca,'xtick',x_min:step_size_x:x_max, ...
        'ytick',y_min:step_size_y:y_max);
    % Label the real and imaginary axis.
    xlabel('Re');
    ylabel('Im');
    % Plot axis lines
    hold on
    plot([0 0],[y_min y_max],'k');
    plot([x_min x_max],[0 0],'k');
    hold off
end

