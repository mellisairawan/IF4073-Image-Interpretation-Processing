%input_image = imread('standard_test_images/mandril_color.tif');
%input_image = imread('boat.bmp');
%[EqImage, inputHist, ImageHist, cdf] = HistEq1(input_image);

% HISTOGRAM EQUALIZER
function [EqImage, input_Hist, new_imageHist, cdf] = HistEq1(input_image)
    [rows, columns, ColorChannels] = size(input_image);
    graylevel = 256;
    
    % Create histogram of input image using Image_Histogram function
    [input_Hist, HistGraph] = Image_Histogram(input_image);
    normHist = input_Hist/(rows*columns); % normalize the histogram value
    
    cdf = zeros(graylevel, ColorChannels);
    EqImage = zeros(rows, columns, ColorChannels);
    colorchannel = ['b', 'r', 'g'];

    % Cummulating pixels value
    for z_index = 1:1:ColorChannels
        cdf(1, z_index) = normHist(1, z_index);
        for x_index = 2:1:graylevel
            cdf(x_index, z_index) = cdf((x_index-1), z_index) + normHist(x_index, z_index);
        end
        cdf(:, z_index) = round(cdf(:, z_index) * (graylevel-1)); % rounding and multiplying with graylevel

        % Changing pixels of equalized image / creating the output image
        for x_index = 1:1:rows
            for y_index = 1:1:columns
                 prevgreylevel = input_image(x_index, y_index, z_index) + 1;
                 EqImage(x_index, y_index, z_index) =  cdf(prevgreylevel, 1);
            end
        end
    end
    new_imageHist = Image_Histogram(EqImage);
    
    % FOR PLOTTING
    % Input  image
    subplot(2, ColorChannels+1, 1);
    imshow(input_image);
    title('Input Image');
    
    for index = 1:1:ColorChannels
        subplot(2, ColorChannels+1, 1+index);
        HistGraph1 = bar(input_Hist(:, index));
        
        if ColorChannels > 1
            HistGraph1.FaceColor = colorchannel(index);
        end
    end
    
    % Output image
    subplot(2, ColorChannels+1, ColorChannels+2);
    imshow(uint8(EqImage));
    title('Histogram Equalization Result');
    
    for index = 1:1:ColorChannels
        subplot(2, ColorChannels+1, (ColorChannels+2)+index);
        HistGraph2 = bar(new_imageHist(:, index));
        %ylim(subplot(2, ColorChannels+1, (ColorChannels+2)+index), [0 7000]);
        if ColorChannels > 1
            HistGraph2.FaceColor = colorchannel(index);
        end
    end
        
end