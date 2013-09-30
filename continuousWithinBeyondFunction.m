%% continuousWithinBeyondFunction Test

for ix = 1:length(d_q) % for all the positions in a corridor
    

[distances_all{ix}] = getDistancesBetweenDescriptors(d_q{ix},d_db,0,3);


end


%% Scaling (converting from Euclidean distances to 'correlation' or RHO
Max =  max(cell2mat(cellfun(@(x) max(x(:)),distances_all,'UniformOutput',0)));

numConsecSamples = 100; % Number of consecutive samples to take 
                       % into account for the quantification of the
                       % similarity. 100 samples ~ 2m

for ix = 1:length(d_q)
   
    correlations_all{ix} = (-distances_all{ix}+Max)/Max;
    
    % This smooth provides the equivalent of taking consecutive samples
    % from the database
    
    smoothed_correlations{ix} = smooth(correlations_all{ix},numConsecSamples);
    

end

%% The test

x = linspace(0,1,100);

for s = 1:1:gt_q(end)

    surrounding = s; % 

    for ix = 1:length(d_q) % for all the positions in a corridor

        central_point = gt_q(ix); % Get ground truth position of the QUERY

        %% Surrounding locations
        % Get the closest SURROUNDING positions from the DATABASE
        [idx_surr_min,~,idx_surr_max] = ...
            getDBindicesOfSurroundingQueries(central_point,surrounding,gt_db);

        % Get the descriptor corresponding to DATABASE images at those locations
        idx_surrounding = idx_surr_min:idx_surr_max;

        values_within{ix}{s} = smoothed_correlations{ix}(idx_surrounding);

        %% 'Far' locations

        % Get the descriptor corresponding to DATABASE images at those FAR locations
        idx_all = 1:length(d_db);
        idx_beyond = setdiff(idx_all,idx_surrounding);

        values_beyond{ix}{s} = smoothed_correlations{ix}(idx_beyond);
        
        %% Within-beyond distributions (PDFs)
        
        [n_within,~] = hist(values_within{ix}{s},x);
        pdf_within{ix}{s}  = n_within/sum(n_within);
        
        [n_beyond] = hist(values_beyond{ix}{s},x);
        pdf_beyond{s} = n_beyond/sum(n_beyond);
        
    end

end

%% WITHIN-BEYOND distributions (PDF)


for ix = 1:length(d_q)
    
    [n_within,~] = hist(cat(1,values_within{ix}{:}),x);
    pdf_within{ix} = n_within/sum(n_within);

    [n_beyond] = hist(cat(1,values_beyond{:}),x);
    pdf_beyond{s} = n_beyond/sum(n_beyond);
end
