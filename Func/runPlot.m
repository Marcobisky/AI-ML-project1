%% Usage: Plot the the best, worst, and average optimal objective function values and their standard deviations over 10 runs
% bestLoss -> The best loss matrix of each generation in each run
% runNum -> The number of runs
% plotHandle -> The handle of the plot
% bestBest, worstBest -> {value, [generation, run]} of the best and worst value, {2} is for finding the specific register configuration
% avgBest, stdDev -> The average and standard deviation of the best value

function [plotHandle, bestBest, worstBest, avgBest, stdDev] = runPlot(bestLoss, runNum)
    % Calculate the least loss in each run
    bestLossEachRun = min(bestLoss);

    % Look all best values
    bestBest = min(bestLossEachRun);
    % find the index of the best value
    bestBest_inWhichRun = find(bestLossEachRun == bestBest, 1);
    bestBest_gen = find(bestLoss(:, bestBest_inWhichRun) == bestBest, 1);
    bestBest = {bestBest, [bestBest_gen, bestBest_inWhichRun]};

    % In the same logic:
    worstBest = max(bestLossEachRun);
    worstBest_inWhichRun = find(bestLossEachRun == worstBest, 1);
    worstBest_gen = find(bestLoss(:, worstBest_inWhichRun) == worstBest, 1);
    worstBest = {worstBest, [worstBest_gen, worstBest_inWhichRun]};

    % No need to find the index of the average value
    avgBest = mean(bestLossEachRun);

    % Calculate the standard deviation, just a number
    stdDev = std(bestLossEachRun);

    % Plot
    figure;
    plotHandle = plot(1:runNum, bestLossEachRun, 'k*-', 'LineWidth', 2);
    title('Optimal Loss in each run');
    xlabel('Run');
    ylabel('Optimal Loss');
    grid on;
end