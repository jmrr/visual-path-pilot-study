function [blobs] = registerBlobsWithGroundTruth(correlation,surrounding,idx_min,idx_central,idx_max)
    
% Take 300 samples around the ground truth
span = surrounding*2;
blobs = nan(span,1);

idx = idx_min:idx_max;
L = length(idx);

if  L < span
    
    left_tail = idx_central-idx_min;
    right_tail = idx_max-idx_central;
    
    blobs(1:L) = correlation(idx);
    blobs = circshift(blobs,[surrounding-left_tail,0]);
%     plot(shifted)
%     values = sum(~isnan(blobs))
else
    blobs = correlation(idx);
end

end % end registerBlobsWithsioGroundTruth
