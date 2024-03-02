%% Day 4 Version 1

%% Identifying steady state switch points for each strain
GFP_switch = 0.5; % Switch point occurs @ GFP expression = 0.5
[minDist1,minIndex1] = min(abs(norm_model1-GFP_switch));
[minDist2,minIndex2] = min(abs(norm_model2-GFP_switch));
[minDist3,minIndex3] = min(abs(norm_model3-GFP_switch));

% Locate AHL switch points 
AHL_switch1 = AHL(minIndex1);
AHL_switch2 = AHL(minIndex2);
AHL_switch3 = AHL(minIndex3);

% Validate AHL switch points 
disp(norm_model1(minIndex1))
disp(norm_model2(minIndex2))
disp(norm_model3(minIndex3))

% Display AHL switch points 
disp(AHL_switch1)
disp(AHL_switch2)
disp(AHL_switch3)

%% Developing the 2D Diffusion Model 
% Physical parameters
plate_length = 87; % (mm)
Radius_Plate = plate_length/2; % (mm)
Radius_Disk = 3; % (mm)
T = 24*60; % Experiment duration (min)
D = 0.15; % Diffusion rate (mm^2/min)  
d_AHL = 4.8134e-1; % (min^-1)
sourceconc = 10; % Source concentration (µM)
plateconc = 0; % (µM)

% Define XY mesh
n = 200; % Number of mesh points in the X- and Y- coordinates
dx = 1; % X-step size (mm)
dy = 1; % Y-step size (mm)
xgrid = -Radius_Plate:dx:Radius_Plate; % Centers the grid in x around zero
ygrid = -Radius_Plate:dy:Radius_Plate; % Centers the grid in y around zero
[X,Y] = meshgrid(xgrid,ygrid);

% Time Discretization 
stability_factor = 0.25; % FTCS stability condition must be <= 0.25 
dt = stability_factor*(dx^2)/D; % Time increment derived from stability criterion 
time = 0:dt:T; % Time vector with increments of dt
r = D*dt/(dx^2); % Finite difference equation value of r

% Initial conditions of the plate 
AHL_Initial = zeros(length(xgrid),length(ygrid)); % Initially 0 µM of AHL across plate 

% Initial conditions of the disk
[Disk_Indices_Row,Disk_Indices_Col] = find(sqrt(X.^2+Y.^2)<=Radius_Disk); % Initially 10 µM (sourceconc) of AHL across disk 
for i = 1:length(Disk_Indices_Row)
    AHL_Initial(Disk_Indices_Row(i),Disk_Indices_Col(i))=sourceconc;
end

% Draw mesh to visualize initial conditions
mesh(X,Y,AHL_Initial);

% Create a 3D matrix (x,y,t) to describe the AHL concentration profile
AHL_3D_matrix = zeros(length(xgrid),length(ygrid),length(time));

% Initialize AHL by making its first time step equal AHL_Initial
AHL_3D_matrix(:,:,1) = AHL_Initial;

%% Plot diffusion over 24 Hours
% Assume no flux out of the plate & AHL does not degrade, d_AHL = 0
for t = 2:length(time)
    % Loop over all interior points, excluding boundaries 
    for i = 2:2*Radius_Plate
        for j = 2:2*Radius_Plate
            if sqrt(X(i,j)^2+Y(i,j)^2) <= Radius_Plate
                AHL_3D_matrix(i,j,t) = AHL_3D_matrix(i,j,t-1)+r*(AHL_3D_matrix(i-1,j,t-1)+ ...
                   AHL_3D_matrix(i+1,j,t-1)+AHL_3D_matrix(i,j-1,t-1)+AHL_3D_matrix(i,j+1,t-1)-4*AHL_3D_matrix(i,j,t-1));
            else
                % Concentration of points beyond plate set to 0 µM
                AHL_3D_matrix(i,j,t)=0;
            end
        end
    end
end


%% Edge distance of AHL vs. time -- Strain 1
times_AHL = [1, 1+180/dt, 1+360/dt, 1+540/dt, 1+720/dt, 1+900/dt, 1+1080/dt, 1+1260/dt, 1+1440/dt];
edge_distances1 = zeros(1, length(times_AHL));

for k = 2:length(times_AHL)
    time_of_interest = times_AHL(k);

    % Isolate 2D matrix at a given time and y = 0
    AHL_interest = AHL_3D_matrix(:,length(xgrid)/2,time_of_interest);

    % Determine a set of indices that is equal to edge concentration
    [minr,index] = min(abs(AHL_interest - AHL_switch1));
    disp(index)
    
    % Compute the distance
    centr = length(xgrid)/2;
    edge_dist = abs(index - centr);
    edge_distances1(1, k) = edge_dist;
end

plot((times_AHL*dt)/60,edge_distances1, LineWidth=1.5)
title("Strain 1 Model: AHL Edge Distance vs. Time")
xlabel("Time [hrs]")
ylabel("AHL Edge Distance [mm]")
xlim([0 24])

%% Edge distance of AHL vs. time -- Strain 2
edge_distances2 = zeros(1, length(times_AHL));

for k = 2:length(times_AHL)
    time_of_interest = times_AHL(k);

    % Isolate 2D matrix at a given time and y = 0
    AHL_interest = AHL_3D_matrix(:,length(xgrid)/2,time_of_interest);

    % Determine a set of indices that is equal to edge concentration
    [minr,index] = min(abs(AHL_interest - AHL_switch2));
    disp(index)
    
    % Compute the distance
    centr = length(xgrid)/2;
    edge_dist = abs(index - centr);
    edge_distances2(1, k) = edge_dist;
end

plot((times_AHL*dt)/60,edge_distances2, LineWidth=1.5)
title("Strain 2 Model: AHL Edge Distance vs. Time")
xlabel("Time [hrs]")
ylabel("AHL Edge Distance [mm]")
xlim([0 24])

%% Edge distance of AHL vs time -- Strain 3
edge_distances3 = zeros(1, length(times_AHL));

for k = 2:length(times_AHL)
    time_of_interest = times_AHL(k);

    % Isolate 2D matrix at a given time and y = 0
    AHL_interest = AHL_3D_matrix(:,length(xgrid)/2,time_of_interest);

    % Determine a set of indices that is equal to edge concentration
    [minr,index] = min(abs(AHL_interest - AHL_switch3));
    disp(index)
    
    % Compute the distance
    centr = length(xgrid)/2;
    edge_dist = abs(index - centr);
    edge_distances3(1, k) = edge_dist;
    figure(k)
    plot(AHL_interest)
end

plot((times_AHL*dt)/60,edge_distances3, LineWidth=1.5)
title("Strain 3 Model: AHL Edge Distance vs. Time")
xlabel("Time [hrs]")
ylabel("Edge Distance from Center of Plate [mm]")
xlim([0 24])

%% Heatmap of GFP expression over 24 hours 
%% Strain 1
LuxR = 1.3; % (µM)
rho_R = 0.5; % (µM^-3)(min^-1)
delta_R = 0.023; % (min^-1)
K_R = 1*10^(-5); % (µM)
n1 = 1; % Unitless
alpha_TX = 0.03; % (µM)(min^-1)
delta_TX = 0.15; % (min^-1)
alpha_GFP = 2; % (min^-1)
delta_GFP = 3.7*10^(-4); % (min^-1)

R = zeros(length(xgrid),length(ygrid),length(time));
TX = zeros(length(xgrid),length(ygrid),length(time));
GFP = zeros(length(xgrid),length(ygrid),length(time));
for k = 2:length(time)
    for i = 1:length(xgrid)
        for j = 1: length(ygrid)
            % Discretization of the transfer function
            R(i,j,k) = R(i,j,k-1) + (rho_R * LuxR^2 * (AHL_3D_matrix(i,j,k-1))^2 - delta_R * R(i,j,k-1)) * dt;
            TX(i,j,k) = TX(i,j,k-1) + ((alpha_TX * (R(i,j,k-1) / K_R)^n1) / (1 + (R(i,j,k-1) / K_R)^n1) - delta_TX * TX(i,j,k-1)) * dt;
            GFP(i,j,k) = GFP(i,j,k-1) + ( alpha_GFP * TX(i,j,k-1) - delta_GFP * GFP(i,j,k-1) ) * dt;
        end
    end
end

desired_times = [0, 3*60, 6*60, 9*60, 12*60, 15*60, 18*60, 21*60, 24*60];
time_indices = round(desired_times / dt) + 1; 

figure; % Open a new figure window

% Loop through the desired time points
for i = 1:length(time_indices)
    subplot(3,3,i); % Arrange plots in a 3x3 grid
    h = imagesc(X(1,:), Y(:,1), GFP(:,:,time_indices(i))); % Plot GFP concentration (row, column, height/time)
    set(gca,'YDir','normal'); % Correct the Y-axis direction so the origin is at the bottom-left
    axis equal tight; % Keep the aspect ratio square and limit axes to data range
    colormap('summer'); % Use a heat colormap
    c = colorbar; % Show a color bar
    c.Label.String = 'GFP Concentration'; % Label the color bar
    title(sprintf('Time: %d hours', desired_times(i)/60)); % Title with the time

    % Labeling the axes
    xlabel('X (mm)');
    ylabel('Y (mm)');
    
    % Adjust the axes limits to ensure the origin is in the middle
    xlim([min(X(1,:)) max(X(1,:))]);
    ylim([min(Y(:,1)) max(Y(:,1))]);
end

sgtitle('Strain 1: GFP Concentration Over Time');

%% Strain 2
LuxR = 0.05; % (µM)
rho_R = 0.5; % (µM^-3)(min^-1)
delta_R = 0.023; % (min^-1)
K_R = 1*10^(-5); % (µM)
n1 = 1; % Unitless
alpha_TX = 0.03; % (µM)(min^-1)
delta_TX = 0.15; % (min^-1)
alpha_GFP = 2; % (min^-1)
delta_GFP = 3.7*10^(-4); % (min^-1)

R = zeros(length(xgrid),length(ygrid),length(time));
TX = zeros(length(xgrid),length(ygrid),length(time));
GFP = zeros(length(xgrid),length(ygrid),length(time));
for k = 2:length(time)
    for i = 1:length(xgrid)
        for j = 1: length(ygrid)
            % Discretization of the transfer function
            R(i,j,k) = R(i,j,k-1) + (rho_R * LuxR^2 * (AHL_3D_matrix(i,j,k-1))^2 - delta_R * R(i,j,k-1)) * dt;
            TX(i,j,k) = TX(i,j,k-1) + ((alpha_TX * (R(i,j,k-1) / K_R)^n1) / (1 + (R(i,j,k-1) / K_R)^n1) - delta_TX * TX(i,j,k-1)) * dt;
            GFP(i,j,k) = GFP(i,j,k-1) + ( alpha_GFP * TX(i,j,k-1) - delta_GFP * GFP(i,j,k-1) ) * dt;
        end
    end
end

figure; % Open a new figure window

% Loop through the desired time points
for i = 1:length(time_indices)
    subplot(3,3,i); % Arrange plots in a 3x3 grid
    h = imagesc(X(1,:), Y(:,1), GFP(:,:,time_indices(i))); % Plot GFP concentration (row, column, height/time)
    set(gca,'YDir','normal'); % Correct the Y-axis direction so the origin is at the bottom-left
    axis equal tight; % Keep the aspect ratio square and limit axes to data range
    colormap('summer'); % Use a heat colormap
    c = colorbar; % Show a color bar
    c.Label.String = 'GFP Concentration'; % Label the color bar
    title(sprintf('Time: %d hours', desired_times(i)/60)); % Title with the time

    % Labeling the axes
    xlabel('X (mm)');
    ylabel('Y (mm)');
    
    % Adjust the axes limits to ensure the origin is in the middle
    xlim([min(X(1,:)) max(X(1,:))]);
    ylim([min(Y(:,1)) max(Y(:,1))]);
end

sgtitle('Strain 2: GFP Concentration Over Time');

%% Strain 3
LuxR = 0.05; % (µM)
rho_R = 0.5; % (µM^-3)(min^-1)
delta_R = 0.023; % (min^-1)
K_R = 1*10^(-6); % (µM)
n1 = 1; % Unitless
alpha_TX = 0.03; % (µM)(min^-1)
delta_TX = 0.15; % (min^-1)
alpha_GFP = 2; % (min^-1)
delta_GFP = 3.7*10^(-4); % (min^-1)

R = zeros(length(xgrid),length(ygrid),length(time));
TX = zeros(length(xgrid),length(ygrid),length(time));
GFP = zeros(length(xgrid),length(ygrid),length(time));
for k = 2:length(time)
    for i = 1:length(xgrid)
        for j = 1: length(ygrid)
            % Discretization of the transfer function
            R(i,j,k) = R(i,j,k-1) + (rho_R * LuxR^2 * (AHL_3D_matrix(i,j,k-1))^2 - delta_R * R(i,j,k-1)) * dt;
            TX(i,j,k) = TX(i,j,k-1) + ((alpha_TX * (R(i,j,k-1) / K_R)^n1) / (1 + (R(i,j,k-1) / K_R)^n1) - delta_TX * TX(i,j,k-1)) * dt;
            GFP(i,j,k) = GFP(i,j,k-1) + ( alpha_GFP * TX(i,j,k-1) - delta_GFP * GFP(i,j,k-1) ) * dt;
        end
    end
end

figure; % Open a new figure window

% Loop through the desired time points
for i = 1:length(time_indices)
    subplot(3,3,i); % Arrange plots in a 3x3 grid
    h = imagesc(X(1,:), Y(:,1), GFP(:,:,time_indices(i))); % Plot GFP concentration (row, column, height/time)
    set(gca,'YDir','normal'); % Correct the Y-axis direction so the origin is at the bottom-left
    axis equal tight; % Keep the aspect ratio square and limit axes to data range
    colormap('summer'); % Use a heat colormap
    c = colorbar; % Show a color bar
    c.Label.String = 'GFP Concentration'; % Label the color bar
    title(sprintf('Time: %d hours', desired_times(i)/60)); % Title with the time

    % Labeling the axes
    xlabel('X (mm)');
    ylabel('Y (mm)');
    
    % Adjust the axes limits to ensure the origin is in the middle
    xlim([min(X(1,:)) max(X(1,:))]);
    ylim([min(Y(:,1)) max(Y(:,1))]);
end

sgtitle('Strain 3: GFP Concentration Over Time');
