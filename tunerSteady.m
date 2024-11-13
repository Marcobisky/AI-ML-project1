%% Main function for tune (c, m, e) paramater of GA when popNum and genNum are large enough and fixed
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
popNum = 400;
genNum = 300;
runNum = 3;

% partition
cNum = 20;
mNum = 20;
eNum = 8;
cVal = linspace(0, 1, cNum+1);
mVal = linspace(0, 1, mNum+1);
eVal = linspace(0, 1, eNum+1);

% Initialize the 5x5x5 array to store the bestBest loss values
tuning = zeros(cNum, mNum, eNum);

%% Loop through each combination of elitismRate, crossRate, and mutateRate
for e = 1:eNum
    for c = 1:cNum
        for m = 1:mNum
            % Set parameter values for this iteration
            crossRate = cVal(c);
            mutateRate = mVal(m);
            elitismRate = eVal(e);
            
            % Initialize matrix to store the best loss values for each of the 10 runs
            bestLoss = zeros(genNum, runNum);

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
end

%% Visualize
for i = 1:eNum
    figure;
    % find the least loss value and its index
    [minLoss, minIdx] = findMinWithCoords(tuning(:, :, i));
    imagesc([0 1], [0 1], tuning(:, :, i));
    xlabel('Crossover Rate');
    ylabel('Mutation Rate');
    title(['Elitism Rate = ', num2str(eVal(i)), ', Best Loss = ', num2str(minLoss), ' at (', num2str(cVal(minIdx(1))), ', ', num2str(mVal(minIdx(2))), ')']);
    colorbar;
end



%% Visualize the tuning results with a 3D heatmap

% % Generate grid for visualization
% [elitismGrid, crossGrid, mutateGrid] = ndgrid(paramIntervals, paramIntervals, paramIntervals);

% % Flatten the data for 3D scatter plot visualization
% x = elitismGrid(:);
% y = crossGrid(:);
% z = mutateGrid(:);
% values = tuning(:);

% % Create a 3D scatter plot
% figure;
% scatter3(x, y, z, 100, values, 'filled');
% colorbar;
% title('3D Heatmap of Best Loss Values');
% xlabel('Elitism Rate');
% ylabel('Crossover Rate');
% zlabel('Mutation Rate');
% caxis([min(values), max(values)]);  % Adjust color axis for better visualization
% grid on;
