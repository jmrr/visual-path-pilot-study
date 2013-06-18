parameters

%% Construct db of training descriptors

[d_db,kp_db] = getDescriptorDB(db_path,RESIZE_FACTOR,method);

%%

[d_q,kp_q] = getDescriptorDB(query_path,RESIZE_FACTOR,method);

filename = [datestr(date,'yyyymmdd'),method,corridor];

save(filename,'d_db','kp_db','d_q','kp_q');
%%

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


%% PLOT normalised Distances

figure('Renderer','zbuffer')
plot(Dplots(1,:),'.');
axis tight
set(gca,'NextPlot','replaceChildren');
% Preallocate the struct array for the struct returned by getframe
F(size(Dplots,1)) = struct('cdata',[],'colormap',[]);
% Record the movie
for j = 1:size(Dplots,1)
    %plot(smooth(D(j,:)));
    plot(Dplots(j,:),'.');
    hold on;
    [maxVal,idxmax] = max(Dplots(j,:));
%     plot(idxmax,maxVal,'rs','LineWidth',2,'MarkerFaceColor','g','MarkerSize',10);
    F(j) = getframe;
    hold off;
end

[h, w, p] = size(F(1).cdata);
hf = figure; 
% resize figure based on frame's w x h, and place at (150, 150)
set(hf,'Position', [150 150 w h]);
axis off
% Place frames at bottom left
movie(hf,F,1,2,[0 0 0 0]);

%% PLOT distances

figure('Renderer','zbuffer')
plot(distances(1,:));
axis tight
set(gca,'NextPlot','replaceChildren');
% Preallocate the struct array for the struct returned by getframe
F(size(distances,1)) = struct('cdata',[],'colormap',[]);
% Record the movie
for j = 1:size(distances,1)
    %     plot(smooth(D(j,:)));
    plot(distances(j,:));
    hold on;
%     [maxVal,idxmax] = max(Dplots(j,:));
%     plot(idxmax,maxVal,'rs','LineWidth',2,'MarkerFaceColor','g','MarkerSize',10);
    F(j) = getframe;
    hold off;
end

[h, w, p] = size(F(1).cdata);
hf = figure; 
% resize figure based on frame's w x h, and place at (150, 150)
set(hf,'Position', [150 150 w h]);
axis off
% Place frames at bottom left
movie(hf,F,4,5,[0 0 0 0]);

%% XCORR results

windowLength = 400;
%%

figure('Renderer','zbuffer')
plot(distances(1,:));
axis tight
set(gca,'NextPlot','replaceChildren');
% Preallocate the struct array for the struct returned by getframe
F(size(distances,1)) = struct('cdata',[],'colormap',[]);

H = hamming(windowLength);
% Record the movie
for j = 1:size(distances,1)
    
%     Y = xcorr(H,distances(j,:));
    Y = normxcorr1(H',distances(j,:));
    plot(Y);
    hold on;
    [maxVal,idxmax] = max(Y);
    plot(idxmax,maxVal,'rs','LineWidth',2,'MarkerFaceColor','g','MarkerSize',10);
    F(j) = getframe;
    hold off;

end

[h, w, p] = size(F(1).cdata);
hf = figure; 
% resize figure based on frame's w x h, and place at (150, 150)
set(hf,'Position', [150 150 w h]);
axis off
% Place frames at bottom left
movie(hf,F,20,1,[0 0 0 0]);


%% A moving average case

windowSize = 10;
b = ones(1,windowSize)/windowSize;
a= 1;

span = 20;
figure('Renderer','zbuffer')
plot(Dplots(1,:));
axis tight
set(gca,'NextPlot','replaceChildren');
% Preallocate the struct array for the struct returned by getframe
F(size(distances,1)) = struct('cdata',[],'colormap',[]);
% Record the movie
averagedSignal = zeros(size(distances));
for j = 1:size(distances,1)
    %plot(smooth(D(j,:)));
    averagedSignal(j,:) = filter(b,a,Dplots(j,:));
    plot(averagedSignal(j,:));
    hold on;
    [maxValAV,idxmaxAV] = max(averagedSignal(j,:));
    plot(idxmaxAV,maxValAV,'rs','LineWidth',2,'MarkerFaceColor','g','MarkerSize',10);
    if((idxmaxAV+span<=length(averagedSignal(j,:)))&&(idxmaxAV-span)<1)
        xaxisRed = idxmaxAV-span:idxmaxAV+span;
        plot(xaxisRed,averagedSignal(j,xaxisRed),'r');
    end
    F(j) = getframe;
    hold off;
end

[h, w, p] = size(F(1).cdata);
hf = figure; 
% resize figure based on frame's w x h, and place at (150, 150)
set(hf,'Position', [150 150 w h]);
axis off
% Place frames at bottom left
movie(hf,F,1,2,[0 0 0 0]);
