function createfigure(yvector1)
%CREATEFIGURE(YVECTOR1)
%  YVECTOR1:  bar yvector
% This will generate a barplot of the weightings from a PCA with names below. You may edit names so they are in the correct order

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,...
    'XTickLabel',{'RtES','RlES','RGMA','RGMe','RTFL','RBF','REO','RIO','LtES','LlES','LGMA','LGME','LTFL','LBF','LEO','LIO'},...
    'XTick',[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16],...
    'TickDir','out');
hold(axes1,'on');

% Create bar
bar(yvector1);

