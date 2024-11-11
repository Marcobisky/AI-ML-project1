clear;
addpath('./Func');
addpath('./GAlib');
addpath('./Data');

a = [5, 4, 5; 9, 9, 9; 4, 2, 1; 1, 2, 1]
min(a)



%% Test insertion
% elitePop = [37	56	5	34	4	4; 32	62	4	40	5	6; 12	54	6	32	6	4; 57	58	7	35	2	8; 51	36	19	23	9	2];
% susPop = [24 35 1 3 1 6; 9 1 1 53 8 6];
% insertionMethod = 1;

% eliteNum = size(elitePop, 1);
% popNum = size(susPop, 1);

% % Initialize mixed population by copying susPop
% idxPop_mix = susPop;

% % Perform reinsertion based on the specified method
% if insertionMethod == 1  % Fitness-based reinsertion
%     % Calculate fitness of individuals in susPop for replacement
%     % assuming lower values in susPop are less fit.
%     susPopLoss = sum(susPop, 2);  % Example loss calculation; replace with actual loss if available
%     [~, sortedIndices] = sort(susPopLoss, 'descend');  % Least fit at top

%     % Replace the least-fit individuals in susPop with elite individuals
%     idxPop_mix(sortedIndices(1:eliteNum), :) = elitePop;

% else  % Uniform reinsertion
%     % Select random positions in susPop to replace with elite individuals
%     randomIndices = randperm(popNum, eliteNum);
%     idxPop_mix(randomIndices, :) = elitePop;
% end

% idxPop_mix






%% Test mutate
% idxPop_c = [70, 17, 51, 2, 8, 4];
% mutateRate = 0.8;
% lb = [1 1 1 1 1 1];
% ub = [70 70 70 70 9 9];


% [popSize, geneNum] = size(idxPop_c);
    
% % Initialize mutated population by copying the crossover population
% idxPop_m = idxPop_c;

% % Set the shrink factor (similar to MutShrink in mutbga)
% MutShrink = 1;

% % Calculate the range for each gene, considering bounds and shrink factor
% Range = 0.5 * MutShrink * (ub - lb);  % 1x6 vector for each gene's range
% Range = repmat(Range, popSize, 1);    % Extend to popSize x geneNum

% % Mutation mask to decide which genes to mutate based on mutateRate
% MutMask = rand(popSize, geneNum) < mutateRate;

% % Randomly decide mutation direction (+1 or -1) for each gene
% Direction = (rand(popSize, geneNum) < 0.5) * 2 - 1;

% % Calculate Delta using exponential decay with accuracy
% ACCUR = 20;
% Vect = 2 .^ (-(0:(ACCUR-1))');                   % Column vector for decay factors
% DeltaValues = rand(popSize, ACCUR) < 1/ACCUR;    % Random matrix for Delta calculation
% Delta = DeltaValues * Vect;                      % Size [popSize, 1] - decay per individual
% Delta = repmat(Delta, 1, geneNum);               % Extend Delta to match [popSize, geneNum]

% % Apply mutation to each gene based on the mask, direction, and Delta
% idxPop_m = idxPop_m + MutMask .* Direction .* Range .* Delta;

% % Round values to ensure integers and enforce bounds
% idxPop_m = round(idxPop_m);
% idxPop_m = max(repmat(lb, popSize, 1), idxPop_m);
% idxPop_m = min(repmat(ub, popSize, 1), idxPop_m);

% idxPop_m

%%%%%%%%%%%%%%%%%%%%%
% % test l2squared()
% Tdata = -40:5:85;
% Vdata = 1.026E-1 + -1.125E-4 * Tdata + 1.125E-5 * Tdata.^2;
% load('StandardComponentValues.mat')

% idxPop = [70, 17, 51, 2, 8, 4];
% RegPara = idx2RegPara(idxPop, Res, ThVal, ThBeta);
% loss = l2squared(RegPara, Tdata, Vdata);










% 0 0 1 1 2 2 3 5 5 6 9
% % test VtPlotUpdate()
% Tdata = -40:5:85;
% Vdata = 1.026E-1 + -1.125E-4 * Tdata + 1.125E-5 * Tdata.^2;
% load('StandardComponentValues.mat')

% p = plot(Tdata, Vdata, 'o-', 'LineWidth', 2);
% idxPop = [2, 3, 1, 60, 1, 6];
% RegPara = idx2RegPara(idxPop, Res, ThVal, ThBeta);

% ax = ancestor(p, 'axes');
% hold(ax, 'on');

% % Calculate the voltage data
% Vw = temp2volt(RegPara, Tdata);

% % Update the plot
% plot(ax, Tdata, Vw, 'o-', 'LineWidth', 2);
