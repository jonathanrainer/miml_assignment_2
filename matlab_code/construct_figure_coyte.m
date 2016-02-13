% Create a new figure and set up its position and size so the plots are the
% right shape.
f = figure(1);
set(f, 'Position', [100, 100, 1200, 400])
% Store some parameters so it's easier to run the commands to subplot in a
% loop.
critical_stabilities = [1, pi/(pi-2), pi/(pi+2)]; 
initial_sigma = [0.1, 0.5, 0.1];
titles = {'Cooperation - Original Form', 'Competition - Original Form', ...
    'Cooperation - With Variation', 'Competition - With Variation'};
modes = [3, 4];
% Iterate over the modes to generate, generate the eigenvalues and plot the
% spectra, each in their own pane of the subplot.
daspect([1,1,1]);
for i=1:2
    subplot(2,2,i)
    hold on
    plot_eigen_spectra(generate_eigenvalues(10,250, 0.25, 1,modes(i),1), ...
        'random');
    % Add titles to each of the subfigures.
    title(titles{i});
    hold off
    % Change to the subplot below to plot the augmented version
    subplot(2,2,i+2)
    hold on
    plot_eigen_spectra(generate_eigenvalues_diagvar(10,250, 0.25, 1, ...
        modes(i),1), 'random');
    % Add in a second title.
    title(titles{i+2});
    hold off
end