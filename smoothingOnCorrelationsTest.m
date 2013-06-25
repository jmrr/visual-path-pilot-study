%% SmoothingOnCorrelationsTest

for ix = 1:length(d_q) % for all the positions in a corridor


[distances_all{ix}] = getDistancesBetweenDescriptors(d_db,d_q{ix},0);


end


%% Scaling (converting from Euclidean distances to 'correlation' or RHO
Max =  max(cell2mat(cellfun(@(x) max(x(:)),distances_all,'UniformOutput',0)));

numConsecSamples = 11; % Number of consecutive samples to take 
                       % into account for the quantification of the
                       % similarity.

for ix = 1:length(d_q)
   
    correlations_all{ix} = (-distances_all{ix}+Max)/Max;
    % This smooth provides the equivalent of taking consecutive samples
    smoothed_correlations{ix} = smooth(correlations_all{ix},numConsecSamples);
    

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

% ROC plots (one at a time)
figure;
plot(cs_within,cs_beyond)
hold on
axis tight

%% ROC plots (alltogether)

% Comment out the corresponding instructions, one at a time.
% cs_within_1= cs_within;
% cs_beyond_1 = cs_beyond;
% cs_within_3= cs_within;
% cs_beyond_3 = cs_beyond;
% cs_within_5= cs_within;
% cs_beyond_5 = cs_beyond;
% cs_within_11= cs_within;
% cs_beyond_11 = cs_beyond;

figure;
plot(cs_within_1,cs_beyond_1)
hold on
axis tight
plot(cs_within_3,cs_beyond_3,'r')
plot(cs_within_5,cs_beyond_5,'g')
plot(cs_within_11,cs_beyond_11,'k')


