%% distributionWithinBeyondSmoothingPDF is a program that computes the
% distribution of values of the metric rho (correlation values calculated
% from squared Euclidean distances between SIFT descriptors) from 0 to 1.
% Two distributions of rho values are shown:
% a) when the correlation is between a query image and images in the surrounding (or within the) 
%    area near to the ocation of the query.
%
% b) when the correlation is between the query image and images outside
% this surrounding area.

% Specify how many centimetres behind and beyond the central point of the
% query we'd like to take database images from.

surrounding = 50;

% Get the correlations (transformed distances) at those given distances

[correlations_surrounding,correlations_beyond] = getCorrelationsNearQueryPositions(surrounding,gt_q,gt_db,d_q,d_db);

%% WITHIN-BEYOND distributions (PDF)

x = linspace(0,1,100);

[n_within,~] = hist(cat(2,correlations_surrounding{:}),x);
pdf_within = n_within/sum(n_within);

[n_beyond] = hist(cat(2,correlations_beyond{:}),x);
pdf_beyond = n_beyond/sum(n_beyond);


% PLOTS: 

figure
plot(x,smooth(smooth(pdf_within)));
hold on
plot(x,smooth(smooth(pdf_beyond)),'r');


%% ROC curves 

cs_within = cumsum(pdf_within);
cs_beyond = cumsum(pdf_beyond);

% ROC plots (one at a time)
figure;
plot(cs_within,cs_beyond)
hold on
axis tight