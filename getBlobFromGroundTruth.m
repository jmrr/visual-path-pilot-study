%% Scaling (converting from Euclidean distances to 'correlation' or RHO
Max =  max(cell2mat(cellfun(@(x) max(x(:)),distances_all,'UniformOutput',0)));

numConsecSamples = 100; % Number of consecutive samples to take 
                       % into account for the quantification of the
                       % similarity. 100 samples ~ 2m

% I'd like to get 2*surrounding points from the database that are centred
% around the ground truth position for the current query

surrounding = 150;
                       
Ndb = length(distances_all{1}); % Db items

for ix = 1:length(d_q)
   
    correlations_all{ix} = (-distances_all{ix}+Max)/Max;
    
    % This smooth provides the equivalent of taking consecutive samples
    % from the database
    
    smoothed_correlations{ix} = smooth(correlations_all{ix},numConsecSamples);
    

    % Get the DB indices around the current query
    
    [idx_min,idx_central,idx_max] = ...
    getDBindicesOfSurroundingQueries(gt_q(ix),surrounding,gt_db);
    
    % Register based on the ground truth
    
    blobs{ix} = registerBlobsWithGroundTruth(correlations_all{ix},surrounding,idx_min,idx_central,idx_max);
    
end



