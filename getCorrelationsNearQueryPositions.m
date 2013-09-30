function [correlations_surrounding,correlations_beyond] = ...
    getCorrelationsNearQueryPositions(surrounding,gt_q,gt_db,d_q,d_db)

% getCorrelationsNearQueryPositions takes a certain range of descriptors
% that correspond to nearby locations around each query specified by
% surrounding and computes the distances between the descriptors in the
% query and those ones in the database. Once the descriptors have been
% computed, they are transformed into correlation values.

for ix = 1:length(d_q) % for all the positions in a corridor

    central_point = gt_q(ix); % Get ground truth position of the QUERY
    
    %% Surrounding locations
    % Get the closest SURROUNDING positions from the DATABASE
    [idx_surr_min,~,idx_surr_max] = ...
        getDBindicesOfSurroundingQueries(central_point,surrounding,gt_db);
    
    % Get the descriptor corresponding to DATABASE images at those locations
    idx_surrounding = idx_surr_min:idx_surr_max;
    d_db_surrounding = d_db(idx_surrounding);
    
    %% 'Far' locations

    % Get the descriptor corresponding to DATABASE images at those FAR locations
    idx_all = 1:length(d_db);
    idx_beyond = setdiff(idx_all,idx_surrounding);
    d_db_selection_beyond = d_db(idx_beyond);
    
    %%Get the distances
    
    [distances_surrounding{ix}] = getDistancesBetweenDescriptors(d_q{ix},d_db_surrounding,0);
    [distances_beyond{ix}] = getDistancesBetweenDescriptors(d_q{ix},d_db_selection_beyond,0);

    
end

%% Normalisation to get RHO

Max1 =  max(cell2mat(cellfun(@(x) max(x(:)),distances_surrounding,'UniformOutput',0)));
Max2 =  max(cell2mat(cellfun(@(x) max(x(:)),distances_beyond(2:end),'UniformOutput',0)));

Max = max([Max1,Max2]); 

for ix = 1:length(d_q)
   
    correlations_surrounding{ix} = (-distances_surrounding{ix}+Max)/Max;
    correlations_beyond{ix} = (-distances_beyond{ix}+Max)/Max;

end
