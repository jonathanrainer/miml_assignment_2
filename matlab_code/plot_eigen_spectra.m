function [] = plot_eigen_spectra(eigenvalues, colour)
%PLOT_EIGEN_SPECTRA Given a vector of eigenvales, plot their spectra.

    hold on
    % Calculate the size of the plot which seems to scale with the square
    % of the size of the matrix the eigenvalues came from, with an
    % additional factor so it doesn't look squashed on the page.
    plot_size = round(sqrt(size(eigenvalues,1))) + 4;
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
    axis([-plot_size plot_size -plot_size plot_size])
    grid
    axis equal
    % Add in markers to the scales so it's obvious how large or small the
    % generate spectra are
    set(gca,'xtick',-plot_size:10:plot_size, ...
        'ytick',-plot_size:10:plot_size);
    % Label the real and imaginary axis.
    xlabel('Re');
    ylabel('Im');
    % Plot axis lines
    hold on
    plot([0 0],[-plot_size plot_size],'k');
    plot([-plot_size plot_size],[0 0],'k');
    hold off
end

