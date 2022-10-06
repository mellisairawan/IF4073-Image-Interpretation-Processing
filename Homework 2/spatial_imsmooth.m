input_image = imread('standard_test_images/woman.tif'); 
%input_image = rgb2gray(input_image);

I = im2double(input_image);

mask = [0 -1 0; 
        -1 5 -1; 
        0 -1 0];

% Mean filter
mean_filter = [1 2 1;
    2 4 2;
    1 2 1];
[n, ~] = size(mean_filter);
mean_filter = mean_filter/n;

figure(1);
output_image1 = convolution2D(I, mean_filter);


% Gaussian filter
gaussian_filter = [1 2 1;
                    2 4 2;
                    1 2 1];
gaussian_filter = gaussian_filter/sum(sum(gaussian_filter));

figure(2);
output_image2 = convolution2D(I, gaussian_filter);
