%% PATHS

data_path = '/media/bg-PictureThis/VISUAL_PATHS';
save_path = '/media/Data/Code/Jose/visual_tuning_curves/saved_data/descripor_database';

if (isunix)
    PATHSEP = '/';
else
    PATHSEP = '\';
end

%% PARAMETERS

RESIZE_FACTOR = 0.1;
PATCH_SIZE = [100,100];


METHOD = 'SIFT'; % 'SURF', 'SIFT'
% Get the database of images

method = METHOD;

corridors = {'C1','C2','C3','C4','C5','C6','C7'};
%'C1','C2','C3','C4',

%%

for ix = 1:length(corridors)

    corridor = corridors{ix};
    
    db_path = [data_path PATHSEP corridor PATHSEP '1-videos/frames' PATHSEP];

    query_path = [data_path PATHSEP corridor PATHSEP '1' PATHSEP];

    %% Construct db of DATABASE descriptors

    [d_db,kp_db] = getDescriptorDB(db_path,RESIZE_FACTOR,method);

    %% Construct db of QUERY descriptors

    [d_q,kp_q] = getDescriptorDB(query_path,RESIZE_FACTOR,method);
    
    %% Get ground-truth
    
    % Query
    gt_path = [data_path PATHSEP corridor PATHSEP 'ground-truth' PATHSEP];
    
    if (isdir(gt_path))
        gt_q_file = [gt_path corridor '_1_q.csv'];
        fid = fopen(gt_q_file);
        gt_q = cell2mat(textscan(fid,'%d'));    % Query ground truth in cm
        fclose(fid);
        % Db

        gt_db_file = [gt_path corridor '_1_db.csv'];
        fid = fopen(gt_db_file);
        gt_db = cell2mat(textscan(fid,'%d'));    % Query ground truth in cm
        fclose(fid);
    end % if ground truth exists
    
    %% Save 
    
    filename = [save_path PATHSEP datestr(date,'yyyymmdd'),method,corridor];

    save(filename,'d_db','kp_db','d_q','kp_q','gt_q','gt_db','RESIZE_FACTOR');

    clear d_db k_db d_q kp_q
end

