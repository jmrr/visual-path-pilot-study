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


for ii = 1:28
    figure
    plot(blobs{ii})
    hold on
    blob_array(ii,:) = blobs{ii};
end