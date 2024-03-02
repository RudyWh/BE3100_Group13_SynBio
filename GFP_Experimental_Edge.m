% Initialize structure to contain diameters for all strains/reps/images
all_dat = cell(9,1);

all_dat{1,1} = zeros(25,1);
all_dat{2,1} = zeros(24,1);
all_dat{3,1} = zeros(25,1);
all_dat{4,1} = zeros(25,1);
all_dat{5,1} = zeros(24,1);
all_dat{6,1} = zeros(27,1);
all_dat{7,1} = zeros(25,1);
all_dat{8,1} = zeros(24,1);
all_dat{9,1} = zeros(25,1);

%% Strain 1, rep 1
% for all images of this strain/rep...
for ich = 1:25 
    % if this is the first image, use greyscale to get diameter of filter paper as reference 
    if ich == 1
        RGB_initial = imread('\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain1_rep1\2.0s_Exposure\Initial.png');
        I_initial = rgb2gray(RGB_initial);
        inverseGrayImage = uint8(255) - I_initial;
        all_data{1,1}(ich,1) = readPoints_dist(inverseGrayImage, 2);
    else 
        ich 
        % load the imitial image as reference for processing 
        RGB_initial = imread('\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain1_rep1\2.0s_Exposure\Initial.png');
        % convert initial image to greyscale 
        I_initial = rgb2gray(RGB_initial);

        % get image for this strain/rep/time 
        RGB_time = imread(get_file_s1r1(ich));
        % convert to greyscale 
        I_time = rgb2gray(RGB_time);
        % get difference in greyscale images (from initial to current time)
        I_checking = I_time - I_initial;
        
        % make pixels above a brightness threshold completly white (increase ease of visual distinction) 
        for ich_in = 1:size(I_checking,1)
            for jch_in = 1:size(I_checking,2)
                if I_checking(ich_in,jch_in)>50
                    I_checking(ich_in,jch_in)=255;
                end
            end
        end
        
        % automatically find edges on the processed image 
        BW1 = edge(I_checking,'Prewitt');

        % DISREGARD PROCESSING DONE ABOVE...DID NOT ACTUALLY END UP USING BUT LEFT IN AS REFERENCE/POTENTIAL FOR USE 
        % Use gui to manually select edge points of visible GFP & store distance 
        all_data{1,1}(ich,1) = readPoints_dist(RGB_time, 2);
    end
end
%%
% ALL SUBSEQUENT SECTIONS ARE THE SAME FORMAT AS ABOVE

%% Strain 1, rep 2
for ich = 1:24 
    if ich == 1
        RGB_initial = imread('\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain1_rep2\2.0s_Exposure\Initial.png');
        I_initial = rgb2gray(RGB_initial);
        inverseGrayImage = uint8(255) - I_initial;
        all_data{2,1}(ich,1) = readPoints_dist(inverseGrayImage, 2);
    else 
        if ich~=20
            ich
            RGB_initial = imread('\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain1_rep2\2.0s_Exposure\Initial.png');
            I_initial = rgb2gray(RGB_initial);
            RGB_time = imread(get_file_s1r2(ich));
            I_time = rgb2gray(RGB_time);
            I_checking = I_time - I_initial;
            for ich_in = 1:size(I_checking,1)
                for jch_in = 1:size(I_checking,2)
                    if I_checking(ich_in,jch_in)>50
                        I_checking(ich_in,jch_in)=255;
                    end
                end
            end
            % inverseGrayImage = uint8(255) - I_time;
            BW1 = edge(I_checking,'Prewitt');
            all_data{2,1}(ich,1) = readPoints_dist(RGB_time, 2);
        end
    end
end

%% Strain 1, rep 3
for ich = 1:25 
    if ich == 1
        RGB_initial = imread('\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain1_rep3\2.0s_Exposure\Initial.png');
        I_initial = rgb2gray(RGB_initial);
        inverseGrayImage = uint8(255) - I_initial;
        all_data{3,1}(ich,1) = readPoints_dist(inverseGrayImage, 2);
    else 
        ich
        RGB_initial = imread('\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain1_rep3\2.0s_Exposure\Initial.png');
        I_initial = rgb2gray(RGB_initial);
        RGB_time = imread(get_file_s1r3(ich));
        I_time = rgb2gray(RGB_time);
        I_checking = I_time - I_initial;
        for ich_in = 1:size(I_checking,1)
            for jch_in = 1:size(I_checking,2)
                if I_checking(ich_in,jch_in)>50
                    I_checking(ich_in,jch_in)=255;
                end
            end
        end
        % inverseGrayImage = uint8(255) - I_time;
        BW1 = edge(I_checking,'Prewitt');
        all_data{3,1}(ich,1) = readPoints_dist(RGB_time, 2);
    end
end

%% Strain 2, rep 1
for ich = 1:25 
    if ich == 1
        RGB_initial = imread('\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain2_rep1\2.0s_Exposure\Initial.png');
        I_initial = rgb2gray(RGB_initial);
        inverseGrayImage = uint8(255) - I_initial;
        all_data{4,1}(ich,1) = readPoints_dist(inverseGrayImage, 2);
    else 
        ich
        RGB_initial = imread('\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain2_rep1\2.0s_Exposure\Initial.png');
        I_initial = rgb2gray(RGB_initial);
        RGB_time = imread(get_file_s2r1(ich));
        I_time = rgb2gray(RGB_time);
        I_checking = I_time - I_initial;
        for ich_in = 1:size(I_checking,1)
            for jch_in = 1:size(I_checking,2)
                if I_checking(ich_in,jch_in)>50
                    I_checking(ich_in,jch_in)=255;
                end
            end
        end
        % inverseGrayImage = uint8(255) - I_time;
        BW1 = edge(I_checking,'Prewitt');
        all_data{4,1}(ich,1) = readPoints_dist(RGB_time, 2);
    end
end

%% Strain 2, rep 2
for ich = 1:24 
    if ich == 1
        RGB_initial = imread('\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain2_rep2\2.0s_Exposure\Initial.png');
        I_initial = rgb2gray(RGB_initial);
        inverseGrayImage = uint8(255) - I_initial;
        all_data{5,1}(ich,1) = readPoints_dist(inverseGrayImage, 2);
    else 
        ich
        RGB_initial = imread('\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain2_rep2\2.0s_Exposure\Initial.png');
        I_initial = rgb2gray(RGB_initial);
        RGB_time = imread(get_file_s2r2(ich));
        I_time = rgb2gray(RGB_time);
        I_checking = I_time - I_initial;
        for ich_in = 1:size(I_checking,1)
            for jch_in = 1:size(I_checking,2)
                if I_checking(ich_in,jch_in)>50
                    I_checking(ich_in,jch_in)=255;
                end
            end
        end
        % inverseGrayImage = uint8(255) - I_time;
        BW1 = edge(I_checking,'Prewitt');
        all_data{5,1}(ich,1) = readPoints_dist(RGB_time, 2);
    end
end

%% Strain 2, rep 3
for ich = 1:27 
    if ich == 1
        RGB_initial = imread('\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain2_rep3\2.0s_Exposure\Initial.png');
        I_initial = rgb2gray(RGB_initial);
        inverseGrayImage = uint8(255) - I_initial;
        all_data{6,1}(ich,1) = readPoints_dist(inverseGrayImage, 2);
    else 
        ich
        RGB_initial = imread('\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain2_rep3\2.0s_Exposure\Initial.png');
        I_initial = rgb2gray(RGB_initial);
        RGB_time = imread(get_file_s2r3(ich));
        I_time = rgb2gray(RGB_time);
        I_checking = I_time - I_initial;
        for ich_in = 1:size(I_checking,1)
            for jch_in = 1:size(I_checking,2)
                if I_checking(ich_in,jch_in)>50
                    I_checking(ich_in,jch_in)=255;
                end
            end
        end
        % inverseGrayImage = uint8(255) - I_time;
        BW1 = edge(I_checking,'Prewitt');
        all_data{6,1}(ich,1) = readPoints_dist(RGB_time, 2);
    end
end

%% Strain 3, rep 1
for ich = 1:25 
    if ich == 1
        RGB_initial = imread('\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep1\2.0s_Exposure\Initial.png');
        I_initial = rgb2gray(RGB_initial);
        inverseGrayImage = uint8(255) - I_initial;
        all_data{7,1}(ich,1) = readPoints_dist(inverseGrayImage, 2);
    else 
        ich
        RGB_initial = imread('\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep1\2.0s_Exposure\Initial.png');
        I_initial = rgb2gray(RGB_initial);
        RGB_time = imread(get_file_s3r1(ich));
        I_time = rgb2gray(RGB_time);
        I_checking = I_time - I_initial;
        for ich_in = 1:size(I_checking,1)
            for jch_in = 1:size(I_checking,2)
                if I_checking(ich_in,jch_in)>50
                    I_checking(ich_in,jch_in)=255;
                end
            end
        end
        % inverseGrayImage = uint8(255) - I_time;
        BW1 = edge(I_checking,'Prewitt');
        all_data{7,1}(ich,1) = readPoints_dist(RGB_time, 2);
    end
end

%% Strain 3, rep 2
for ich = 1:24 
    if ich == 1
        RGB_initial = imread('\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep2\2.0s_Exposure\Initial.png');
        I_initial = rgb2gray(RGB_initial);
        inverseGrayImage = uint8(255) - I_initial;
        all_data{8,1}(ich,1) = readPoints_dist(inverseGrayImage, 2);
    else 
        ich
        RGB_initial = imread('\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep2\2.0s_Exposure\Initial.png');
        I_initial = rgb2gray(RGB_initial);
        RGB_time = imread(get_file_s3r2(ich));
        I_time = rgb2gray(RGB_time);
        I_checking = I_time - I_initial;
        for ich_in = 1:size(I_checking,1)
            for jch_in = 1:size(I_checking,2)
                if I_checking(ich_in,jch_in)>50
                    I_checking(ich_in,jch_in)=255;
                end
            end
        end
        % inverseGrayImage = uint8(255) - I_time;
        BW1 = edge(I_checking,'Prewitt');
        all_data{8,1}(ich,1) = readPoints_dist(RGB_time, 2);
    end
end

%% Strain 3, rep 3
for ich = 1:25 
    if ich == 1
        RGB_initial = imread('\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\Initial.png');
        I_initial = rgb2gray(RGB_initial);
        inverseGrayImage = uint8(255) - I_initial;
        all_data{9,1}(ich,1) = readPoints_dist(inverseGrayImage, 2);
    else 
        ich
        RGB_initial = imread('\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\Initial.png');
        I_initial = rgb2gray(RGB_initial);
        RGB_time = imread(get_file_s3r3(ich));
        I_time = rgb2gray(RGB_time);
        I_checking = I_time - I_initial;
        for ich_in = 1:size(I_checking,1)
            for jch_in = 1:size(I_checking,2)
                if I_checking(ich_in,jch_in)>50
                    I_checking(ich_in,jch_in)=255;
                end
            end
        end
        % inverseGrayImage = uint8(255) - I_time;
        BW1 = edge(I_checking,'Prewitt');
        all_data{9,1}(ich,1) = readPoints_dist(RGB_time, 2);
    end
end

