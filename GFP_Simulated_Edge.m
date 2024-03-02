% Initialize structure to contain diameters for all strains/images
all_dat = cell(3,1);

all_dat{1,1} = zeros(25,1);
all_dat{2,1} = zeros(24,1);
all_dat{3,1} = zeros(25,1);

%% Strain 1, rep 1
% for all images of this strain...
for ich = 1:25 
    % if this is the first image, use initial image to get width of image window as reference... 
    if ich == 1
        RGB_initial = imread('\\nestor\hannahwh\(AB) BE 310\Syn Bio\simulated_GFP\Strain 1\initial.png');
        I_initial = rgb2gray(RGB_initial);
        inverseGrayImage = uint8(255) - I_initial;
        all_data{1,1}(ich,1) = readPoints_dist(RGB_initial, 2);
    else 
        ich
        % get image 
        RGB_time = imread(get_file_s1_simulated(ich));
        % Use gui to manually select edge points of visible GFP & store distance 
        all_data{1,1}(ich,1) = readPoints_dist(RGB_time, 2);
    end
end

%% Strain 2, rep 1
% for all images of this strain...
for ich = 1:25 
    % if this is the first image, use initial image to get width of image window as reference... 
    if ich == 1
        RGB_initial = imread('\\nestor\hannahwh\(AB) BE 310\Syn Bio\simulated_GFP\Strain 2\initial.png');
        I_initial = rgb2gray(RGB_initial);
        inverseGrayImage = uint8(255) - I_initial;
        all_data{4,1}(ich,1) = readPoints_dist(RGB_initial, 2);
    else 
        ich
        % get image 
        RGB_time = imread(get_file_s2_simulated(ich));
        % Use gui to manually select edge points of visible GFP & store distance
        all_data{4,1}(ich,1) = readPoints_dist(RGB_time, 2);
    end
end

%% Strain 3, rep 1
% for all images of this strain...
for ich = 1:25 
    % if this is the first image, use initial image to get width of image window as reference... 
    if ich == 1
        RGB_initial = imread('\\nestor\hannahwh\(AB) BE 310\Syn Bio\simulated_GFP\Strain 2\initial.png');
        I_initial = rgb2gray(RGB_initial);
        inverseGrayImage = uint8(255) - I_initial;
        all_data{7,1}(ich,1) = readPoints_dist(RGB_initial, 2);
    else 
        ich
        % get image 
        RGB_time = imread(get_file_s3_simulated(ich));
        % Use gui to manually select edge points of visible GFP & store distance
        all_data{7,1}(ich,1) = readPoints_dist(RGB_time, 2);
    end
end