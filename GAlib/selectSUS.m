%% Usage: Select individuals from the population using Stochastic Universal Sampling (SUS)
% pop -> Population matrix, each row is an individual
% fitness -> Fitness col vector for each individual in the population (lower is better)
% elitismRate -> Proportion of the population to keep as elites (0 <= elitismRate <= 1)
% elitePop -> Elite population matrix, each row is an elite individual
% susPop -> Selected population matrix, each row is a selected individual

function [elitePop, susPop] = selectSUS(idxPop, popLoss, elitismRate)
    % Number of individuals in the population
    popNum = size(idxPop, 1);

    % Step 1: Rank-based Fitness Assignment
    fitness = loss2Fit(popLoss);  % Convert popLoss values to rank-based fitness

    % Step 2: Elitism - Retain the top elite individuals
    eliteNum = max(1, round(popNum * elitismRate));
    [~, sortedIndices] = sort(fitness, 'descend'); % Sort fitness in descending order
    elitePop = idxPop(sortedIndices(1:eliteNum), :);   % Select the top eliteNum individuals

    % Step 3: Stochastic Universal Sampling (SUS) for the rest of the population
    % Calculate the number of individuals to select using SUS
    numToSelect = popNum - eliteNum;

    % Calculate selection probability and cumulative probability distribution
    fitnessSum = sum(fitness);
    selectionProb = fitness / fitnessSum;
    cumulativeProb = cumsum(selectionProb);

    % Generate equally spaced pointers starting from a random position
    startPointer = rand() * (1 / numToSelect);
    pointers = startPointer + (0:numToSelect-1) * (1 / numToSelect);

    % Perform SUS selection based on pointers
    selectedIndices = zeros(numToSelect, 1);
    for i = 1:numToSelect
        % Find the first individual whose cumulative probability exceeds the pointer
        selectedIndex = find(cumulativeProb >= pointers(i), 1, 'first');
        selectedIndices(i) = selectedIndex;
    end
    
    % Selected population based on SUS
    susPop = idxPop(selectedIndices, :);
end