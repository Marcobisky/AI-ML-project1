%% Main function for GA optimization
clear;
addpath('./Func');
addpath('./GAlib');
addpath('./Data');
load('StandardComponentValues.mat')

%% Temperature samples and expected Voltage Data
Tdata = -40:5:85;
Vdata = 1.026E-1 + -1.125E-4 * Tdata + 1.125E-5 * Tdata.^2;

%% Main parameters
lb = [1 1 1 1 1 1];
ub = [70 70 70 70 9 9];
popNum = 700;
elitismRate = 0.8;
crossRate = 0.9;
mutateRate = 0.8;
genNum = 400;
runNum = 10;

%% For plotting
gen_coor = 1:genNum;
medianLoss = zeros(genNum, runNum);
bestLoss = zeros(genNum, runNum);
% store the optimal configuration information in each generation
idxPop_best = zeros(genNum, 6, runNum);  % in index form
RegPara_best = zeros(genNum, 8, runNum); % in register parameter form

%% Perform GA optimization
for runRound = 1:runNum
    % Initialize population
    idxPop = popInit(popNum, lb, ub);

    for i = gen_coor
        % Calculate fitness
        RegPop = idx2RegPara(idxPop, Res, ThVal, ThBeta);
        popLoss = l2squared(RegPop, Tdata, Vdata);

        % record the register configuration of the best individual
        [idxPop_best(i, :, runRound), RegPara_best(i, :, runRound), bestLoss(i, runRound)] = popFilter('best', idxPop, popLoss, Res, ThVal, ThBeta);
        
        % Select using SUS
        [elitePop, idxPop_s] = selectSUS(idxPop, popLoss, elitismRate);

        % Crossover
        idxPop_c = crossover(idxPop_s, crossRate);

        % Mutate
        idxPop_m = mutate(idxPop_c, mutateRate, lb, ub);

        % Mix elite and mutated population
        idxPop_mix = mix(elitePop, idxPop_m);
        
        % Replace the old population with the new one
        idxPop = idxPop_mix;
    end
end

%% Plot the average of the best-so-far objective function values over 10 runs in each generation
cvgPlot(bestLoss, genNum);

%% Plot the best, worst, and average optimal objective function values and their standard deviations over 10 runs
[~, bestBest, worstBest, avgBest, stdDev] = runPlot(bestLoss, runNum);

%% Print the best, worst and average best loss
% Find corresponding register configuration
idxPop_best = idxPop_best(bestBest{2}(1), :, bestBest{2}(2));
RegPara_best = RegPara_best(bestBest{2}(1), :, bestBest{2}(2));

% Print the results
disp(['Over ', num2str(runNum), ' runs:']);
disp(['The lowest loss is: ', num2str(bestBest{1})]);
disp(['at this point in the search space: ', num2str(idxPop_best)]);
disp(['with register configuration: ', num2str(RegPara_best)]);
disp(' ');
disp(['The highest loss is: ', num2str(worstBest{1})]);
disp(['The average best loss is: ', num2str(avgBest)]);
disp(['The standard deviation is: ', num2str(stdDev)]);

%% Plot the final best Vt curve
% Calculate the Vt curve given the best register configuration
Vbest = temp2volt(RegPara_best, Tdata);

figure;
plot(Tdata, Vdata, 'bo-', 'LineWidth', 2); % expected
hold on;
plot(Tdata, Vbest, 'r*-', 'LineWidth', 2); % optimal
xlabel('Temperature (C)');
ylabel('Voltage (V)');
title('Vt Curve');
legend('Expected', 'Optimal', 'Location', 'northwest');
grid on;




% Perform Vt plot animation
% VtPlotAnime(Tdata, Vdata, RegPara_med);

% plot the Vt graph of the last generation of the best and median individual
% Vbest = temp2volt(RegPara_best(end, :, 1), Tdata);
% Vmed = temp2volt(RegPara_med(end, :, 1), Tdata);

% figure;
% plot(Tdata, Vdata, 'bo-', 'LineWidth', 2);
% hold on;
% plot(Tdata, Vbest, 'r*-', 'LineWidth', 7);
% hold on;
% plot(Tdata, Vmed, 'go-', 'LineWidth', 2);
% hold on;

% xlabel('Temperature (C)');
% ylabel('Voltage (V)');
% title('Vt Curve');
% legend('Expected', 'Median', 'Best');
% grid on;

% 应在表格中列出 10 次运行的最佳、最差和平均最佳目标函数值及其标准偏差。
% 收敛曲线显示收敛曲线应显示每一代中 10 次运行的最佳目标函数值的平均值