%% Plot Experimental Data and Theoretical Models

%% Finding Horizontal Error Bars
% (horizontal) error in AHL concentration arises from pipetting uncertainty

errorConc = readmatrix("concentrations.xlsx"); % final concentrations of AHL
delta_AHL = zeros(10,1); % for storing
horizontalError = zeros(10,1); % for storing
delta_pipette = 0.1; % uncertainty of pipet measurements [uL]

for i = 2:length(errorConc)
    C_ori = errorConc(i-1);
    AHL_target = (20/(20+180)) * C_ori; 

    syms V_stock V_DI C
    AHL = (V_stock/(V_stock+V_DI))*C;

    % compute uncertainty of AHL
    dAHL_dVstock(V_stock,V_DI,C) = diff(AHL,V_DI);
    dAHL_dVDI(V_stock,V_DI,C)  = diff(AHL,V_DI);
    dAHL_dC(V_stock,V_DI,C)  = diff(AHL,C);
    
    delta_AHL(i) = dAHL_dVstock(20,180,C_ori) * delta_pipette + dAHL_dVDI(20,180,C_ori) * delta_pipette + dAHL_dC(20,180,C_ori) * delta_AHL(i-1);
    
    horizontalError(i) = (1/AHL_target)*delta_AHL(i);

end

horizontalError = horizontalError .* (-1);
   
    if i == 1
        delta_AHL(i) = 0;
    else
        delta_AHL(i) = (dAHL_dVstock + dAHL_dVDI)*.1+dAHL_dC*delta_AHL(i-1);
        horizontalError(i) = (1/AHL)*delta_AHL(i);
    end

horizontalError(1)=0;

%% Strain 1 Data and Model

% Define Constants for Strain 1
LuxR = 1.3; % uM
rho_R = 0.5; % uM^-3 * min^-1
delta_R = 0.023; % min^-1
K_R = 1e-5; % uM
n1 = 1; % unitless, never change this value
alpha_TX = 0.03; % uM * min^-1
delta_TX = 0.15; % min^-1
alpha_GFP = 2; % min^-1
delta_GFP = 3.7e-4; % min^-1

% Transfer Function
a = alpha_GFP * alpha_TX / (delta_GFP*delta_TX);
b = rho_R * LuxR^2; 
c = (K_R * delta_R)^n1;
GFP = zeros(length(AHL),1);
AHL = logspace(-6,2,1000);
for i = 1:length(AHL)
    current_AHL = AHL(i);
    GFP(i) = a*(b*current_AHL^2)^n1 / (c^n1+(b*current_AHL^2)^n1); % GFP as a function of AHL
end

% Normalized Model
norm_model1 = Normalizer(GFP);

% Normalized Experimental Data
norm_experiment1 = Normalizer(final1);

% Plot Experimental Data (remove outlier)
hold on
plot(concentrations(1,1:9),norm_experiment1(1:9,1),'.',LineWidth=1.5,Color = 'k');
set(gca,'xscale','log')
xlabel("log[AHL] (log(µM))" + newline, FontSize = 14);
ylabel("GFP Expression", FontSize = 14)
title("Strain 1", FontSize = 16)

% Plot Theoretical Model
semilogx(AHL,norm_model1,LineWidth=1.5,Color = 'b');
grid on

% Plot Error Bars for Experimental Data
errorbar(concentrations,norm_experiment1,s_normalized1,s_normalized1,horizontalError,horizontalError,'.','LineStyle','none',Color='k')

% Plot Outlier with Error Bars
plot(concentrations(10),norm_experiment1(10),'.',LineWidth=1.5,Color = 'r')
set(gca,'xscale','log')
errorbar(concentrations(10),norm_experiment1(10),s_normalized1(10),s_normalized1(10),horizontalError(10),horizontalError(10),'.','LineStyle','none',Color='r')
plot(-1000, 1000, 'ow')

% Legend
legend("experimental","theoretical","","outlier","","RMSE = 0.1095",location='southeast')


ylim([-.2 1.1])
xlim([9e-7 1.5e2])

%% Strain 2 Data and Model

% Define Constants
LuxR = 0.05; % uM
rho_R = 0.5; % uM^-3 * min^-1
delta_R = 0.023; % min^-1
K_R = 1e-5; % uM
n1 = 1; % unitless, never change this value
alpha_TX = 0.03; % uM * min^-1
delta_TX = 0.15; % min^-1
alpha_GFP = 2; % min^-1
delta_GFP = 3.7e-4; % min^-1

% Transfer Function
a = alpha_GFP * alpha_TX / (delta_GFP*delta_TX);
b = rho_R * LuxR^2; 
c = (K_R * delta_R)^n1;
GFP = zeros(length(AHL),1);
AHL = logspace(-6,2,1000);
for i = 1:length(AHL)
    current_AHL = AHL(i);
    GFP(i) = a*(b*current_AHL^2)^n1 / (c^n1+(b*current_AHL^2)^n1); % GFP as a function of AHL
end

% Normalized Model
norm_model2 = Normalizer(GFP);

% Normalized Experiment
norm_experiment2 = Normalizer(final2);

concentrations_outlier_removed = concentrations(1,1:8);
concentrations_outlier_removed(10) = concentrations(10);
norm_experiment2_outlier_removed = norm_experiment2(1:8,1);
norm_experiment2_outlier_removed(10) = norm_experiment2(10);

% Plot Experimental Data (outlier removed)
figure()
plot(concentrations_outlier_removed,norm_experiment2_outlier_removed,'.',LineWidth=1.5,Color = 'k');
set(gca,'xscale','log')
hold on
xlabel("log[AHL] (log(µM))" + newline, FontSize = 14);
ylabel("GFP Expression", FontSize = 14)
title("Strain 2", FontSize = 16)

% Plot Theoretical Model
semilogx(AHL,norm_model2,LineWidth=1.5,Color = 'b');
grid on

% Plot Error Bars
errorbar(concentrations,norm_experiment2,s_normalized2,s_normalized2,horizontalError,horizontalError,'.','LineStyle','none',Color='k')
%eb(1) = errorbar(concentrations, norm_experiment2,s_normalized2,'vertical','LineStyle','none')
% legend('experimental (RMSE = 0.1114)','theoretical')

% Plot Outlier with Error Bars
plot(concentrations(9),norm_experiment2(9),'.',LineWidth=1.5,Color = 'r')
set(gca,'xscale','log')
errorbar(concentrations(9),norm_experiment2(9),s_normalized2(9),s_normalized2(9),horizontalError(9),horizontalError(9),'.','LineStyle','none',Color='r')
plot(-1000, 1000, 'ow')

% Legend
legend("experimental","theoretical","","outlier","","RMSE = 0.1123",location='southeast')


ylim([-.1 1.1])
xlim([9e-7 1.5e2])

%% Strain 3 Data and Model

% Define Constants
LuxR = 0.05; % uM
rho_R = 0.5; % uM^-3 * min^-1
delta_R = 0.023; % min^-1
K_R = 1e-6; % uM
n1 = 1; % unitless, never change this value
alpha_TX = 0.03; % uM * min^-1
delta_TX = 0.15; % min^-1
alpha_GFP = 2; % min^-1
delta_GFP = 3.7e-4; % min^-1

% Transfer Function
a = alpha_GFP * alpha_TX / (delta_GFP*delta_TX);
b = rho_R * LuxR^2; 
c = (K_R * delta_R)^n1;
GFP = zeros(length(AHL),1);
AHL = logspace(-6,2,1000);
for i = 1:length(AHL)
    current_AHL = AHL(i);
    GFP(i) = a*(b*current_AHL^2)^n1 / (c^n1+(b*current_AHL^2)^n1); % GFP as a function of AHL
end

% Normalized Model
norm_model3 = Normalizer(GFP);

% Normalized Experiment
norm_experiment3 = Normalizer(final3);

% Plot Experimental Data
figure()
scatter(concentrations,norm_experiment3,'.',LineWidth=1.5,Color = 'k');
set(gca,'xscale','log')
hold on
xlabel("log[AHL] (log(µM))" + newline, FontSize = 14);
ylabel("GFP Expression", FontSize = 14)
title("Strain 3", FontSize = 16)

% Plot Theoretical Model
semilogx(AHL,norm_model3,LineWidth=1.5,Color = 'b');
grid on

% Plot Error Bars
errorbar(concentrations,norm_experiment3,s_normalized3,s_normalized3,horizontalError,horizontalError,'.','LineStyle','none',Color='k')
% legend('experimental (RMSE = 0.1114)','theoretical')

h(1) = plot(NaN,NaN,'.k',LineWidth=1.5);
h(2) = plot(NaN,NaN,'-b',LineWidth=1.5);
h(3) = plot(NaN,NaN,'ow');
legend(h,"experimental","theoretical","RMSE = 0.0280",location='southeast')


ylim([-.2 1.1])
xlim([9e-7 1.5e2])