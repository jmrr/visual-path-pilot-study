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

% ALL as db

[distances_db_all_qC1_between] = getDistancesBetweenDescriptors(d_db_all,d_q_C1);

[distances_db_all_qC2_between] = getDistancesBetweenDescriptors(d_db_all,d_q_C2);

[distances_db_all_qC10_between] = getDistancesBetweenDescriptors(d_db_all,d_q_C10);


%% Normalisation and conversion to correlation

allDistancesPooled = {distancesC1within, distancesC2within, distancesC10within, ...
            distances_db_all_qC1_between, distances_db_all_qC2_between, distances_db_all_qC10_between};
        
Max =  max(cell2mat(cellfun(@(x) max(x(:)),allDistancesPooled,'UniformOutput',0)));

for jj = 1:length(allDistancesPooled)
    allDistancesPooled{jj}(isnan(allDistancesPooled{jj})) = Max;
end
%% Convert to correlation
allCorrelationsPooled = cellfun(@(x) (-x+Max)/Max, allDistancesPooled,'UniformOutput',0);

% allCorrelations = cellfun(@(x) (x(isnan(x)) = Max),allCorrelations,'UniformOutput',0);

corr_dbC1_within = allCorrelationsPooled{1};
% corr_dbC1_within(isnan(corr_dbC1_within)) = Max;
corrC2within = allCorrelationsPooled{2}; 
corrC10within = allCorrelationsPooled{3};
corr_dbC1_qC2_between = allCorrelationsPooled{4}; 
corr_dbC1_qC10_between = allCorrelationsPooled{5};
corr_dbC2_qC1_between = allCorrelationsPooled{6};
corr_dbC2_qC10_between = allCorrelationsPooled{7}; 
corr_dbC10_qC1_between = allCorrelationsPooled{8};
corr_dbC10_qC2_between = allCorrelationsPooled{9};



%% PDF study

% pdfC1within = getPDFfromMetric(allCorrelations{1},100);
% 
% pdfC2within = getPDFfromMetric(Dplots,100);
% 
% pdfC10within = getPDFfromMetric(Dplots,100);

for ii = 1:length(allCorrelationsPooled)
    
    [p,x] = getPDFfromMetric(allCorrelationsPooled{ii},100);
     
    pdfPooled{ii} = p;
    
    
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

