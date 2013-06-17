function [descriptors,keypoints] = getDescriptorDB(path,RESIZE_FACTOR,method)

D = dir(path);

D = D(3:end); % eliminate . and .. 

N_db = size(D,1);

%% Compute database of descriptors

wb = waitbar(0,'Please wait, obtaining database of descriptors...');

try
    for ix = 1:N_db
        
        
        fullName = [path D(ix).name];

        I_db{ix} = imresize(imread(fullName),RESIZE_FACTOR);

        
        img_db = rgb2gray(I_db{ix});
        
        switch method
            case 'SIFT'
                img_db = single(img_db);
                points = [];
                [descriptors{ix},keypoints{ix}] = extractFeatures_gen(img_db,points,'Method',method);
            case 'SURF'
                points = detectSURFFeatures(img_db);
                [descriptors{ix},keypoints{ix}] = extractFeatures_gen(img_db,points,'Method',method);
            otherwise
                disp('Unknown method.');
                
        end
                waitbar(ix/N_db);

    end % end for

catch
    close(wb);
end

close(wb);

end % end function