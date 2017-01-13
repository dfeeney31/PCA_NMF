%%%% Read in flexion data, rectify, bandpass filter, output a subject specific csv file %%%%
cd('/Users/danielfeeney/Documents/FlexionProj/FlexionProcessed_files');    %Set WD for you
%clear
frq = 2000;                             %Sampling frequency
normal = 0;                             %Set to 1 if you want normalized EMG (0-100%), 0 non- normalized

% Read in files and remove 17th columns of 0s
F20 = csvread('F20_Odau_2.csv',5,1); F20(:,17) = [];
F22 = csvread('F22_Odau_2.csv',5,1); F22(:,17) = [];
%F33 = csvread('F33_Odau_2.csv',5,1); F33(:,17) = [];
M03 = csvread('M03_Odau_2.csv',5,1); M03(:,17) = [];
M06 = csvread('M06_Odau_2.csv',5,1); M06(:,17) = [];
M07 = csvread('M07_Odau_2.csv',5,1); M07(:,17) = [];
M15 = csvread('M15_Odau_2.csv',5,1); M15(:,17) = [];
M16 = csvread('M16_Odau_2.csv',5,1); M16(:,17) = [];

%Bandpass filter EMG signals for each subject
[b,a] = butter(6,[20 490]/(frq/2),'bandpass');
F20out = filtfilt(b,a,F20);
F22out = filtfilt(b,a,F22);
%F33out = filtfilt(b,a,F33);
M03out = filtfilt(b,a,M03);
M06out = filtfilt(b,a,M06);
M07out = filtfilt(b,a,M07);
M15out = filtfilt(b,a,M15);
M16out = filtfilt(b,a,M16);

%From spreadsheet, trim files to forward flexion data points & rectify
F20 = abs(F20out(3761:12081, :)); 
F22 = abs(F22out(6441:13521,:));
%F33 = F33( No start/end data from this subject)
M03 = abs(M03out(3441:13481,:));
M06 = abs(M06out(7281:14161,:));
M07 = abs(M07out(4681:16321,:));
M15 = abs(M15out(5321:15001,:));
M16 = abs(M16out(5721:14201,:));

%Linear envelope w/ 10 Hz LP filter
[b1,a1] = butter(4,10/frq,'low');
F20filt = filtfilt(b1,a1,F20);
F22filt = filtfilt(b1,a1,F22);
%F33filt = filtfilt(b1,a1,F33out);
M03filt = filtfilt(b1,a1,M03);
M06filt = filtfilt(b1,a1,M06);
M07filt = filtfilt(b1,a1,M07);
M15filt = filtfilt(b1,a1,M15);
M16filt = filtfilt(b1,a1,M16);

%interpolate to make the same length.
F20resamp = resample(F20filt,1000,length(F20filt));
F22resamp = resample(F22filt,1000,length(F22filt));
%F33resamp = resample(F33filt,1000,length(F33filt));
M03resamp = resample(M03filt,1000,length(M03filt));
M06resamp = resample(M06filt,1000,length(M06filt));
M07resamp = resample(M07filt,1000,length(M07filt));
M15resamp = resample(M15filt,1000,length(M15filt));
M16resamp = resample(M16filt,1000,length(M16filt));
placehold = zeros(1,1000);
if (normal == 1)
    for mm = 1:16
        F20norm(:,mm) = (F20resamp(:,mm)./(max(F20resamp(:,mm)))) * 100;
        F22norm(:,mm) = (F22resamp(:,mm)./(max(F22resamp(:,mm)))) * 100;
        %F33norm(:,mm) = (F33resamp(:,mm)./(max(F33resamp(:,mm)))) * 100;
        M03norm(:,mm) = (M03resamp(:,mm)./(max(M03resamp(:,mm)))) * 100;
        M06norm(:,mm) = (M06resamp(:,mm)./(max(M06resamp(:,mm)))) * 100;
        M07norm(:,mm) = (M07resamp(:,mm)./(max(M07resamp(:,mm)))) * 100;
        M15norm(:,mm) = (M15resamp(:,mm)./(max(M15resamp(:,mm)))) * 100;
        M16norm(:,mm) = (M16resamp(:,mm)./(max(M16resamp(:,mm)))) * 100;
    end
    all = cat(3,F20norm,F22norm,M03norm,M06norm,M07norm,M15norm,M16norm);
    avg_en = mean(cat(3,F20norm,F22norm,M03norm,M06norm,M07norm,M15norm,M16norm),3); %REMEMBER 07 OUT
    X = 1:length(F20norm);
    %createfigure2(avg_en,F20norm,F22norm,M03norm,M06norm,placehold,M15norm,M16norm, X);
    %MakeFigure(avg_en);
else
    all = cat(3,F20resamp,F22resamp,M03resamp,M06resamp,M07resamp,M15resamp,M16resamp);
    avg_en = mean(cat(3,F20resamp,F22resamp,M03resamp,M06resamp,M15resamp,M16resamp),3); %REMEMBER 07 OUT
    X = 1:length(F20resamp);
    %createfigure2(En_avg,F20resamp,F22resamp,M03resamp,M06resamp,placehold,M15resamp,M16resamp, X);
    %MakeFigure(En_avg);
end
