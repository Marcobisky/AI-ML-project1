%% Usage: Mix the elite population with the sus population
% elitePop -> Elite population
% susPop -> Sus population
% idxPop_mix -> Mixed population

function idxPop_mix = mix(elitePop, susPop)
    idxPop_mix = [elitePop; susPop];
    % randomly shuffle the population
    idxPop_mix = idxPop_mix(randperm(size(idxPop_mix, 1)), :);
end