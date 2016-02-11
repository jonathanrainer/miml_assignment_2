function [] = plot_stability_graph(S, C, start_sigma, d, mode, ... 
crit_stability, iterations, graph_points)
%PLOT_STABILITY_GRAPH Summary of this function goes here
%   Detailed explanation goes here
    stable = 0;
    results_sigma = zeros(graph_points,2);
    stability_meas = linspace(0.5*crit_stability, ...
        1.5*crit_stability, graph_points);
    for i = 1:graph_points
        sigma_val = stability_meas(i)/sqrt(S*C);
        for j = 1:iterations
            M = generate_at_matrix(S, C, d, mode, sigma_val);
            if(real(eig(M)) < 0)
                stable = stable + 1;
            end
        end
        results_sigma(i,:) = [sigma_val * sqrt(S*C), stable/iterations];
        stable = 0;
    end
    stable = 0;
    results_C = zeros(graph_points,2);
    for i = 1:graph_points
        C_val = (stability_meas(i)^2)/(start_sigma^2 * S);
        for j = 1:iterations
            M = generate_at_matrix(S, C_val, d, mode, start_sigma);
                if(real(eig(M)) < 0)
                    stable = stable + 1;
                end
        end
        results_C(i,:) = [start_sigma * sqrt(S*C_val), stable/iterations];
        stable = 0;
    end
    hold on 
    plot(results_sigma(:,1), results_sigma(:,2), 'r-x');
    plot(results_C(:,1), results_C(:,2), 'b-+');
    hold off
end

