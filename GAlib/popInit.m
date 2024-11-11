%% Usage: Generate initial population
% popNum -> Number of individuals in the population
% lb -> Lower bounds for each gene
% ub -> Upper bounds for each gene
% pop -> Initial population matrix, each row is an individual, the number of columns is the number of population

function pop = popInit(popNum, lb, ub)
    % check same length
    geneNum = length(lb);
    if geneNum ~= length(ub)
        error('Lower and upper bounds must be the same length');
    end
    % Initialize Population
    pop = zeros(popNum, geneNum);
    for i = 1:geneNum
        pop(:, i) = randi([lb(i), ub(i)], popNum, 1);
    end
end