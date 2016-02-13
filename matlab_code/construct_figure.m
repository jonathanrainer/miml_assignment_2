% Create a new figure and set up its position and size so the plots are the
% right shape.
f = figure(1);
set(f, 'Position', [100, 100, 1200, 400])
% Store some parameters so it's easier to run the commands to subplot in a
% loop.
critical_stabilities = [1, pi/(pi-2), pi/(pi+2)]; 
initial_sigma = [0.1, 0.5, 0.1];
titles = {'Random', 'Predator/Prey', 'Mixture'};
% Set up the aspect ratio on the plots so that circles look like circles
% rather than stretched ellipses.
daspect([1,1,1]);
% Iterate over the modes to generate, generate the eigenvalues and plot the
% spectra, each in their own pane of the subplot.
for i=1:3
    subplot(1,3,i)
    hold on
    plot_eigen_spectra(generate_eigenvalues(10,250, 0.25, 1,i-1,1), ...
        'random');
    % Add in a line to indicate the centre of the shapes.
    vline(-1)
    % Add titles to each of the subfigures.
    title(titles{i});
    hold off
end