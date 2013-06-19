function [stats_pdf] = getStatsForShadedPlot(pdf,indices,varargin)

%GETBOUNDARIESFORSHADEDPLOT Computes Min-Max or Std and mean stats for
%shaded plot from a cell array of probability density functions (PDFs).
%   Inputs:
%       -pdf: cell array with the pdfs.
%       -Indices: indices of interest from the pdf cell array, e.g. those
%       corresponding to the comparison between different corridors.
%       -TYPE: (optional) string that specifies which type of boundaries are desired,
%              the default is 'std', 'MAXMIN' for max-min boundaries.
%  
%   Outputs:
%

% Parse optional variable inputs:

if isempty(varargin) 
    TYPE = 'std';
else
    TYPE = varargin{1};
end

% Convert pdf cell array 
comb_pdf = cat(1,pdf{indices});

% Calculate mean and declare output
mean_pdf = mean(comb_pdf,1);
stats_pdf = mean_pdf;

    
if strcmpi(TYPE,'MAXMIN')
    max_val = max(comb_pdf,[],1);
    min_val = min(comb_pdf,[],1);
    stats_pdf(2,:) = max_val;
    stats_pdf(3,:) = min_val;
else
    std_pdf = std(comb_pdf,0,1);
    stats_pdf(2,:) = std_pdf;
end
    

end % end function