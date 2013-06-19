    surrounding = 50;
    gap = 300;
for ix = 2:length(d_q_C1)

    central_point = gt_q(ix);
    min_val = central_point-surrounding;
    max_val = central_point+surrounding;
    
    tmp = abs(gt_db-min_val);
    [m,idx_min] = min(tmp);
    
    tmp = abs(gt_db - max_val);
    [ma,idx_max] = min(tmp);
    
    tmp = abs(gt_db - central_point);
    
    [mc,idx_central(ix)] = min(tmp);
    
    idx_selection = idx_min:idx_max;
    d_db_selection = d_db_C1(idx_selection);
    if (idx_max+gap)<length(d_db_C1)&&(idx_min+gap)<length(d_db_C1)
        d_db_selection_far = d_db_C1(idx_selection+gap);
    elseif (idx_max+gap)>length(d_db_C1) && (idx_min+gap)<length(d_db_C1)
        d_db_selection_far = d_db_C1(idx_min+gap:end);
    end
    [distances{ix}] = getDistancesBetweenDescriptors(d_db_selection,d_q_C1{ix});
    [distances_w_gap{ix}] = getDistancesBetweenDescriptors(d_db_selection_far,d_q_C1{ix});


    
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