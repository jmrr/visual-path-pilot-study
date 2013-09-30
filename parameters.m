%% PARAMETERS

RESIZE_FACTOR = 0.1;
PATCH_SIZE = [100,100];


METHOD = 'SIFT'; % 'SURF', 'SIFT'
% Get the database of images

method = METHOD;

corridor = 'C6';



%%

if (isunix)
    PATHSEP = '/';
else
    PATHSEP = '\';
end

db_path = ['tuning_curves_data' PATHSEP 'database-video' PATHSEP corridor PATHSEP];

query_path = ['tuning_curves_data' PATHSEP 'query' PATHSEP corridor PATHSEP];

