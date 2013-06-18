function [pdf] = getPDFfromDistanceMetric(Dplots,Nbins)

    x = linspace(0,1,Nbins);
    n = hist(Dplots(:),x);
    pdf = n/sum(n);

end % end getPDFfromDistancemetric