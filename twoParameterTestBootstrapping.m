%% Two parameter (k,T) variability

T = 0.65:0.05:0.9;

K = 20;

N = 1000;

clear f_rho_within
% Within

MaxNumberOfCorrValues_surrounding = max(cellfun(@(x) length(x),correlations_surrounding));

for ii = 1:length(T)

    for k = 0:K-1
        valid_within_prev = zeros(1,N);
        values_that_pass_thres = [];

        for jj = 1:N

            wb = waitbar(0,'Please wait, obtaining rho values...');

            rnd_idx = randi(length(correlations_surrounding),1);
            
            rnd_corr = correlations_surrounding{rnd_idx};
            
            values_that_pass_thres = rnd_corr(:)>T(ii);

            rnd_idx2 = randi(length(rnd_corr));
             
            % Count of the correlations values that pass a threshold TOGETHER 
            % with its previous sample(s)
             
%             valid_within_prev(jj) = sum([values_that_pass_thres(k+1:end); zeros(k,1)] & ...
%                 values_that_pass_thres);
            if (rnd_idx2-k)<1
                valid_within_prev(jj) = sum(values_that_pass_thres(1:rnd_idx2));
            elseif (rnd_idx2+k)>length(values_that_pass_thres)
                valid_within_prev(jj) = sum(values_that_pass_thres(rnd_idx2:end));
            else
                valid_within_prev(jj) = sum(values_that_pass_thres(rnd_idx2-k:rnd_idx2+k));
            end
            
        end % end for N number of random picks at the different queries.
    
    f_rho_within(ii,k+1) = sum(valid_within_prev)/(N*2*K);


    end % end for K
%     sum1_within(ii) = sum(valid_within)/(N*size(cat(2,correlations_surrounding{:}),2));
%     sum2_within(ii) = sum(valid_within_prev)/(N*size(cat(2,correlations_surrounding{:}),2));
   
end % end for T threshold

%% Between

MaxNumberOfCorrValues_beyond = max(cellfun(@(x) length(x),correlations_beyond));

clear f_rho_between


for ii = 1:length(T)
    
    valid_beyond_prev = zeros(1,N);
    values_that_pass_thres = [];

    for k = 0:K-1
        
        for jj = 1:N

            rnd_idx = randi(length(correlations_beyond),1);

            rnd_corr = correlations_beyond{rnd_idx};
            
            values_that_pass_thres = rnd_corr(:)>T(ii);

            rnd_idx2 = randi(length(rnd_corr));
             
            % Count of the correlations values that pass a threshold TOGETHER 
            % with its previous sample(s)
             
%             valid_within_prev(jj) = sum([values_that_pass_thres(k+1:end); zeros(k,1)] & ...
%                 values_that_pass_thres);
            if (rnd_idx2-k)<1
                valid_beyond_prev(jj) = sum(values_that_pass_thres(1:rnd_idx2));
            elseif (rnd_idx2+k)>length(values_that_pass_thres)
                valid_beyond_prev(jj) = sum(values_that_pass_thres(rnd_idx2:end));
            else
                valid_beyond_prev(jj) = sum(values_that_pass_thres(rnd_idx2-k:rnd_idx2+k));
            end
            
        end % end for N number of random picks at the different queries.

    f_rho_between(ii,k+1) = sum(valid_beyond_prev)/(N*2*K);

    end % end for K
%     sum1_within(ii) = sum(valid_within)/(N*size(cat(2,correlations_surrounding{:}),2));
%     sum2_within(ii) = sum(valid_within_prev)/(N*size(cat(2,correlations_surrounding{:}),2));
   
end % end for T threshold

%% Plots 

%% Separate 

figure
[X,Y] = meshgrid(0:K-1,T);
surf(X,Y,f_rho_within)
title('within')
figure
surf(X,Y,f_rho_between)
title('between');

%% Overlaying both
li
figure
[X,Y] = meshgrid(0:K-1,T);
colormap summer
hSurface = surf(X,Y,f_rho_within);
set(hSurface,'FaceColor',[0 0 1],'FaceAlpha',0.5);

hold on
hSurface2 = surf(X,Y,f_rho_between);
set(hSurface2,'FaceColor',[1 0 0],'FaceAlpha',0.5);
axis tight

ylabel('T')
xlabel('K')
legend('within','beyond')
zlabel('f_\rho')
title('% of values of \rho exceeding a threshold T given number of consecutive samples K')