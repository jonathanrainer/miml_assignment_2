function [] = plot_eigen_spectra(eigenvalues)
%PLOT_EIGEN_SPECTRA Summary of this function goes here
%   Detailed explanation goes here
    clf
    hold on
    for i=1:size(eigenvalues,2)
        plot_size = round(sqrt(size(eigenvalues,1))) + 4;
        % Plot Imag vs Real
        plot(eigenvalues(:,i),'o', 'color', rand(1,3))
    end
    hold off
    axis([-plot_size plot_size -plot_size plot_size])
    grid
    set(gca,'xtick',-plot_size:1:plot_size, ...
        'ytick',-plot_size:1:plot_size);
    xlabel('Re');
    ylabel('Im');
    % Plot origin lines
    hold on
    plot([0 0],[-plot_size plot_size],'k');
    plot([-plot_size plot_size],[0 0],'k');
    hold off
end

