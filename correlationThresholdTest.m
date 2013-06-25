% Specify how many centimetres behind and beyond the central point of the
% query we'd like to take database images from.

surrounding = 50;

% Get the correlations (transformed distances) at those given distances

[correlations_surrounding,correlations_beyond] = getCorrelationsNearQueryPositions(surrounding,gt_q,gt_db,d_q,d_db);

% Convert to matrices

corr_mat_surr = cat(2,correlations_surrounding{:});

corr_mat_beyond = cat(2,correlations_beyond{:});



%% Threshold (T) and number of randomization items (N)

T = 0:0.1:0.9;

N = 1000;

%% Within

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
%     sum1_within(ii) = sum(valid_within)/(N*size(cat(2,correlations_surrounding{:}),2));
%     sum2_within(ii) = sum(valid_within_prev)/(N*size(cat(2,correlations_surrounding{:}),2));
      
      sum1_within(ii) = sum(valid_within)/(N*length(correlations_surrounding{rnd_idx}));  
      sum2_within(ii) = sum(valid_within_prev)/(N*length(correlations_surrounding{rnd_idx}));  
end

%%
figure
plot(T,sum1_within)
hold on
plot(T,sum2_within,'r')
title('within')
legend('1 sample','2 consecutive samples');


%% beyond


for ii = 1:length(T)
    
    aux_beyond = zeros(1,N);
    for ix = 1:N
        rnd_idx = randi(28,1);
%         values_that_pass_thres = corr_with_indices_within(rnd_idx,:)>T(ii);
        values_that_pass_thres = correlations_beyond{rnd_idx}(:)>T(ii);

        aux_beyond(ix) = sum(values_that_pass_thres);
        aux_within_prev_beyond(ix) = sum([values_that_pass_thres(2:end); 0] & ...
            values_that_pass_thres);
    end 
%     sum1_beyond(ii) = sum(aux_beyond)/(N*size(cat(2,correlations_beyond{:}),2));
%     sum2_beyond(ii) = sum(aux_within_prev_beyond)/(N*size(cat(2,correlations_beyond{:}),2));
    sum1_beyond(ii) = sum(aux_beyond)/(N*length(correlations_beyond{rnd_idx}));
    sum2_beyond(ii) = sum(aux_within_prev_beyond)/(N*length(correlations_beyond{rnd_idx}));
end
%%

figure
plot(T,sum1_beyond)
hold on
plot(T,sum2_beyond,'r')
title('beyond')
legend('1 sample','2 consecutive samples');

%% Combined plots

figure
plot(T,sum1_within)
hold on
plot(T,sum1_beyond,'r')
title('1 sample')

figure
plot(T,sum2_within)
hold on
plot(T,sum2_beyond,'r')
title('consecutive samples')
legend('within','beyond');
