    surrounding = 50;
    gap = 800;
for ix = 1:length(d_q_C1) % for all the positions in a corridor

    central_point = gt_q(ix); % Get ground truth position of the QUERY
    %% Surrounding locations
    % Get the closest SURROUNDING positions from the DATABASE
    [idx_surr_min,idx_surr_central(ix),idx_surr_max] = ...
        getDBindicesOfSurroundingQueries(central_point,surrounding,gt_db);
    
    % Get the descriptor corresponding to DATABASE images at those locations
    idx_surrounding = idx_min:idx_max;
    d_db_surrounding = d_db_C1(idx_surrounding);
    
    %% 'Far' locations
    % Get the FAR positions from the DATABASE
    [idx_far_min,idx_far_central(ix),idx_far_max] = ...
        getDBindicesOfSurroundingQueries(central_point,gap,gt_db);
    
    % Get the descriptor corresponding to DATABASE images at those FAR locations
    idx_all = 1:length(d_db_C1);
    idx_far = setdiff(idx_all,idx_surrounding);
    d_db_surrounding = d_db_C1(idx_surrounding);
   
    if (idx_max+gap)<length(d_db_C1)&&(idx_min+gap)<length(d_db_C1)
        d_db_selection_far = d_db_C1(idx_selection+gap);
    elseif (idx_max+gap)>length(d_db_C1) && (idx_min+gap)<length(d_db_C1)
        d_db_selection_far = d_db_C1(idx_min+gap:end);
    end
    [distances{ix}] = getDistancesBetweenDescriptors(d_db_surrounding,d_q_C1{ix},0);
    [distances_w_gap{ix}] = getDistancesBetweenDescriptors(d_db_selection_far,d_q_C1{ix},0);


    
end

%%
Max1 =  max(cell2mat(cellfun(@(x) max(x(:)),distances,'UniformOutput',0)));
Max2 =  max(cell2mat(cellfun(@(x) max(x(:)),distances_w_gap(2:end),'UniformOutput',0)));

Max = max([Max1,Max2]);

windowSize = 3;
b = ones(1,windowSize)/windowSize;
a= 1;


for ix = 2:length(d_q_C1)
   

    correlations{ix} = (-distances{ix}+Max)/Max;
%     avg_correlation = filter(b,a,correlations{ix});
%     plot(avg_correlation,'.')
%     hold on;
%     pause
%     corr_mat(ix-1,:) = correlations{ix};
    
end

for ix = 2:length(distances_w_gap)
   

   correlations_w_gap{ix} = (-distances_w_gap{ix}+Max)/Max;
%     avg_correlation = filter(b,a,correlations{ix});
%     plot(avg_correlation,'.')
%     hold on;
%     pause
%     corr_mat(ix-1,:) = correlations{ix};
    
end

c = correlations(2:end);
corr_mat = cat(2,c{:});

c2 = correlations_w_gap(2:end);
corr_mat_w_gap = cat(2,c2{:});

%% Plots
figure
x = linspace(0,1,100);
[n,x] = hist(corr_mat,x);
pdf = n/sum(n);
smoothed_pdf = smooth(smooth(pdf));
plot(x,smoothed_pdf)
hold on

[n2,x] = hist(corr_mat_w_gap,x);
pdf_w_gap = n2/sum(n2);
s = smooth(pdf_w_gap);
s1 = smooth(s);
plot(x,s1,'y')
% plot(x,pdf_w_gap,'r')
titleName = ['surrounding descriptors ' num2str(surrounding) 'cm; gap = ' num2str(gap) 'cm'];
title(titleName);

%%

save(titleName);