%% Usage: 
% idxPop_c -> Population crossed over for mutation (matrix of individuals)
% mutateRate -> Probability of mutating each gene (0 <= mutateRate <= 1)
% lb, ub -> Lower and upper bounds for each gene (row vector)
% idxPop_m -> Mutated population (matrix of individuals)

function idxPop_m = mutateAlt(idxPop_c, mutateRate, lb, ub)
    % Get the size of the population and number of genes
    [popSize, geneNum] = size(idxPop_c);
    
    % Initialize mutated population by copying the selected population
    idxPop_m = idxPop_c;

    % Iterate through each individual and each gene
    for i = 1:popSize
        for j = 1:geneNum
            % Apply mutation with probability `mutateRate`
            if rand < mutateRate
                % Randomly decide to increase or decrease the gene
                mutationDirection = randi([0, 1]) * 2 - 1; % +1 or -1
                mutationAmount = round(rand * 0.01 * (ub(j) - lb(j))); % Mutate within 20% of the range

                % Mutate the gene while keeping it within bounds
                newGeneValue = idxPop_m(i, j) + mutationDirection * mutationAmount;
                idxPop_m(i, j) = max(min(newGeneValue, ub(j)), lb(j));
            end
        end
    end
end

%% Alternative implementation
% function idxPop_m = mutateAlt(idxPop_s, mutateRate, lb, ub)
%     % Inputs:
%     % idxPop_s -> Population selected for mutation (matrix of individuals)
%     % mutateRate -> Probability of mutating each gene (0 <= mutateRate <= 1)
%     % lb -> Lower bounds for each gene (row vector)
%     % ub -> Upper bounds for each gene (row vector)

%     [popSize, geneNum] = size(idxPop_s);
%     idxPop_m = idxPop_s;

%     % Iterate through each individual and each gene
%     for i = 1:popSize
%         for j = 1:geneNum
%             if rand < mutateRate
%                 % Randomly select a new value for the gene within its bounds
%                 idxPop_m(i, j) = randi([lb(j), ub(j)]);
%             end
%         end
%     end
% end