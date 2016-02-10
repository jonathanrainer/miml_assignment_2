function [] = plot_eigen_spectra(M, colour_matrix)
%PLOT_EIGEN_SPECTRA Summary of this function goes here
%   Detailed explanation goes here
    eigenvalues = eig(M);
    % Plot Imag vs Real
    plot(eigenvalues,'o', 'color', colour_matrix)
    axis([-plot_size plot_size -plot_size plot_size])
    grid
    set(gca,'xtick',-plot_size:plot_size,'ytick',-plot_size:plot_size);
    xlabel('Re');
    ylabel('Im');
    % Plot origin lines
    hold on
    plot([0 0],[-plot_size plot_size],'k');
    plot([-plot_size plot_size],[0 0],'k');
    hold off
end

