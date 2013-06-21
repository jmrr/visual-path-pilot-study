T = 0.1:0.01:1;

for ix = 1:length(T)
   corr_values_above_T_within(ix) = sum(corr_mat>T(ix));
   ratio_corr_values_within(ix) = corr_values_above_T_within(ix)/length(corr_mat); 
%    [n,~] = hist(corr_values_above_T,xc);
%    pdf(ix,:) = smooth(smooth(n/sum(n)));
%    figure
%    plot(x,pdf(ix,:))
%    title(['k=' num2str(T(ix))])
end


%%

for ix = 1:length(T)
   corr_values_above_T_between(ix) = sum(corr_mat_between>T(ix));
   ratio_corr_values_between(ix) = ...
       corr_values_above_T_between(ix)/length(corr_mat_between); 
%    [n,~] = hist(corr_values_above_T,xc);
%    pdf(ix,:) = smooth(smooth(n/sum(n)));
%    figure
%    plot(x,pdf(ix,:))
%    title(['k=' num2str(T(ix))])
end

%%
plot(ratio_corr_values_between,ratio_corr_values_within)