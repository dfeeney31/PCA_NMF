function PCA_NMF(all,x)
%PCA_NMF will run a PCA and NMF with a specified number of factors on time
%series data
%   Data for n subjects should be stored in a no. frames x features x
%   subjects matrix. x is number of factors
%specs = ['RtES','RlES','RGMa','RGMe','RTFL','RBF','REO','RIO','LtES','LlES','LGMa','LGMe','LTFL','LBF','LEO','LIO'];
%   The outputs will be Timings (3D), Weights (3D), and VarExp (2D) from the PCA, which
%   are subject specific. 

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
    Weights(:,:,iii) = coeff(:,1:3); %Fill this with weights from 3 factors
    VarExp(:,iii) = explained;       %Put the var explained by first PC in first column of VarExp
end

AVG_timing = mean(Timings,3);   %Average timing synergy
%This will plot the time series for each subject
figure                          
for c = 1:subjects
   subplot(3,1,1)
    plot(Timings(:,1,c))
    hold on
    subplot(3,1,2)
    plot(Timings(:,2,c))
    hold on
    subplot(3,1,3)
    plot(Timings(:,3,c)) 
    hold on
end

avg_wts = mean(Weights,3);
for cc = 1:factors
    MakeCors(avg_wts(:,cc))
end

figure(5)
for lll = 1:3
subplot(3,1,lll)
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
factors = 3;
x = 3;
W = zeros(size(all,1),x,subjects);  %Preallocate timings
Hs = zeros(x,features,subjects);    %Preallocate muscle weights

for ab = 1:subjects
    [W(:,:,ab),Hs(:,:,ab)] = nnmf(all(:,:,ab),3);
end

%Normalization of weights
norm_cors = zeros(1,x,features);%Preallocate normalized correlations
maxes = max(Hs,[],2);                   %Obtain maxes for each row
norm_cors = bsxfun(@rdivide,Hs,maxes);

Avg_cor = mean(norm_cors,3);
Avg_cor = Avg_cor';

for dd = 1:factors
    MakeCors(Avg_cor(:,dd))
end

% maxes = zeros(1,3);
% norm_cors = zeros(3,16);
assignin('base', 'W', W);
assignin('base', 'Norm_cors', norm_cors);
assignin('base', 'Avg_cors', Avg_cor);
end

