% IMAGE HISTOGRAM
function [Hist, HistGraph] = Image_Histogram(input_image)
    % Menghitung dan menampilkan histogram citra grayscale 
    % dan citra berwarna dengan 256 derajat keabuan
    % INPUT: 1 input image
    % OUTPUT: histogram of input image
    
    [rows, columns, ColorChannels] = size(input_image);
    graylevel = 256;
    colorchannel = ['b', 'r', 'g'];

    Hist = zeros(graylevel, ColorChannels);
    
    % Assigning graylevel of each pixel to the Hist array
    for z_index = 1:1:ColorChannels
        for x_index = 1:1:rows
            for y_index = 1:1:columns
                Hist(input_image(x_index, y_index, z_index)+1, z_index) = Hist(input_image(x_index, y_index, z_index)+1, z_index) + 1;
            end
        end
        
        % FOR PLOTTING
        subplot(1, ColorChannels, z_index);
        HistGraph = bar(Hist(:, z_index));

        if ColorChannels > 1
            HistGraph.FaceColor = colorchannel(z_index);
        end
    end
end