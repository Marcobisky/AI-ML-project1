%% Usage: Perform single-point crossover on the selected population
% idxPop_s -> Selected population for crossover (matrix of individuals)
% crossrate -> Probability of crossover (0 <= crossrate <= 1)
% idxPop_c -> Offspring population after crossover (matrix of individuals)

function idxPop_c = crossover(idxPop_s, crossrate)
    % Initialize offspring population (same size as selected population)
    popSize = size(idxPop_s, 1);
    geneNum = size(idxPop_s, 2);
    idxPop_c = idxPop_s;  % Start by copying the population

    % Shuffle the population to pair individuals randomly
    shuffledIndices = randperm(popSize);
    
    % Perform crossover in pairs
    for i = 1:2:popSize-1
        % Get pairs of parents
        parent1 = idxPop_s(shuffledIndices(i), :);
        parent2 = idxPop_s(shuffledIndices(i + 1), :);
        
        % Apply crossover with probability `crossrate`
        if rand < crossrate
            % Randomly select a single crossover point
            crossoverPoint = randi([1, geneNum - 1]);
            
            % Create offspring by swapping genes at the crossover point
            offspring1 = [parent1(1:crossoverPoint), parent2(crossoverPoint + 1:end)];
            offspring2 = [parent2(1:crossoverPoint), parent1(crossoverPoint + 1:end)];
            
            % Add offspring to offspring population
            idxPop_c(shuffledIndices(i), :) = offspring1;
            idxPop_c(shuffledIndices(i + 1), :) = offspring2;
        end
    end
end