function [blobs] = registerBlobs(correlation,Ndb,idx_peaks)
    
% Align to the middle
centre = round(Ndb/2);
shift = centre - idx_peaks;
registered_correlations = circshift(correlation,shift);


% Take 100 samples (= 2 m) around the peak

blobs = registered_correlations(centre-50:centre+50);

[a,b]  = max(blobs)
plot(blobs)
end % end registerBlobs