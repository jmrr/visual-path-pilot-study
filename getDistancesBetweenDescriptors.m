function [distances] = getDistancesBetweenDescriptors(d_q,d_db,debug,varargin)

if nargin>3
    ubc_thres = varargin{1};
else
    ubc_thres = 1.5;
end

if(debug)
    wb = waitbar(0,'Generating the metric...');
    % set(wb,'visibility','off')
end

if iscell(d_q) % If more than one training images
    
    N_q = length(d_q);
    
    for ix = 1:N_q
        for ii = 1:length(d_db)    % featureDatabase is a GLOBAL VARIABLE from the database. for each training image
            % match each test image(k) to each training image(i)
            [matches, scores] = vl_ubcmatch(d_q{ix},d_db{ii},ubc_thres);
            % store the training image product id and distance of test and training image keypoints in a structure
            scoreStruct(ii) = struct('distance',scores, 'index', matches); 
            % calculate the average of the descriptor euclidean distance
            distScore (ii) = mean(scores);  
        end
         % find the TRAINING image whose descriptor has minimum distance
         % from the training image descriptor
        [minDist(ix), minIndex(ix)] = min(distScore);
            distancesCell{ix} = distScore;
        
        % Compute mean score or mean distance based on best matching
        % descriptors
        distances = cat(1,distancesCell{:});
        
        if(debug)
            waitbar(ix/N_q);
        end
    end % end for
    
else
    
    for ii = 1:length(d_db) % featureDatabase is a GLOBAL VARIABLE from the database. for each training image
        
        % Use UBCMATCH to match each test image(k) to each training image(i)
        [matches, scores] = vl_ubcmatch(d_q,d_db{ii},ubc_thres);
        % store the training image product id and distance of test and training image keypoints in a structure
        scoreStruct(ii) = struct('distance',scores, 'index', matches);
        % calculate the average of the matching descriptors Euclidean distances
        distScore (ii) = mean(scores);
        if(debug)
            waitbar(ii/length(d_db));
        end
        
    end
    % NOT USED
    % find the TRAINING image whose descriptor has minimum distance
    % from the training image descriptor
    [minDist, minIndex] = min(distScore);
    
    % Compute mean score or mean distance based on best matching
    % descriptors
    distances = distScore;
    
end

if(debug)
    close(wb);
end


end