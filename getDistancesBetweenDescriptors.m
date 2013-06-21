function [distances] = getDBindicesOfSurroundingQueries(d_db,d_q,debug)

if(debug)
    wb = waitbar(0,'Generating the metric...');
% set(wb,'visibility','off')
end
if iscell(d_q) 
    
N_q = length(d_q);

    for ix = 1:N_q

            for ii = 1:length(d_db)                   % featureDatabase is a GLOBAL VARIABLE from the database. for each training image
            [matches, scores] = vl_ubcmatch(d_db{ii}, d_q{ix});      % match each test image(k) to each training image(i)
    %             if (length(scores) > 10)                                                        % if matched SIFT keypoints are greater than 10
                    scoreStruct(ii) = struct('distance',scores, 'index', matches); % store the training image product id and distance of test and training image keypoints in a structure
                    distScore (ii) = mean(scores);                                                    % calculate the average of the descriptor euclidean distance
    %             else
    %                 scoreStruct(ii) = struct('distance',NaN, 'index', NaN);
    %                 dist (ii) = NaN;                                                             % else discard that training image as a possible match
    %             end
            end
        [minDist(ix), minIndex(ix)] = min(distScore); % find the TRAINING image whose descriptor 
                                        ... has minimum distance from the training 
                                            ... image descriptor
        distancesCell{ix} = distScore;
        
        distances = cat(1,distancesCell{:});
        if(debug)
            waitbar(ix/N_q);
        end
    end % end for
else 
    
    for ii = 1:length(d_db)                   % featureDatabase is a GLOBAL VARIABLE from the database. for each training image
    [matches, scores] = vl_ubcmatch(d_db{ii}, d_q);      % match each test image(k) to each training image(i)
            scoreStruct(ii) = struct('distance',scores, 'index', matches); % store the training image product id and distance of test and training image keypoints in a structure
            distScore (ii) = mean(scores);                                                    % calculate the average of the descriptor euclidean distance
            if(debug)
                waitbar(ii/length(d_db));
            end
    end
    [minDist, minIndex] = min(distScore); % find the TRAINING image whose descriptor 
                                    ... has minimum distance from the training 
                                        ... image descriptor
    distances = distScore;
end

if(debug)
    close(wb);
end


end