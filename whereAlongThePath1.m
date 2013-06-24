T = 0:0.1:0.9;

% Within
for ii = 1:length(T)
    
    aux_within = zeros(1,1000);
    for ix = 1:1000
        rnd_idx = randi(28,1);
        values_that_pass_thres = corr_with_indices_within(rnd_idx,:)>T(ii);
        aux_within(ix) = sum(values_that_pass_thres);
        aux_within_prev(ix) = sum([values_that_pass_thres(3:end) 0 0] & ...
            values_that_pass_thres);
    end 
    sum1_within(ii) = sum(aux_within)/(1000*size(corr_with_indices_within,2));
    sum2_within(ii) = sum(aux_within_prev)/(1000*size(corr_with_indices_within,2));

    
end

% figure
% plot(T,sum1_within)
% hold on
% plot(T,sum2_within,'r')
% title('within')

% Between

for ii = 1:length(T)
    
    aux_between = zeros(1,1000);
    for ix = 1:1000
        rnd_idx = randi(28,1);
        values_that_pass_thres = corr_with_indices_between(rnd_idx,:)>T(ii);
        aux_between(ix) = sum(values_that_pass_thres);
            aux_within_prev_between(ix) = sum([values_that_pass_thres(3:end) 0 0] & ...
            values_that_pass_thres);
    end 

    sum1_between(ii) = sum(aux_between)/(1000*size(corr_with_indices_between,2));

    sum2_between(ii) = sum(aux_within_prev_between)/(1000*size(corr_with_indices_between,2));
end

%%


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
