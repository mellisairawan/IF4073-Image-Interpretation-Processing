% input_image = imread('standard_test_images/boat.bmp');
% a = 1.2;
% b = 120;
% image_brightening(input_image, a, b);

function [output_image, p1, p2] = image_brightening(input_image, a, b)
    % IMAGE BRIGHTENING
    % Image brightening s = r + b dan s = ar + b 
    % a dan b adalah parameter input dari pengguna)
    % INPUT: 1 buah citra input, parameter "a", parameter "b"
    % OUTPUT: 1 buah citra keluaran
    
    %[rows, columns, ColorChannels] = size(input_image);

    output_image =  a * input_image + b;

    subplot(1, 2, 1);
    p1 = imshow(input_image);
    title('Input Image');
    
    subplot(1, 2, 2);
    p2 = imshow(output_image);
    title('Image Brightening Result');
end