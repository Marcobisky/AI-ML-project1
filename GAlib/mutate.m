%% Usage: 
% idxPop_c -> Population crossed over for mutation (matrix of individuals)
% mutateRate -> Probability of mutating each gene (0 <= mutateRate <= 1)
% lb, ub -> Lower and upper bounds for each gene (row vector)
% idxPop_m -> Mutated population (matrix of individuals)

function idxPop_m = mutate(idxPop_c, mutateRate, lb, ub)
    % Get the population size (popNum) and number of genes (6)
    [popSize, geneNum] = size(idxPop_c);
    
    % Initialize mutated population by copying the crossover population
    idxPop_m = idxPop_c;

    % Set the shrink factor (similar to MutShrink in mutbga)
    MutShrink = 1;

    % Calculate the range for each gene, considering bounds and shrink factor
    Range = 0.5 * MutShrink * (ub - lb);  % 1x6 vector for each gene's range
    Range = repmat(Range, popSize, 1);    % Extend to popSize x geneNum

    % Mutation mask to decide which genes to mutate based on mutateRate
    MutMask = rand(popSize, geneNum) < mutateRate;

    % Randomly decide mutation direction (+1 or -1) for each gene
    Direction = (rand(popSize, geneNum) < 0.5) * 2 - 1;

    % Calculate Delta using exponential decay with accuracy
    ACCUR = 20;
    Vect = 2 .^ (-(0:(ACCUR-1))');                   % Column vector for decay factors
    DeltaValues = rand(popSize, ACCUR) < 1/ACCUR;    % Random matrix for Delta calculation
    Delta = DeltaValues * Vect;                      % Size [popSize, 1] - decay per individual
    Delta = repmat(Delta, 1, geneNum);               % Extend Delta to match [popSize, geneNum]

    % Apply mutation to each gene based on the mask, direction, and Delta
    idxPop_m = idxPop_m + MutMask .* Direction .* Range .* Delta;

    % Round values to ensure integers and enforce bounds
    idxPop_m = round(idxPop_m);
    idxPop_m = max(repmat(lb, popSize, 1), idxPop_m);
    idxPop_m = min(repmat(ub, popSize, 1), idxPop_m);
end