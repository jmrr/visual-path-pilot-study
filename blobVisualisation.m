%% visualisation
path = 'saved_data/blob_characterisation/ubcmatch1.5';
D = dir(path);

D= D(3:end);

%%
for d = 1:length(D)
%     load([path '/' D(d).name]);
    for ii = 1:28
    plot(blobs{ii})
    hold on
    blob_array(ii,:) = blobs{ii};
    end
    
end

%%
% close all
% clear all

% figure
for ii = 1:28
    
%     plot(blobs{ii})
%     hold on
    if(size(blobs{ii},1)<size(blobs{ii}))
        blob_array(ii,:) = blobs{ii};
    else
        blob_array(ii,:) = blobs{ii}';
    end
%     pause
end

%% mean and std

mean_blob = nanmean(blob_array,1);
figure,
plot(mean_blob)

std_blob = nanstd(blob_array,0,1);
figure
plot(std_blob)

figure
plotStdOverMean(mean_blob,std_blob,'b','-','r','-',0.2)
