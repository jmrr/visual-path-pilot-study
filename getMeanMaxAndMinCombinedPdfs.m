function [stats_pdf_max_min] = getMeanMaxAndMinCombinedPdfs(pdf,betweenIndices)
comb_pdf = [];
for idx = 1:length(betweenIndices)
   
    comb_pdf = [comb_pdf; pdf{idx}];
    
end

mean_pdf = mean(comb_pdf,1);

std_pdf = std(comb_pdf,0,1);

max_val = max(comb_pdf,[],1);
min_val = min(comb_pdf,[],1);
stats_pdf_max_min = mean_pdf;

stats_pdf_max_min(2,:) = max_val;
stats_pdf_max_min(3,:) = min_val;

end