function [idx_min,idx_central,idx_max] = ...
    getDBindicesOfSurroundingQueries(central_point,surrounding,gt_db)

    min_val = central_point-surrounding;
    max_val = central_point+surrounding;
    
    tmp = abs(gt_db-min_val);
    [~,idx_min] = min(tmp);
    
    tmp = abs(gt_db - max_val);
    [~,idx_max] = min(tmp);
    
    tmp = abs(gt_db - central_point);
    
    [~,idx_central] = min(tmp);
 
end