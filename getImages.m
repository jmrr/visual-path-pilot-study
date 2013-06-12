function [I] = getImages(path,resizeFactor)

D = dir(path);

D = D(3:end); % eliminate . and .. 

if (size(D,1) > 1)
    
    I = cell(size(D));

        for ix = 1:length(D)

            fullName = [path D(ix).name];

            I{ix} = imresize(imread(fullName),resizeFactor);

        end % end for
else
    
    fullName = [path D(1).name];
    I = imresize(imread(fullName),resizeFactor);
    
end % end if


end % end function