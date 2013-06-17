function [features,keypoints] = extractFeatures_gen(I,points,Name,Value)

    if strcmpi(Name,'method') && strcmpi(Value,'SIFT')
        [keypoints, features] = vl_sift(I,'PeakThresh',0);
    else
        
        [features,keypoints] = extractFeatures(I,points,Name,Value);
        features = features';
    end

end % end function