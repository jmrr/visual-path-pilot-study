% SEQUENCE

% within

% C1

load '20130617SIFTC1.mat'

pdfC1within = getPDFfromDistanceMetric(Dplots,100);

d_db_C1 = d_db; 
d_q_C1 = d_q; 

% clearvars -except d_db_C1 d_q_C1 pdfC1within

%% C2

load '20130617SIFTC2.mat'

pdfC2within = getPDFfromDistanceMetric(Dplots,100);

d_db_C2 = d_db; 
d_q_C2 = d_q; 


%% C10

load '20130617SIFTC10.mat'

pdfC10within = getPDFfromDistanceMetric(Dplots,100);

d_db_C10 = d_db; 
d_q_C10 = d_q; 

%% Clean up workspace

clearvars -except d_db_C1 d_q_C1 pdfC1within d_db_C2 d_q_C2 pdfC2within ...
    d_db_C10 d_q_C10 pdfC10within

filename = [datestr(date,'yyyymmdd'), '_', 'pdfWithinStudy','_','C1C2C10'];
save(filename)