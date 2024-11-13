clear;
addpath('./Func');
addpath('./GAlib');
addpath('./Data');

%% load all data needed, these data is generated by tunerDynamic.m
load('dynamicTuningData.mat');

%% Visualization
figure;
imagesc([popVal(1) popVal(end)], [genVal(1) genVal(end)], log(losscme));
colormap(jet);
colorbar;
xlabel('popNum');
ylabel('genNum');
title('Best Loss for Different popNum and genNum');
set(gca, 'YDir', 'normal');
