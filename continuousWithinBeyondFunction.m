%% continuousWithinBeyondFunction Test

for ix = 1:length(d_q) % for all the positions in a corridor
    

[distances_all{ix}] = getDistancesBetweenDescriptors(d_q{ix},d_db,0,3);


end


%% Scaling (converting from Euclidean distances to 'correlation' or RHO
Max =  max(cell2mat(cellfun(@(x) max(x(:)),distances_all,'UniformOutput',0)));

% Eliminate NaNs

for jj = 1:length(distances_all)
    distances_all{jj}(isnan(distances_all{jj})) = Max;
end

numConsecSamples = 1; % Number of consecutive samples to take 
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

N = 10; % Level of randomization

wb = waitbar(0,'Please wait, obtaining correlations value...');

for ix = 1:1:N % for N random experiments

    rnd_idx = randi(length(gt_q),1);
    central_point = gt_q(rnd_idx); % Get ground truth position of the QUERY
    S = 3000; % S is the span of surrounding locations from which to calculate the values

    %for s = 1:1:gt_q(end)-50
    for s = 1:1:S
        
        surrounding = (s-1)+50; % 

        %% Surrounding locations
        % Get the closest SURROUNDING positions from the DATABASE
        [idx_surr_min,~,idx_surr_max] = ...
            getDBindicesOfSurroundingQueries(central_point,surrounding,gt_db);

        % Get the smoothed correlation values corresponding to DATABASE images at those locations
        idx_surrounding = idx_surr_min:idx_surr_max;

        values_within{ix}{s} = smoothed_correlations{rnd_idx}(idx_surrounding);

        %% 'Far' locations

        % Get the descriptor corresponding to DATABASE images at those FAR locations
        idx_all = 1:length(d_db);
        idx_beyond = setdiff(idx_all,idx_surrounding);

        values_beyond{ix}{s} = smoothed_correlations{rnd_idx}(idx_beyond);
        
        %% Within-beyond distributions (PDFs)
        
        [n_within,~] = hist(values_within{ix}{s},x);
        pdf_within{ix}{s}  = n_within/sum(n_within);
        
        [n_beyond] = hist(values_beyond{ix}{s},x);
        pdf_beyond{ix}{s} = n_beyond/sum(n_beyond);
        
        a = double(s);
        b = double(S);
        waitbar(a/b);

    end

end
close(wb)

%%

% PLOTS: 
% 
% figure
% plot(x,smooth(smooth(pdf_within)));
% hold on
% plot(x,smooth(smooth(pdf_beyond)),'r');



%% Plots

N_hist = length(pdf_within);
within = zeros(N_hist,S,100);
beyond = zeros(size(within));

for ix = 1:N_hist

    within(ix,:,:) = cell2mat(cat(1,pdf_within{ix}(:)));
    beyond(ix,:,:) = cell2mat(cat(1,pdf_beyond{ix}(:)));
    
end

%%
x = linspace(0,1,100);
y = 0:0.01:30-0.01;

figure
Z_within = squeeze(mean(within,1));

mesh(x,y,Z_within);

figure
Z_beyond = squeeze(mean(beyond,1));

mesh(x,y,Z_beyond);