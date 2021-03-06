%% Two parameter (k,T) variability

T = 0:0.05:0.9;

K = 10;

N = 1000;

clear f_rho_within
% Within

MaxNumberOfCorrValues_surrounding = max(cellfun(@(x) length(x),correlations_surrounding));

for ii = 1:length(T)
    
    
    
    for k = 0:K-1
        valid_within_prev = zeros(1,N);
        values_that_pass_thres = [];
        for jj = 1:N

            rnd_idx = randi(length(correlations_surrounding),1);
            
            values_that_pass_thres = correlations_surrounding{rnd_idx}(:)>T(ii);

            % Take central value
            
            L = length(correlations_surrounding{rnd_idx});
            m = ceil(L/2); % central location
            
            central_loc_value = values_that_pass_thres(m);
            % Count of correlations samples above a threshold T
%             valid_within(k,jj) = sum(values_that_pass_thres); 


            % Count of the correlations values that pass a threshold TOGETHER 
            % with its previous sample(s)
             
            valid_within_prev(jj) = sum([values_that_pass_thres(k+1:end); zeros(k,1)] & ...
                values_that_pass_thres);
        end % end for N number of random picks at the different queries.

    f_rho_within(ii,k+1) = sum(valid_within_prev)/(N*MaxNumberOfCorrValues_surrounding);


    end % end for K
%     sum1_within(ii) = sum(valid_within)/(N*size(cat(2,correlations_surrounding{:}),2));
%     sum2_within(ii) = sum(valid_within_prev)/(N*size(cat(2,correlations_surrounding{:}),2));
   
end % end for T threshold

%% Between

MaxNumberOfCorrValues_beyond = max(cellfun(@(x) length(x),correlations_beyond));

for ii = 1:length(T)
    
    valid_beyond_prev = zeros(K,N);

    for k = 0:K-1
        
        for jj = 1:N

            rnd_idx = randi(length(correlations_beyond),1);

            values_that_pass_thres = correlations_beyond{rnd_idx}(:)>T(ii);

            % Take central value
            
            L = length(correlations_beyond{rnd_idx});
            m = ceil(L/2); % central location
            
            central_loc_value = values_that_pass_thres(m);
            % Count of correlations samples above a threshold T
%             valid_within(k,jj) = sum(values_that_pass_thres); 


            % Count of the correlations values that pass a threshold TOGETHER 
            % with its previous sample(s)
             
            valid_beyond_prev(k+1,jj) = sum([values_that_pass_thres(k+1:end); zeros(k,1)] & ...
                values_that_pass_thres);
        end % end for N number of random picks at the different queries.

    f_rho_between(ii,k+1) = sum(valid_beyond_prev(k+1,:))/(N*MaxNumberOfCorrValues_beyond);

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

figure
[X,Y] = meshgrid(0:K-1,T);
colormap summer
hSurface = surf(X,Y,f_rho_within);
set(hSurface,'FaceColor',[0 0 1],'FaceAlpha',0.5);

% title('within')
hold on
hSurface2 = surf(X,Y,f_rho_between);
set(hSurface2,'FaceColor',[1 0 0],'FaceAlpha',0.5);
% title('between');
