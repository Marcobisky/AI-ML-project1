%% Usage: Get the best, worst, or median individual from one generation
% config -> Configuration for selecting the individual ('median', 'best', 'worst')
% idxPop -> Population in index form in this generation (matrix)
% popLoss -> Loss values of the population (column vector)
% Res, ThVal, ThBeta -> Data in .mat
% idxPop_picked -> The selected individual in index form
% RegPara_picked -> The selected individual in register parameter form
% popLoss_picked -> The loss value of the selected individual

function [idxPop_picked, RegPara_picked, popLoss_picked] = popFilter(config, idxPop, popLoss, Res, ThVal, ThBeta)
    % Check if the config input is valid
    if ~ischar(config) || ~ismember(config, {'median', 'best', 'worst'})
        error('Invalid configuration. Use ''median'', ''best'', or ''worst''.');
    end

    switch config
        case 'median'
            popLoss_picked = median(popLoss);
            idx_picked = find(min(popLoss(find(popLoss >= popLoss_picked))), 1);
            idxPop_picked = idxPop(idx_picked, :);
            RegPara_picked = idx2RegPara(idxPop_picked, Res, ThVal, ThBeta);
        case 'best'
            popLoss_picked = min(popLoss);
            idx_picked = find(popLoss == popLoss_picked, 1);
            idxPop_picked = idxPop(idx_picked, :);
            RegPara_picked = idx2RegPara(idxPop_picked, Res, ThVal, ThBeta);
        case 'worst'
            popLoss_picked = max(popLoss);
            idx_picked = find(popLoss == popLoss_picked, 1);
            idxPop_picked = idxPop(idx_picked, :);
            RegPara_picked = idx2RegPara(idxPop_picked, Res, ThVal, ThBeta);
    end
end