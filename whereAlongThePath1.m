surrounding = 50;

[correlations_surrounding,correlations_beyond] = getCorrelations(surrounding,gt_q,gt_db,d_q,d_db);
%%


corr_mat_surr = cat(2,correlations_surrounding{:});

corr_mat_gap = cat(2,correlations_gap{:});



%%

T = 0:0.1:0.9;

N = 1000;

% Within
for ii = 1:length(T)
    
    valid_within = zeros(1,N);
    for ix = 1:N
        rnd_idx = randi(28,1);
%         values_that_pass_thres = corr_with_indices_within(rnd_idx,:)>T(ii);
        values_that_pass_thres = correlations_surrounding{rnd_idx}(:)>T(ii);
        
        % Count of correlations samples above a threshold T
        valid_within(ix) = sum(values_that_pass_thres); 
        
        % Count of the correlations values that pass a threshold TOGETHER 
        % with its previous sample(s)
        % 
        valid_within_prev(ix) = sum([values_that_pass_thres(2:end); 0] & ...
            values_that_pass_thres);
    end 
    sum1_within(ii) = sum(valid_within)/(N*size(cat(2,correlations_surrounding{:}),2));
    sum2_within(ii) = sum(valid_within_prev)/(N*size(cat(2,correlations_surrounding{:}),2));

    
end

%%
figure
plot(T,sum1_within)
hold on
plot(T,sum2_within,'r')
title('within')
%%
% Between


for ii = 1:length(T)
    
    aux_between = zeros(1,N);
    for ix = 1:N
        rnd_idx = randi(28,1);
%         values_that_pass_thres = corr_with_indices_within(rnd_idx,:)>T(ii);
        values_that_pass_thres = correlations_gap{rnd_idx}(:)>T(ii);

        aux_between(ix) = sum(values_that_pass_thres);
        aux_within_prev_between(ix) = sum([values_that_pass_thres(2:end); 0] & ...
            values_that_pass_thres);
    end 
    sum1_between(ii) = sum(aux_between)/(N*size(cat(2,correlations_gap{:}),2));
    sum2_between(ii) = sum(aux_within_prev_between)/(N*size(cat(2,correlations_gap{:}),2));

    
end
%%

figure
plot(T,sum1_between)
hold on
plot(T,sum2_between,'r')
title('consecutive samples')


%% Combined plots


figure
plot(T,sum1_within)
hold on
plot(T,sum1_between,'r')
title('1 sample')

figure
plot(T,sum2_within)
hold on
plot(T,sum2_between,'r')
title('consecutive samples')
