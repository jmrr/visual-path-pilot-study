%% PARAMETERS

RESIZE_FACTOR = 0.1;
PATCH_SIZE = [100,100];

% Get the database of images

if (isunix)
    path = 'tuning_curves_data/database-video/C2/';
else
    path = 'tuning_curves_data\database\';
end


D = dir(path);

D = D(3:end); % eliminate . and .. 

N_db = size(D,1);

%% Compute database of descriptors

wb = waitbar(0,'Please wait, obtaining database of descriptors...');

try
    for ix = 1:N_db
        
        
        fullName = [path D(ix).name];

        I_db{ix} = imresize(imread(fullName),RESIZE_FACTOR);

        
        img_db = single(rgb2gray(I_db{ix}));
        [f_db{ix},d_db{ix}] = vl_sift(img_db,'PeakThresh',0);
        waitbar(ix/N_db);

    end % end for

catch
    close(wb);
end

close(wb);

