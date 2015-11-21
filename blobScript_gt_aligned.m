savePath = './saved_data/blob_characterisation/ubcmatch1.5/ground_truth_aligned/';
dataPath = './saved_data/descripor_database/';

for ii = 1:7
    data_file = [dataPath '20130920SIFTC' num2str(ii) '.mat'];
    load(data_file);
    
    
    %% GET THE DESCRIPTORS DISTANCES

    for ix = 1:length(d_q) % for all the QUERY positions in a corridor


    [distances_all{ix}] = getDistancesBetweenDescriptors(d_q{ix},d_db,0,1.5);

    end

    getBlobFromGroundTruth
    
    save_file = [savePath datestr(date,'yyyymmdd') 'ubc1.5' 'blobshapeC' num2str(ii) ' _gtAligned' '.mat'];
    save(save_file);
    clearvars -except savePath dataPath
end
