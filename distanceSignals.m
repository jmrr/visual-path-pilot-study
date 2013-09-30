% pastthresholIdx = cellfun(@(x) find(x>0.5),correlationSignals,'UniformOutput',0);

pastThreshold = zeros(size(correlations));

for ix = 1:size(correlations,1)
    
    validIndices = find(correlations(ix,:)>0.5);
    pastThreshold(ix,validIndices) = correlations(ix,validIndices);
    
end % end for


[X,Y] = meshgrid(linspace(0,1,size(correlations,2)),linspace(0,1,size(correlations,1)));

figure,

contour(X,Y,correlations,15)