%% Usage: Visualize the evolution process
% Tdata, Vdata -> Temperature samples and expected Voltage Data
% RegPara_picked -> The selected individual in register parameter form

function VtPlotAnime(Tdata, Vdata, RegPara_picked)
    % evaluate the voltage data
    V_matrix = temp2volt(RegPara_picked, Tdata);

    % Create the plot
    figure;
    p = plot(Tdata, Vdata, 'o-', 'LineWidth', 2);
    set(gca, 'YLim', [min(min(V_matrix)) - 0.1, max(max(V_matrix)) + 0.1]);

    for i = 1:size(RegPara_picked, 1)
        % Update the plot
        set(p, 'YData', V_matrix(i, :));
        pause(0.001);
        drawnow;
    end
end