function [stats_pdf] = getMeanAndStdCombinedPdfs(pdf,betweenIndices)
comb_pdf = [];
for idx = 1:length(betweenIndices)
   
    comb_pdf = [comb_pdf; pdf{betweenIndices(idx)}];
    
end

mean_pdf = mean(comb_pdf,1);

std_pdf = std(comb_pdf,0,1);

stats_pdf = mean_pdf;

stats_pdf(2,:) = std_pdf;

end