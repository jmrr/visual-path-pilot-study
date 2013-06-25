%% SmoothingOnCorrelationsTest

for ix = 1:length(d_q) % for all the positions in a corridor


[distances_all{ix}] = getDistancesBetweenDescriptors(d_db,d_q{ix},0);


end


%%

Max =  max(cell2mat(cellfun(@(x) max(x(:)),distances_all,'UniformOutput',0)));


for ix = 1:length(d_q)
   
    correlations_all{ix} = (-distances_all{ix}+Max)/Max;
    smoothed_correlations{ix} = smooth(correlations_all{ix},11);
    

end

%%

surrounding = 50;

for ix = 1:length(d_q) % for all the positions in a corridor

    central_point = gt_q(ix); % Get ground truth position of the QUERY
    
    %% Surrounding locations
    % Get the closest SURROUNDING positions from the DATABASE
    [idx_surr_min,~,idx_surr_max] = ...
        getDBindicesOfSurroundingQueries(central_point,surrounding,gt_db);
    
    % Get the descriptor corresponding to DATABASE images at those locations
    idx_surrounding = idx_surr_min:idx_surr_max;
    
    values_within{ix} = smoothed_correlations{ix}(idx_surrounding);
    
    %% 'Far' locations

    % Get the descriptor corresponding to DATABASE images at those FAR locations
    idx_all = 1:length(d_db);
    idx_beyond = setdiff(idx_all,idx_surrounding);

    values_beyond{ix} = smoothed_correlations{ix}(idx_beyond);

end
%% WITHIN-BEYOND distributions (PDF)

x = linspace(0,1,100);

[n_within,~] = hist(cat(1,values_within{:}),x);
pdf_within = n_within/sum(n_within);

[n_beyond] = hist(cat(1,values_beyond{:}),x);
pdf_beyond = n_beyond/sum(n_beyond);


% PLOTS: 

figure
plot(x,smooth(smooth(pdf_within)));
hold on
plot(x,smooth(smooth(pdf_beyond)),'r');


%% ROC curves

cs_within = cumsum(pdf_within);
cs_beyond = cumsum(pdf_beyond);

% ROC plots
figure;
hold on
plot(cs_within,cs_beyond)
axis tight
