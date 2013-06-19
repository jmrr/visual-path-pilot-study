% SEQUENCE

% within

% C1

load '20130617SIFTC1.mat'


d_db_C1 = d_db; 
d_q_C1 = d_q;

[distancesC1within] = getDistancesBetweenDescriptors(d_db_C1,d_q_C1);

% clearvars -except d_db_C1 d_q_C1 pdfC1within

%% C2

load '20130617SIFTC2.mat'


d_db_C2 = d_db; 
d_q_C2 = d_q; 

[distancesC2within] = getDistancesBetweenDescriptors(d_db_C2,d_q_C2);


%% C10

load '20130617SIFTC10.mat'

d_db_C10 = d_db; 
d_q_C10 = d_q; 

[distancesC10within] = getDistancesBetweenDescriptors(d_db_C10,d_q_C10);


%% Between study

% C1 as db

[distances_dbC1_qC2_between] = getDistancesBetweenDescriptors(d_db_C1,d_q_C2);

[distances_dbC1_qC10_between] = getDistancesBetweenDescriptors(d_db_C1,d_q_C10);

%% C2 as db

[distances_dbC2_qC1_between] = getDistancesBetweenDescriptors(d_db_C2,d_q_C1);
[distances_dbC2_qC10_between] = getDistancesBetweenDescriptors(d_db_C1,d_q_C10);

%% C10 as db

[distances_dbC10_qC1_between] = getDistancesBetweenDescriptors(d_db_C10,d_q_C1);
[distances_dbC10_qC2_between] = getDistancesBetweenDescriptors(d_db_C10,d_q_C2);

%% Normalisation and conversion to correlation

allDistances = {distancesC1within, distancesC2within, distancesC10within, ...
            distances_dbC1_qC2_between, distances_dbC1_qC10_between, distances_dbC2_qC1_between, ...
            distances_dbC2_qC10_between, distances_dbC10_qC1_between, distances_dbC10_qC2_between};
        
Max =  max(cell2mat(cellfun(@(x) max(x(:)),allDistances,'UniformOutput',0)));

for jj = 1:length(allDistances)
    allDistances{jj}(isnan(allDistances{jj})) = Max;
end
%% Convert to correlation
allCorrelations = cellfun(@(x) (-x+Max)/Max, allDistances,'UniformOutput',0);

% allCorrelations = cellfun(@(x) (x(isnan(x)) = Max),allCorrelations,'UniformOutput',0);

corr_dbC1_within = allCorrelations{1};
% corr_dbC1_within(isnan(corr_dbC1_within)) = Max;
corrC2within = allCorrelations{2}; 
corrC10within = allCorrelations{3};
corr_dbC1_qC2_between = allCorrelations{4}; 
corr_dbC1_qC10_between = allCorrelations{5};
corr_dbC2_qC1_between = allCorrelations{6};
corr_dbC2_qC10_between = allCorrelations{7}; 
corr_dbC10_qC1_between = allCorrelations{8};
corr_dbC10_qC2_between = allCorrelations{9};



%% PDF study

% pdfC1within = getPDFfromMetric(allCorrelations{1},100);
% 
% pdfC2within = getPDFfromMetric(Dplots,100);
% 
% pdfC10within = getPDFfromMetric(Dplots,100);

for ii = 1:length(allCorrelations)
    
    [p,x] = getPDFfromMetric(allCorrelations{ii},100);
     
    pdf{ii} = p;
    
    
end % end for loop

% 
% 
% %% Clean up workspace
% 
% clearvars -except d_db_C1 d_q_C1 pdfC1within d_db_C2 d_q_C2 pdfC2within ...
%     d_db_C10 d_q_C10 pdfC10within
% 
% filename = [datestr(date,'yyyymmdd'), '_', 'pdfWithinStudy','_','C1C2C10'];
% save(filename)

