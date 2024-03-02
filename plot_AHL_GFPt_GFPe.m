%% NRMSE, Plot AHL edge, theoretical GFP edge, and experimental GFP edge


%% Define data (add zeros)

s1rep1 = all_data_RW_reref{1,1}./2;
s1rep2 = all_data_RW_reref{2,1}./2;
s1rep3 = all_data_RW_reref{3,1}./2;

s2rep1 = all_data_RW_reref{4,1}./2;
s2rep2 = all_data_RW_reref{5,1}./2;
s2rep3 = all_data_RW_reref{6,1}./2;

s3rep1 = all_data_RW_reref{7,1}./2;
s3rep2 = all_data_RW_reref{8,1}./2;
s3rep3 = all_data_RW_reref{9,1}./2;


%% data cleaning + make edge distance matrices
%% steing 1 - images

edge_distanceM_exp1 = zeros(25,1);
edge_distanceM_exp1_std = zeros(25,1);

for i = 1:25

    a = s1rep1(i);
    b = s1rep2(i);
    c = s1rep3(i);

    if a>0 && b>0 && c>0
        ave = (a+b+c)/3;
        stdev = std([a b c]);
    elseif a>0 && b>0 && c==0
        ave = (a+b)/2;
        stdev = std([a b]);
    elseif a>0 && b==0 && c>0
        ave = (a+c)/2;
        stdev = std([a c]);
    elseif a>0 && b==0 && c==0
        ave = a;
        stdev = 0;
    elseif a==0 && b>0 && c>0
        ave = (b+c)/2;
        stdev = std([b c]);
    elseif a==0 && b==0 && c>0
        ave = c;
        stdev = 0;
    elseif a==0 && b>0 && c==0
        ave = b;
        stdev = 0;
    end

    edge_distanceM_exp1(i) = ave;
    edge_distanceM_exp1_std(i) = stdev;
   
end

%% steing 2 - images

edge_distanceM_exp2 = zeros(27,1);
edge_distanceM_exp2_std = zeros(27,1);

for i = 1:27

    a = s2rep1(i);
    b = s2rep2(i);
    c = s2rep3(i);

    if a>0 && b>0 && c>0
        ave = (a+b+c)/3;
        stdev = std([a b c]);
    elseif a>0 && b>0 && c==0
        ave = (a+b)/2;
        stdev = std([a b]);
    elseif a>0 && b==0 && c>0
        ave = (a+c)/2;
        stdev = std([a c]);
    elseif a>0 && b==0 && c==0
        ave = a;
        stdev = 0;
    elseif a==0 && b>0 && c>0
        ave = (b+c)/2;
        stdev = std([b c]);
    elseif a==0 && b==0 && c>0
        ave = c;
        stdev = 0;
    elseif a==0 && b>0 && c==0
        ave = b;
        stdev = 0;
    end

    edge_distanceM_exp2(i) = ave;
    edge_distanceM_exp2_std(i) = stdev;
   
end

%% steing 3 - images

edge_distanceM_exp3 = zeros(25,1);
edge_distanceM_exp3_std = zeros(25,1);

for i = 1:25

    a = s3rep1(i);
    b = s3rep2(i);
    c = s3rep3(i);

    if a>0 && b>0 && c>0
        ave = (a+b+c)/3;
        stdev = std([a b c]);
    elseif a>0 && b>0 && c==0
        ave = (a+b)/2;
        stdev = std([a b]);
    elseif a>0 && b==0 && c>0
        ave = (a+c)/2;
        stdev = std([a c]);
    elseif a>0 && b==0 && c==0
        ave = a;
        stdev = 0;
    elseif a==0 && b>0 && c>0
        ave = (b+c)/2;
        stdev = std([b c]);
    elseif a==0 && b==0 && c>0
        ave = c;
        stdev = 0;
    elseif a==0 && b>0 && c==0
        ave = b;
        stdev = 0;
    end

    edge_distanceM_exp3(i) = ave;
    edge_distanceM_exp3_std(i) = stdev;
   
end

%% strain 1 - heatmaps

 M1 = all_data{1,1};
 edge_distanceM_model1 = 87.*M1./M1(1);
 edge_distanceM_model1 = edge_distanceM_model1./2;
 edge_distanceM_model1(2) = 0;
 edge_distanceM_model1 = edge_distanceM_model1(2:25);

%% strain 2 - heatmaps

M2 = all_data{4,1};
edge_distanceM_model2 = 87.*M2./M2(1);
edge_distanceM_model2 = edge_distanceM_model2./2;
edge_distanceM_model2(2) = 0;
edge_distanceM_model2 = edge_distanceM_model2(2:25);

%% strain 3 - heatmaps

M3 = all_data{7,1};
edge_distanceM_model3 = 87.*M3./M3(1);
edge_distanceM_model3 = edge_distanceM_model3./2;
edge_distanceM_model3(2) = 0;
edge_distanceM_model3 = edge_distanceM_model3(2:25);


%% Define + compute NRMSE

% Strain 1
NRMSE1 = NRMSE_Finder(edge_distanceM_exp1,edge_distanceM_model1);

% Strain 2
NRMSE2 = NRMSE_Finder(edge_distanceM_exp2,edge_distanceM_model2);

% Strain 3
NRMSE3 = NRMSE_Finder(edge_distanceM_exp3,edge_distanceM_model3);


%% Plot
time1 = [0:1:24];
time2 = [0:1:26];
time3 = [0:1:24];
time_AHL = [0:1:24];
time_GFP = [0:1:23];

%% Strain 1
subplot(1,3,1);

plot(time_AHL,edge_distances1,LineWidth=1,Color = 'k');
hold on

errorbar(time1,edge_distanceM_exp1,edge_distanceM_exp1_std,'o',LineWidth=1,Color = 'r');
hold on

plot(time_GFP,edge_distanceM_model1,LineWidth=1,Color = 'b');
hold on

plot(time_GFP,1.*time_GFP,'.',LineWidth=0.01,Color = 'w');
hold off

xlabel("Time (hours)", FontSize = 14);
ylabel("Edge distances (mm)", FontSize = 14)
title("Strain 1", FontSize = 16)
legend("AHL","Experimental GFP (n=3)","Theoretical GFP","NRMSE = 0.2188",FontSize = 10);

%% Strain 2
subplot(1,3,2);
 
plot(time_AHL,edge_distances2,LineWidth=1,Color = 'k');
hold on

errorbar(time2, edge_distanceM_exp2, edge_distanceM_exp2_std,'o',LineWidth=1,Color = 'r');
hold on

plot(time_GFP,edge_distanceM_model2,LineWidth=1,Color = 'b');
hold on

plot(time_GFP,1.*time_GFP,'.',LineWidth=0.01,Color = 'w');
hold off

xlabel("Time (hours)", FontSize = 14);
ylabel("Edge distances (mm)", FontSize = 14)
title("Strain 2", FontSize = 16)
legend("AHL","Experimental GFP (n=3) ","Theoretical GFP","NRMSE = 0.1868",FontSize = 10);

%% Strain 3
subplot(1,3,3);

plot(time_AHL,edge_distances3,LineWidth=1.5,Color = 'k');
hold on

errorbar(time3, edge_distanceM_exp3,edge_distanceM_exp3_std,'o',LineWidth=1,Color = 'r');
hold on

plot(time_GFP,edge_distanceM_model3,LineWidth=1,Color = 'b');
hold on

plot(time_GFP,1.*time_GFP,'.',LineWidth=0.01,Color = 'w');
hold off

xlabel("Time (hours)", FontSize = 14);
ylabel("Edge distances (mm)", FontSize = 14)
title("Strain 3", FontSize = 16)
legend("AHL","Experimental GFP (n=3)","Theoretical GFP","NRMSE = 0.1496",FontSize = 10);



