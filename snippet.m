%% The test

x = linspace(0,1,100);

for s = 50:1:gt_q(end)

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
        pdf_beyond{ix}{s} = n_beyond/sum(n_beyond);
        
    end

end
