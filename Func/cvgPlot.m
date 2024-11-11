%% Usage: calculate the colomn vector of the best-so-far loss for each runs, then take average
% bestLoss -> The best (not so-far) loss matrix of each generation in each run
% genNum -> The number of generations
% plotHandle -> The handle of the convergence plot

function plotHandle = cvgPlot(bestLoss, genNum)
    % Calculate the best-so-far loss for each run
    bestLoss_SoFar = cummin(bestLoss);
    bestLoss_Sofar_avg = mean(bestLoss_SoFar, 2);

    % Plot
    figure;
    plotHandle = plot(1:genNum, bestLoss_Sofar_avg, 'r', 'LineWidth', 2);
    title('Convergence Plot');
    xlabel('Generation');
    ylabel('Average Best-so-far Loss');
    grid on;
end