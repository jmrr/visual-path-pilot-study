function [ y ] = normxcorr1( template,x )

%UNTITLED Summary of this function goes here

%   Detailed explanation goes here

halflength = round(length(template)/2);

y = normxcorr2(template,x);

y = y(halflength:end-halflength);

end

 