%% continuousWithinBeyondFunction Test

for ix = 1:length(d_q) % for all the QUERY positions in a corridor
    

[distances_all{ix}] = getDistancesBetweenDescriptors(d_q{ix},d_db,0,1.5);

end

%% Scaling (converting from Euclidean distances to 'correlation' or RHO
Max =  max(cell2mat(cellfun(@(x) max(x(:)),distances_all,'UniformOutput',0)));

numConsecSamples = 100; % Number of consecutive samples to take 
                       % into account for the quantification of the
                       % similarity. 100 samples ~ 2m
                       
Ndb = length(distances_all{1}); % Db items

for ix = 1:length(d_q)
   
    correlations_all{ix} = (-distances_all{ix}+Max)/Max;
    
    % This smooth provides the equivalent of taking consecutive samples
    % from the database
    
%     smoothed_correlations{ix} = smooth(correlations_all{ix},numConsecSamples);
    smoothed_correlations{ix} = correlations_all{ix};  % Passing the raw data
    % Get the peaks of the smoothed curves 
    
    [peaks(ix) idx_peaks(ix)] = max(smoothed_correlations{ix});
    
    % Register on the raw values
    
    blobs{ix} = registerBlobs(smoothed_correlations{ix},Ndb,idx_peaks(ix));
    
end