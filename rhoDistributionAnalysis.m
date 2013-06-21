% %% Load files and save necessary variables
% path = './saved_data/surrounding_descriptors_analysis/';
% D = dir(path);
% D = D(3:end);
% 
% for ii = 1:length(D)
%    load([path D(ii).name]);
%    new_name = ['corr_mat_w_gap' num2str(gap)];
%    assignin('base','corr_mat_w_gap',new_name);
%    clearvars -except  -regexp corr_mat* D path;
% end

load('/media/Data/Code/Jose/visual_tuning_curves/saved_data/surrounding_descriptors_analysis/surrounding descriptors 50cm_gap = 100cm.mat')
corr_mat_w_gap100 = corr_mat_w_gap;
clearvars -except  -regexp corr_mat*
load('/media/Data/Code/Jose/visual_tuning_curves/saved_data/surrounding_descriptors_analysis/surrounding descriptors 50cm_gap = 200cm.mat')
corr_mat_w_gap200 = corr_mat_w_gap;
clearvars -except  -regexp corr_mat*
load('/media/Data/Code/Jose/visual_tuning_curves/saved_data/surrounding_descriptors_analysis/surrounding descriptors 50cm_gap = 300cm.mat')
corr_mat_w_gap300 = corr_mat_w_gap;
clearvars -except  -regexp corr_mat*

load('/media/Data/Code/Jose/visual_tuning_curves/saved_data/surrounding_descriptors_analysis/surrounding descriptors 50cm_gap = 400cm.mat')
load('/media/Data/Code/Jose/visual_tuning_curves/saved_data/surrounding_descriptors_analysis/surrounding descriptors 50cm_gap = 500cm.mat')
load('/media/Data/Code/Jose/visual_tuning_curves/saved_data/surrounding_descriptors_analysis/surrounding descriptors 50cm_gap = 600cm.mat')
load('/media/Data/Code/Jose/visual_tuning_curves/saved_data/surrounding_descriptors_analysis/surrounding descriptors 50cm_gap = 700cm.mat')
load('/media/Data/Code/Jose/visual_tuning_curves/saved_data/surrounding_descriptors_analysis/surrounding descriptors 50cm_gap = 800cm.mat')
%% Probability of k successive rho values > T / at different distances

T = 0.5;

corr_values_above_T = corr_mat(corr_mat>T);
corr_values_above_T_w_gap = corr_mat_w_gap(corr_mat_w_gap>T);

figure
Nbins = 50;
xc = 1/(2*Nbins):1/Nbins:1-1/(2*Nbins);
[n,~] = hist(corr_values_above_T,xc);
pdf = n/sum(n);
smoothed_pdf = smooth(smooth(pdf));
x = linspace(0,1,Nbins);
plot(x,smoothed_pdf)
hold on

%%

T = 0.1:0.01:0.9;

for ix = 1:length(T)
   corr_values_above_T = corr_mat(corr_mat>T(ix));
   [n,~] = hist(corr_values_above_T,xc);
   pdf(ix,:) = smooth(smooth(n/sum(n)));
   figure
   plot(x,pdf(ix,:))
   title(['k=' num2str(T(ix))])
end
%%
surf(pdf)