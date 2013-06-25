%% 1. Get all the descriptors:

% 1.1 Set the parameters: path, resize factor and feature extraction
% method.

parameters

%% Construct db of DATABASE descriptors

[d_db,kp_db] = getDescriptorDB(db_path,RESIZE_FACTOR,method);

%% Construct db of QUERY descriptors

[d_q,kp_q] = getDescriptorDB(query_path,RESIZE_FACTOR,method);


%% 2. Obtain the correlation measure:

% 2.1 Smoothing the correlations first: i.e. getting all the distances for
% all the possible query-db combination, computing the correlation metric
% and smoothing with a sliding average of N points. After this, select the
% 'within' and 'beyond' intervals from the correlations structure in order
% to obtain the distributions.

% (Make sure GROUND TRUTH in same units)
% Set the 'points' of the moving average

SmoothingOnCorrelationsTest

% Plots: 
% a) Within - beyond pdf distributions
% b) ROC curves: plot(cumsum_within,cumsum_beyond)


% 2.2 Calculation of the 'within' and 'beyond' intervals first and then
% compute the (distances) correlation values prior to quantify the
% distribution of the values:

correlationThresholdTest

% Plots: 
% a) % of correlation values (rho) passing a threshold (WITHIN case, with variation
% between 1 sample and 2 samples)
% b) % of correlations values (rho) passing a threshold (BEYOND case, with variation
% between 1 sample and 2 samples)
% c-d) % of correlation values (rho) passing a threshold (within vs beyond,
% taking 1 sample at a time (c) or two consecutive values passing the
% threshold (d)


