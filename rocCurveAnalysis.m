
% Correlation threshold 
T = 0.1:0.01:1;

% Within SURROUNDING SAMPLES

for ix = 1:length(T)
   corr_values_above_T_within(ix) = sum(corr_mat_surr>T(ix));
   ratio_corr_values_within(ix) = corr_values_above_T_within(ix)/length(corr_mat_surr); 
%    [n,~] = hist(corr_values_above_T,xc);
%    pdf(ix,:) = smooth(smooth(n/sum(n)));
%    figure
%    plot(x,pdf(ix,:))
%    title(['k=' num2str(T(ix))])
end


% Between FAR SAMPLES with a GAP in the middle


for ix = 1:length(T)
   corr_values_above_T_between(ix) = sum(corr_mat_gap>T(ix));
   ratio_corr_values_between(ix) = ...
       corr_values_above_T_between(ix)/length(corr_mat_gap); 
%    [n,~] = hist(corr_values_above_T,xc);
%    pdf(ix,:) = smooth(smooth(n/sum(n)));
%    figure
%    plot(x,pdf(ix,:))
%    title(['k=' num2str(T(ix))])
end

%% ROC CURVE

figure
plot(ratio_corr_values_between,ratio_corr_values_within)