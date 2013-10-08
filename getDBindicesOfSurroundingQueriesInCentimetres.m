function [idx_min,idx_max] = ...
    getDBindicesOfSurroundingQueriesInCentimetres(central_point,surrounding,gt_db)

    min_val = central_point-surrounding;
    if(min_val<0)
        min_val = 0;
    end
    max_val = central_point+surrounding;
    
    tmp = abs(gt_db-min_val);
    [~,idx_min] = min(tmp);
    
    tmp = abs(gt_db - max_val);
    [~,idx_max] = min(tmp);

%% Revise: something is not right here
%
%     tmp = abs(gt_db - central_point);
%     
%     [~,idx_central] = min(tmp);
 
end