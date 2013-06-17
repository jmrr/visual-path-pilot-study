function [Dplots,distances] = getNormalisedDistancesBetweenDescriptors(d_db,d_q)


N_q = length(d_q);

wb = waitbar(0,'Generating the metric...');

for ix = 1:N_q
  
        for ii = 1:length(kp_db)                   % featureDatabase is a GLOBAL VARIABLE from the database. for each training image
        [matches, scores] = vl_ubcmatch(d_db{ii}, d_q{ix});      % match each test image(k) to each training image(i)
%             if (length(scores) > 10)                                                        % if matched SIFT keypoints are greater than 10
                scoreStruct(ii) = struct('distance',scores, 'index', matches); % store the training image product id and distance of test and training image keypoints in a structure
                dist (ii) = mean(scores);                                                    % calculate the average of the descriptor euclidean distance
%             else
%                 scoreStruct(ii) = struct('distance',NaN, 'index', NaN);
%                 dist (ii) = NaN;                                                             % else discard that training image as a possible match
%             end
        end
    [minDist(ix), minIndex(ix)] = min(dist); % find the TRAINING image whose descriptor 
                                    ... has minimum distance from the training 
                                        ... image descriptor
    distancesCell{ix} = dist;
    
    waitbar(ix/N_q);
   
end % end for

distances = cat(1,distancesCell{:});

% Normalise the distances
% d' = (-d+dmax)/dmax

M = max(max(distances));

Dplots = (-distances+M)/M;

distances(isnan(distances)) = M;

close(wb);


end