function [pdf] = getPDFdistributionWithT(corr_mat,binCentres,T,smoothFlag)

pdf = zeros(length(T),length(binCentres));

for ix = 1:length(T)
   corr_values_above_T = corr_mat(corr_mat>T(ix));
   [n,~] = hist(corr_values_above_T,binCentres);
   if(smoothFlag)
       pdf(ix,:) = smooth(smooth(n/sum(n)));
   else
       pdf(ix,:) = n/sum(n);
   end
%%   Plots
%    figure
%    plot(x,pdf(ix,:))
%    title(['k=' num2str(T(ix))])
end
    
end % end function