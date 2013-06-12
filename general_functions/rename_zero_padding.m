D = dir;

D = D(3:end); % eliminate . and .. 

for ix = 1:length(D)
   
    
    imgName = D(ix).name;
    movefile(imgName,[num2str(ix,'%04d') '.jpg']);
    
end
