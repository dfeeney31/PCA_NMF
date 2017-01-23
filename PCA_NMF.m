function PCA_NMF(all,x)
%PCA_NMF will run a PCA and NMF with a specified number of factors on time
%series data
%   Data for n subjects should be stored in a no. frames x features x
%   subjects matrix. x is number of factors
%   The outputs will be Timings (3D), Weights (3D), and VarExp (2D) from the PCA, which
%   are subject specific. 
rng(10); %Set seed
features = size(all,2);
subjects = size(all,3);
factors = x;

Weights = zeros(features,x,subjects); %Preallocate weighting matrix for PCA
Timings = zeros(size(all,1),x,subjects);      %Preallocate timing matrix for PCA
VarExp = zeros(features,subjects);   %Preallocate VarExp so each column represents a subject and each entry is var exp by that PC

%Perform PCA and varimax rotation
for iii = 1:subjects
    [coeff,score,latent,tsquared,explained,mu] = pca(all(:,:,iii));           %Normal PCA
    [coeff2,score2,latent2] = factoran(all(:,:,iii),3, 'rotate','varimax');   %Varimax rotation

    %Store the data
    Timings(:,:,iii) = score(:,1:x); %Fll this with the timings from 1:x factors
    Weights(:,:,iii) = coeff(:,1:x); %Fill this with weights from 3 factors
    VarExp(:,iii) = explained;       %Put the var explained by first PC in first column of VarExp
end

AVG_timing = mean(Timings,3);   %Average timing synergy
%This will plot the time series for each subject
figure(1)                          
for c = 1:subjects
    subplot(x,1,c)
    plot(Timings(:,1,c))
    hold on
end
hold off

avg_wts = mean(Weights,3);
figure(2)
for aa = 1:x
    subplot(x,1,aa)   
    bar(avg_wts(:,aa))
    set(gca,'XTickLabel',[],'TickDir','out','Box','off')
end
ax = gca
ax.XTick = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16];
ax.XTickLabel = {'LBF','LES','LGMAX','LIO','LLD','LMG','LRF','LTA','RBF','RES','RGMAX','RIO','RLD','RMG','RRF','RTA'}

figure(3)
for lll = 1:x
subplot(x,1,lll)
plot(AVG_timing(:,lll))
end

assignin('base', 'Timings', Timings);
assignin('base', 'Weights', Weights);
assignin('base', 'VarExp', VarExp);
assignin('base', 'avg_wts', avg_wts);
assignin('base', 'Avg_timing', AVG_timing);

%% Perform NMF
%W's are time series, Hs are weights
features = size(all,2);
subjects = size(all,3);
W = zeros(size(all,1),x,subjects);  %Preallocate timings
Hs = zeros(x,features,subjects);    %Preallocate muscle weights

for ab = 1:subjects
    [W(:,:,ab),Hs(:,:,ab)] = nnmf(all(:,:,ab),x);
end

%Normalization of weights
norm_cors = zeros(1,x,features);%Preallocate normalized correlations
maxes = max(Hs,[],2);                   %Obtain maxes for each row
norm_cors = bsxfun(@rdivide,Hs,maxes);

Avg_cor = mean(norm_cors,3);
Avg_cor = Avg_cor';

figure(4)
for aa = 1:x
    subplot(x,1,aa)   
    bar(Avg_cor(:,aa))
    set(gca,'XTickLabel',[],'TickDir','out','Box','off')
end
ax = gca
ax.XTick = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16];
ax.XTickLabel = {'LBF','LES','LGMAX','LIO','LLD','LMG','LRF','LTA','RBF','RES','RGMAX','RIO','RLD','RMG','RRF','RTA'}

figure(5)
for ee = 1:subjects
   subplot(x,1,ee)
    plot(W(:,1,ee))
    hold on
end

hold off
norm_W = mean(W,3);

figure(6)
for r = 1:x
    title('AVG Time series NMF')
    subplot(x,1,r);
    plot(norm_W(:,r),'color','k');
end

CumVarExp = cumsum(VarExp,1); 
AvgVarExp = mean(CumVarExp,2);
SDvar = std(CumVarExp,0,2);
figure(7)
errorbar(AvgVarExp,SDvar,'.','Color','black','MarkerSize',8);
box off

assignin('base', 'W', W);
assignin('base', 'Norm_cors', norm_cors);
assignin('base', 'Avg_cors', Avg_cor);
assignin('base', 'AvgVarExp', AvgVarExp);
assignin('base', 'CumVarExp', CumVarExp);
assignin('base', 'SDvar', SDvar);
end

