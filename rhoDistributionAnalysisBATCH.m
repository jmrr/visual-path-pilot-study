%% Load files and save necessary variables
path = './saved_data/surrounding_descriptors_analysis/';
D = dir(path);
D = D(3:end);

for ii = 1:length(D)
   load([path D(ii).name]);
   corr_mat_w_gapCell{ii} = corr_mat_w_gap;
   clearvars -except  -regexp corr_mat* D path;
end
clear corr_mat_w_gap100;




%%


%Define T
T = 0.1:0.01:0.9;
Nbins = 50;
binCentres = 1/(2*Nbins):1/Nbins:1-1/(2*Nbins);

numExperiments = length(corr_mat_w_gapCell);

pdfAll = zeros(length(T),Nbins,numExperiments);
[X,Y] = meshgrid(binCentres,T);
for ii = 1:numExperiments
    
    pdfAll(:,:,ii) = getPDFdistributionWithT(corr_mat_w_gapCell{ii},binCentres,T,1);
    surfl(X,Y,pdfAll(:,:,ii));
    hold on
    
end % end for loop
xlabel('T (threshold of values of \rho)')
ylabel('\rho')
zlabel('f_\rho')
