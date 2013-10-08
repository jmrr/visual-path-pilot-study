function [idx_min,idx_central,idx_max] ...
    = getDBindicesOfSurroundingQueries(central_point,surrounding,gt_db)

    tmp = abs(gt_db - central_point);
    
    [~,idx_central] = min(tmp);
    
    
    if idx_central-surrounding <= 0   
        
        idx_min = 1;
        idx_max = idx_central+surrounding-1;

    elseif idx_central+surrounding >= length(gt_db)
        idx_max = length(gt_db);
        idx_min = idx_central-(surrounding+1);

    else
        
        idx_min = idx_central-surrounding;
        idx_max = idx_central+surrounding-1;
        
    end

end