%% Experimental Data

% replace with fluorescence measurements
strain1_GFP = readmatrix("strain1GFP.xlsx"); % same AHL conc across a row
strain2_GFP = readmatrix("strain2GFP.xlsx");
strain3_GFP = readmatrix("strain3GFP.xlsx");

% subtract background
strain1_GFP(:,1) = strain1_GFP(:,1) - strain1_GFP(1,1); 
strain1_GFP(:,2) = strain1_GFP(:,2) - strain1_GFP(1,2);
strain2_GFP(:,1) = strain2_GFP(:,1) - strain2_GFP(1,1);
strain2_GFP(:,2) = strain2_GFP(:,2) - strain2_GFP(1,2);
strain3_GFP(:,1) = strain3_GFP(:,1) - strain3_GFP(1,1);
strain3_GFP(:,2) = strain3_GFP(:,2) - strain3_GFP(1,2);

% replace with OD600 measurements
strain1_OD = readmatrix("strain1OD.xlsx");
strain2_OD = readmatrix("strain2OD.xlsx");
strain3_OD = readmatrix("strain3OD.xlsx");

% normalize fluorescence by OD600
normalized1 = strain1_GFP./strain1_OD;
normalized2 = strain2_GFP./strain2_OD;
normalized3 = strain3_GFP./strain3_OD;

% vector of log[AHL]
AHL = logspace(-4,4,10);

% actual final concentrations of AHL
concentrations = readmatrix("concentrations.xlsx");
concentrations = flip(concentrations);

% take average of 2 trials
m_normalized1 = mean(normalized1,2);
m_normalized2 = mean(normalized2,2);
m_normalized3 = mean(normalized3,2);

% standard deviation of 2 trials
s_normalized1 = std(normalized1,0,2);
s_normalized2 = std(normalized2,0,2);
s_normalized3 = std(normalized3,0,2);

%% Rearrange the Data
flipped1 = flip(m_normalized1(2:10));
flipped2 = flip(m_normalized2(2:10));
flipped3 = flip(m_normalized3(2:10));

final1 = [m_normalized1(1);flipped1];
final2 = [m_normalized2(1);flipped2];
final3 = [m_normalized3(1);flipped3];

eflipped1 = flip(s_normalized1(2:10));
eflipped2 = flip(s_normalized2(2:10));
eflipped3 = flip(s_normalized3(2:10));
efinal1 = [s_normalized1(1);eflipped1];
efinal2 = [s_normalized2(1);eflipped2];
efinal3 = [s_normalized3(1);eflipped3];

%% plot normalized fluorescence vs. log[AHL]

figure(1)
semilogx(concentrations,final1,LineWidth=1.5);
xlabel("log[AHL] (log(µM))");
ylabel("GFP Expression")
ylim([-0.1 1])
title("Strain 1")
xlim([10e-6 10e2])

figure(2)
semilogx(concentrations,final2,LineWidth=1.5);
xlabel("log[AHL] (log(µM))");
ylabel("GFP Expression")
ylim([-0.1 1])
title("Strain 2")
xlim([10e-6 10e2])

figure(3)
semilogx(concentrations,final3,LineWidth=1.5);
xlabel("log[AHL] (log(µM))");
ylabel("GFP Expression")
ylim([-0.1 1])
title("Strain 3")
xlim([10e-6 10e2])

