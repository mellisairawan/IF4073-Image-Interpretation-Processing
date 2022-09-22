%input_image = imread('standard_test_images/mandril_color.tif');
%[output_image, output_Hist] = ContrastStretch(input_image);

function [output_image, output_Hist] = contrast_stretch(input_image)
    % INPUT: 1 input image
    % OUTPUT: input  image, histogram of input image, 
    % output image, histogram of output image
    
    [rows, columns, ColorChannels] = size(input_image);
    
    % Create histogram of input image using Image_Histogram function
    [input_Hist, input_HistGraph] = Image_Histogram(input_image);

    output_image = zeros(rows, columns, ColorChannels);
    graylevel = 256;
    colorchannel = ['b', 'r', 'g'];
    
    % Finding rmin and rmax for each color channels
    for z_index = 1:1:ColorChannels
        rmin = min(min(input_image(:,:,z_index)));
        rmax = max(max(input_image(:,:,z_index)));
    
        % Creating output image for each color channels
        output_image(:,:,z_index) = (input_image(:,:,z_index) - rmin) .* ((graylevel-1)/(rmax - rmin));

    end
    
    % Create histogram of output image using Image_Histogram function
    [output_Hist, output_HistGraph] = Image_Histogram(output_image);
    
    % FOR PLOTTING
    % Plotting input image
    subplot(2, ColorChannels+1, 1);
    imshow(input_image);
    title('Input Image');
    
    for index = 1:1:ColorChannels % Plotting histogram of input image
        subplot(2, ColorChannels+1, 1+index);
        HistGraph1 = bar(input_Hist(:, index));
        
        if ColorChannels > 1
            HistGraph1.FaceColor = colorchannel(index);
        end
    end
    
    % Plotting output image
    subplot(2, ColorChannels+1, ColorChannels+2);
    imshow(uint8(output_image));
    title('Contrast Stretching Result');
    
    for index = 1:1:ColorChannels % Plotting histogram of output image
        subplot(2, ColorChannels+1, (ColorChannels+2)+index);
        HistGraph2 = bar(output_Hist(:, index));
        %ylim(subplot(2, ColorChannels+1, (ColorChannels+2)+index), [0 7000]);
        if ColorChannels > 1
            HistGraph2.FaceColor = colorchannel(index);
        end
    end
    
end