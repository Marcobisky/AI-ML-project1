%% Usage: Linear ranking: Convert popLoss values to rank-based fitness values
% popLoss -> column vector of objective function (loss) values for each individual
% fitness -> column vector of linear fitted values for each individual

function fitness = loss2Fit(popLoss)
    popSize = length(popLoss);
    
    % Rank individuals based on loss (lower loss gets higher rank)
    [~, rankIdx] = sort(popLoss, 'ascend');  % Sort loss in ascending order
    
    % Initialize fitness vector
    fitness = zeros(size(popLoss));
    
    % Assign fitness based on rank (linear scaling)
    % The best individual receives a fitness value of popSize, second best popSize-1, etc.
    for i = 1:popSize
        fitness(rankIdx(i)) = popSize - i + 1;
    end
end