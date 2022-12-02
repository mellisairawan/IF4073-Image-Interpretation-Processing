function [plate_image, noPlate] = detect_plate(im)

% Turn into grayscale
imgray = rgb2gray(im);

% Binarize 2D grayscale image (convert the image to black and white)
imbin = imbinarize(imgray, 'adaptive', 'Sensitivity', 0.4);

%imbin = imerode(imbin, strel('cube', 2));

% Detect edges using Canny
im = edge(imgray, 'canny');


% Find location of number plate in the entire image

% Return image properties
% bounding box: position and size of the car plate
% area: actual number of pixels in the region
% image: image the same size of the region
Iprops = regionprops(im, 'BoundingBox', 'Area', 'Image');
area = Iprops.Area;
count = numel(Iprops);% number of elements
maxa = area;
boundingBox = Iprops.BoundingBox;

for i = 1:count
    if maxa < Iprops(i).Area
        maxa = Iprops(i).Area;
        boundingBox = Iprops(i).BoundingBox;
    end
end

% Crop the image inside the bounding box
plate_image = imcrop(imbin, boundingBox);
[h, w] = size(plate_image);


% Locate each digits in the plate

% Return image properties
% bounding box: position and size of each digit
% area: actual number of pixels in the region
% image: image the same size of the region
Iprops = regionprops(plate_image, 'BoundingBox', 'Area', 'Image');
count = numel(Iprops);
noPlate = [];
for i = 1 : count
    ow = length(Iprops(i).Image(1, :));
    oh = length(Iprops(i).Image(:, 1));
    if ow<(h/2) & oh>(h/3)
        letter= detect_letters(Iprops(i).Image);
        noPlate = [noPlate letter];
    end
end

% Save the car plate reading result
noPlate = strjoin(noPlate);
end