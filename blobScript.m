savePath = './saved_data/blob_characterisation/';
dataPath = './saved_data/descripor_database/';

for ii = 2:7
    data_file = [dataPath '20130920SIFTC' num2str(ii) '.mat'];
    load(data_file);
    extractTuningCurveShape
    save_file = [savePath datestr(date,'yyyymmdd') 'ubc1.5' 'blobshapeC' num2str(ii) '.mat'];
    save(save_file,'blobs');
end


