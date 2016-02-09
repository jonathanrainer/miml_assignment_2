function [] = random_matrices_spectra(size, probability, plot_size)
    M = randn(size, size);
    M = random_replacement(M, probability);
    diagonal = diag(-1);
    eigenvalues = eig(M);
    % Plot Imag vs Real
    plot(eigenvalues,'or')
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

function M = random_replacement(M, probability)
    while (nnz(M)/(numel(M)-size(M,1))) > probability
        replacement_found = false;
        while ~replacement_found
            index_to_replace = randi(numel(M));
            index = index_converter(index_to_replace, size(M,1));
            if M(index_to_replace) == 0 || index(1) == index(2)
                continue
            else
                M(index_to_replace) = 0;
                replacement_found = true;
            end
        end
    end
end

function index = index_converter(index, mat_size)
    j = mod(index, mat_size);
    i = (index -j)/mat_size;
    index=[i,j];
end