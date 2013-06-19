function [pdf,x] = getPDFfromMetric(metric,Nbins)

    x = linspace(0,1,Nbins);
    n = hist(metric(:),x);
    pdf = n/sum(n);

end % end getPDFfromDistancemetric