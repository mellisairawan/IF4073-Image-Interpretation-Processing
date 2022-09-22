% input_image = imread('boat.bmp');
% c = 3;

function [output_image, p1, p2] = log_transformation(input_image, c)
    % TRANSFORMASI LOG 
    % Transformasi log (s = c log(1 + r), 
    % c dan r adalah parameter input dari pengguna)
    % INPUT: 1 buah citra input, parameter "c"
    % OUTPUT: 1 buah citra keluaran
    
    %[rows, columns, ColorChannels] = size(input_image);

    double_value = im2double(input_image);

    output_image = c * log(1 + double_value);

    subplot(1, 2, 1);
    p1 = imshow(input_image);
    title('Input Image');

    subplot(1, 2, 2);
    p2 = imshow(output_image);
    title('Log Transformation Result');
end