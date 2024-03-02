% get image file names for all hours (Strain 3, experimental rep 3) 
function image_str = get_file_s3r3(file_num)
    switch file_num 
    case 1
        image_str = 0;
    case 2 
        image_str = '\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\00.png';
    case 3
        image_str = '\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\01.png';
    case 4 
        image_str = '\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\02.png';
    case 5 
        image_str = '\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\03.png';
    case 6 
        image_str = '\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\04.png';
    case 7 
        image_str = '\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\05.png';
    case 8 
        image_str = '\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\06.png';
    case 9 
        image_str = '\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\07.png';
    case 10 
        image_str = '\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\08.png';
    case 11 
        image_str = '\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\09.png';
    case 12
        image_str = '\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\10.png';
    case 13
        image_str = '\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\11.png';
    case 14 
        image_str = '\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\12.png';
    case 15 
        image_str = '\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\13.png';
    case 16 
        image_str = '\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\14.png';
    case 17 
        image_str = '\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\15.png';
    case 18 
        image_str = '\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\16.png';
    case 19 
        image_str = '\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\17.png';
    case 20 
        image_str = '\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\18.png';
    case 21
        image_str = '\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\19.png';
    case 22 
        image_str = '\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\20.png';
    case 23 
        image_str = '\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\21.png';
    case 24 
        image_str = '\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\22.png';
    case 25 
        image_str = '\\nestor\hannahwh\(AB) BE 310\Syn Bio\plate_images\strain3_rep3\2.0s_Exposure\23.png';
    otherwise
        out_of_bounds = 1;
    end
end