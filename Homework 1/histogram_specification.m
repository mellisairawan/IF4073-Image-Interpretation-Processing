% IMAGE SPECIFICATION (CODE 3 COLOR CHANNELS)
%input_image = imread('standard_test_images/lena_color_512.tif');
%reff_image = imread('standard_test_images/mandril_color.tif');
%[OutputImage, OutputHist] = HistSpec(input_image, reff_image);

function [OutputImage, OutputHist] = histogram_specification(input_image, reff_image)
    % IMAGE SPECIFICATION
    % INPUT: 1 input image, 1 refference image
    % OUTPUT: 
    % input image, histogram of input  image
    % refference image, histogram of refference image
    % 1 output image, histogram of output image
    graylevel = 256;
    colorchannel = ['b', 'r', 'g'];

    [rows1, columns1, ColorChannels] = size(input_image);
    [EqInput, input_imhist, Eqinput_imhist, input_cdf] = HistEq(input_image);


    [rows2, columns2, ColorChannels2] = size(reff_image);
    [EqReff, reff_imhist, Eqreff_imhist, reff_cdf] = HistEq(reff_image);

    InvData = zeros(rows2, 3, ColorChannels);
    OutputImage = zeros(rows1, columns1, ColorChannels);
    
    for z_index = 1:1:ColorChannels
        for xinput_index = 1:1:graylevel
            minval = abs(input_cdf(xinput_index, z_index) - reff_cdf(1, z_index));
            minj = 0;

            for xreff_index = 1:1:graylevel
                if abs(input_cdf(xinput_index, z_index) - reff_cdf(xreff_index, z_index)) < minval
                    minval = abs(input_cdf(xinput_index, z_index) - reff_cdf(xreff_index, z_index));
                    minj = xreff_index;
                end
            end

            InvData(xinput_index, 1, z_index) = input_cdf(xinput_index, z_index);
            InvData(xinput_index, 2, z_index) = minj;
            InvData(xinput_index, 3, z_index) = input_imhist(xinput_index, z_index);

        end


        for x_index = 1:1:rows1
            for y_index = 1:1:columns1
                prevgreylevel = input_image(x_index, y_index, z_index) + 1;
                OutputImage(x_index, y_index, z_index) =  InvData(prevgreylevel, 2, z_index);
            end
        end
    end

    %figure(3)
    %imshow(uint8(OutputImage));
    %figure(4)
    [OutputHist, OutputHistGraph] = Image_Histogram(OutputImage);
    
    % FOR PLOTTING
    % Plotting input  image
    subplot(3, ColorChannels+1, 1);
    imshow(input_image);
    title('Input Image');
    
    for index = 1:1:ColorChannels
        subplot(3, ColorChannels+1, 1+index);
        HistGraph1 = bar(input_imhist(:, index));
        
        if ColorChannels > 1
            HistGraph1.FaceColor = colorchannel(index);
        end
    end

    
    % Plotting refference  image
    subplot(3, ColorChannels+1, 1+(ColorChannels+1));
    imshow(reff_image);
    title('Refference Image');
    
    for index = 1:1:ColorChannels
        subplot(3, ColorChannels+1, 1+(ColorChannels+1)+index);
        HistGraph2 = bar(reff_imhist(:, index));
        
        if ColorChannels > 1
            HistGraph2.FaceColor = colorchannel(index);
        end
    end
    
    % Ploting output image
    subplot(3, ColorChannels+1, 1+2*(ColorChannels+1));
    imshow(uint8(OutputImage));
    title('Image Specification Result')
    
    for index = 1:1:ColorChannels
        subplot(3, ColorChannels+1, 1+2*(ColorChannels+1)+index);
        HistGraph3 = bar(OutputHist(:, index));
        %ylim(subplot(2, ColorChannels+1, (ColorChannels+2)+index), [0 7000]);
        if ColorChannels > 1
            HistGraph3.FaceColor = colorchannel(index);
        end
    end
end