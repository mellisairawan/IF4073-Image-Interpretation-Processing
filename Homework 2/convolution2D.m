% input_image = imread('standard_test_images/flower.tif'); 
% %input_image = rgb2gray(input_image);
%  mask = [0 -1 0; 
%           -1 5 -1; 
%           0 -1 0];
%  mask = mask/sum(sum(mask));
%  [output_image, matlab_result] = convolution2D1(input_image, mask);

function [ImageResult, matlab_result] = convolution2D(input_image, mask);

    I = im2double(input_image);
    [rows, column, colorChannel] = size(I);

    [n, ~] = size(mask);
    %filter_sum = sum(sum(mask));

    %ImageResult = zeros(max([rows, column]);

    for k = 1:1:colorChannel
        for i = 2:1:(rows-n)
            for j = 2:1:(column-n)
                ImageResult(i,j,k) = (I(i-1, j-1, k) * mask(1,1)) ...
                    + (I(i-1, j, k) * mask(1,2)) ...
                    + (I(i-1, j+1, k) * mask(1,3)) ...
                    + (I(i, j-1, k) * mask(2,1)) ...
                    + (I(i, j, k) * mask(2,2)) ...
                    + (I(i, j+1, k) * mask(2,3)) ...
                    + (I(i+1, j-1, k) * mask(3,1)) ...
                    + (I(i+1, j, k) * mask(3,2)) ...
                    + (I(i+1, j+1, k) * mask(3,3));
                %ImageResult(i,j,k) = ImageResult(i,j,k)/filter_sum;
            end
        end
    end
    
    matlab_result = convn(I, mask, 'same');
    
%     subplot(1,2,1)
%     imshow(ImageResult);
%     title('Convolution result by calculation');
% 
%     subplot(1,2,2)
%     
%     imshow(matlab_result);
%     title('Convolution result by MATLAB convn function');
end