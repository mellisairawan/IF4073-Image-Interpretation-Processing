%input_image = imread('boat.bmp');
%c = 2;
%gamma = 3;

function [output_image, p1, p2] = exponential_transformation(input_image, c, gamma)
    % TRANSFORMASI PANGKAT
    % Transformasi log (s = cr^(gamma), 
    % c dan (gamma) adalah parameter input dari pengguna)
    % INPUT: 1 buah citra input, parameter "c". parameter "gamma"
    % OUTPUT: 1 buah citra keluaran
    
    %[rows, columns, ColorChannels] = size(input_image);

    double_value = im2double(input_image);

    output_image = c * double_value.^gamma;

    subplot(1, 2, 1);
    p1 = imshow(input_image);
    title('Input Image');

    subplot(1, 2, 2);
    p2 = imshow(output_image);
    title('Exponential Transformation Result');
end