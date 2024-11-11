%% Usage: Convert the index population to register parameter population
% idxPop -> 6-dim points in the search space (the population in index form)
% StdRes, StdTherm_Val, StdTherm_Beta -> data in .mat
% RegPara -> 8-dim points (the population in register parameter form)

function RegPara = idx2RegPara(idxPop, StdRes, StdTherm_Val, StdTherm_Beta)
    % Turn Res into row vector
    StdRes = StdRes';
    a = StdRes(idxPop(:, 1:4));
    b = StdTherm_Val(idxPop(:, 5));
    c = StdTherm_Beta(idxPop(:, 5));
    d = StdTherm_Val(idxPop(:, 6));
    e = StdTherm_Beta(idxPop(:, 6));
    RegPara = [a, b, c, d, e];
end