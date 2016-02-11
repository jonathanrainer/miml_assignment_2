clf
% Need to change the third one, it's just an estimate for now.
critical_stabilities = [1, pi/(pi-2), pi/(pi+2)]; 
initial_sigma = [0.1, 0.5, 0.1];
for i=1:3
    subplot(2,3,i)
    plot_eigen_spectra(generate_eigenvalues(10,250, 0.25, 1,i-1,1));
    subplot(2,3,i+3)
    plot_stability_graph(250, 0.5, initial_sigma(i), 1, i-1, ...
        critical_stabilities(i), 20, 25);
end