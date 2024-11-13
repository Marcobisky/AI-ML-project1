%% Tune popNum and genNum for GA, this may take longer than 3 hours, all output data is stored in dynamicTuningData.mat
clear;
addpath('./Func');
addpath('./GAlib');
addpath('./Data');
load('StandardComponentValues.mat')

%% Temperature samples and expected Voltage Data
Tdata = -40:5:85;
Vdata = 1.026E-1 + -1.125E-4 * Tdata + 1.125E-5 * Tdata.^2;

%% Define parameter intervals
lb = [1 1 1 1 1 1];
ub = [70 70 70 70 9 9];
runNum = 3; % speed up the process by adjusting this

% partition
popVal = linspace(1, 501, 20+1);
genVal = linspace(1, 501, 20+1);
cNum = 5;
mNum = 5;
eNum = 5;
cVal = linspace(0, 1, cNum+1);
mVal = linspace(0, 1, mNum+1);
eVal = linspace(0, 1, eNum+1);

% Initialize the 5x5x5 array to store the bestBest loss values
tuning = zeros(cNum, mNum, eNum);

% for storing the \xi=(c,m,e) parameter for the least loss
bestcme = cell(length(popVal), length(genVal));
% for storing the corresponding loss value for each element in bestcme
losscme = zeros(length(popVal), length(genVal));

% for Loss(c, m, e) and \xi^*=(c, m)
minLoss = zeros(eNum, 1);
minIdx = zeros(eNum, 2);

%% Loop through each combination of parameters
for p = 1:21
    for g = 1:21
        for e = 1:eNum
            for c = 1:cNum
                for m = 1:mNum
                    % Set parameter values for this iteration
                    crossRate = cVal(c);
                    mutateRate = mVal(m);
                    elitismRate = eVal(e);
                    popNum = popVal(p);
                    genNum = genVal(g);
                    
                    % Initialize matrix to store the best loss values for each of the 10 runs
                    bestLoss = zeros(genVal(g), runNum);

                    % Run the GA 10 times for this parameter combination
                    for runRound = 1:runNum
                        % Initialize population
                        idxPop = popInit(popNum, lb, ub);

                        % Perform GA optimization for genNum generations
                        for i = 1:genNum
                            % Calculate fitness
                            RegPop = idx2RegPara(idxPop, Res, ThVal, ThBeta);
                            popLoss = l2squared(RegPop, Tdata, Vdata);

                            % Record the best individual in each generation
                            [~, ~, bestLoss(i, runRound)] = popFilter('best', idxPop, popLoss, Res, ThVal, ThBeta);

                            % Selection using SUS
                            [elitePop, idxPop_s] = selectSUS(idxPop, popLoss, elitismRate);

                            % Crossover
                            idxPop_c = crossover(idxPop_s, crossRate);

                            % Mutation
                            idxPop_m = mutate(idxPop_c, mutateRate, lb, ub);

                            % Mix elite and mutated population
                            idxPop = mix(elitePop, idxPop_m); % Replace the old population
                        end
                    end
                    
                    % Calculate the bestBest loss value over the 10 runs
                    [~, bestBest, ~, ~, ~] = runPlot(bestLoss, runNum, 0);
                    tuning(c, m, e) = bestBest{1};  % Store the bestBest loss in the tuning array
                end
            end
            [minLoss(e), minIdx(e, :)] = findMinWithCoords(tuning(:, :, e));
        end
        % extract the best loss for zeta=(p, g)
        [losscme(p, g), whiche] = findMinWithCoords(minLoss);
        idx2val = minIdx(whiche(1), :);
        bestcme{p, g} = [cVal(idx2val(1)), mVal(idx2val(2)), eVal(whiche(1))];
    end
end

%% Visualization
figure;
imagesc([popVal(1) popVal(end)], [genVal(1) genVal(end)], log(losscme));
colormap(jet);
colorbar;
xlabel('popNum');
ylabel('genNum');
title('Best Loss for Different popNum and genNum');
set(gca, 'YDir', 'normal');
