function [blobs] = registerBlobsWithGroundTruth(correlation,surrounding,idx_min,idx_central,idx_max)
    
% Take 300 samples around the ground truth
span = surrounding*2;
blobs = nan(span,1);

idx = idx_min:idx_max;
L = length(idx);

if  L < span
    
    left_tail = idx_central-idx_min;
    right_tail = idx_max-idx_central;
    
    blobs(1:L) = correlation(idx_min:idx_max);
    shifted = circshift(blobs,surrounding-left_tail);
    plot(shifted)
%     if left_tail > right_tail
%         blobs(surrounding:surrounding+right_tail) = correlation(idx_central:idx_max);
%         if left_tail >= surrounding
%             blobs(1:surrounding) = correlation(idx_min:idx_central-1);
%         else
%             blobs(surrounding-left_tail:surrounding) = correlation(idx_min:idx_central);
%         end
% %     else
%         blobs(surrounding:surrounding+right_tail) = correlation(idx_central:idx_max);
%         blobs(surrounding-left_tail:surrounding) = correlation(idx_min:idx_central);
%     end
else
    blobs = correlation(idx);
end

end % end registerBlobs
