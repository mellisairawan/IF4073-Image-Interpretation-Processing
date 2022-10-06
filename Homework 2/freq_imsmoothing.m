
% input_image = imread('standard_test_images/woman.tif');
% % input_image = rgb2gray(input_image);
% filter_type = 'GHPF';
% D0 = 50;
% output_image = freq_imsmoothing1(input_image, filter_type, D0);

function output_image = freq_imsmoothing(input_image, filter_type, D0)
    I = im2double(input_image);
    clear image_pad
    clear H
    clear Fc
    clear S2
    clear figure
    [rows, columns, colorChannel] = size(input_image);

    P = 2*rows;
    Q = 2*columns;

    % Create padded image
    for k = 1:1:colorChannel
        for i = 1:P
            for j = 1:Q
                if i <= rows && j<= columns
                    image_pad(i,j,k) = I(i,j,k);
                else
                    image_pad(i,j,k) = 0;
                end
            end
        end
    end
    
%     figure(1);
%     subplot(3,3,1);
%     imshow(I);title('original image');
% 
%     subplot(3,3,2);
%     imshow(image_pad);title('padded image');

%     % Display the Fourier Spectrum
%     for k = 1:1:colorChannel
%         % move the origin of the transform to the center
%         Fc = fftshift(fft2(image_pad(:,:,1)));
% 
%         % use abs to compute the magnitude (handling imaginary)
%         % and use log to brighten display
%         S2 = log(1+abs(Fc));
% 
%         if colorChannel > 1
%             subplot(3,3,3+k);
%             imshow(S2,[]); 
%             title(['Fourier spectrum ', 'color channel ', num2str(k)]);
%         else
%             subplot(3,3,3);
%             imshow(S2,[]); title('Fourier spectrum');
%         end
%     end

    % Fourier transformation on padded image
    image_return = fft2(double(image_pad));

    % Ideal Low Pass Filter
    % D0 = 50; % cut-off frequency
    % Set up range of variables.
    u = 0:(P-1);
    v = 0:(Q-1);

    % Compute the indices for use in meshgrid
    idx = find(u > P/2);
    u(idx) = u(idx) - P;
    idy = find(v > Q/2);
    v(idy) = v(idy) - Q;

    % Compute the meshgrid arrays
    [V, U] = meshgrid(v, u);
    D = sqrt(U.^2 + V.^2); %distance

    % Create selection for filter type
    switch filter_type
        case 'ILPF'
            H = double(D <=D0);
        case 'GLPF'
            H = exp(-(D.^2)./(2*D0^2));
        case 'BLPF'
            n = 1; %default
            H = 1./(1 + (D./D0).^(2*n));
        case 'IHPF'
            H = double(D <=D0);
            H = 1 - H;
        case 'GHPF'
            H = exp(-(D.^2)./(2*D0^2));
            H = 1 - H;
        case 'BHPF'
            n = 1; %default
            H = 1./(1 + (D./D0).^(2*n));
            H = 1 - H;
        otherwise
            H = double(D <=D0); % use ILPF as default
    end

    H = fftshift(H); 
%     subplot(3, 3, 7);
%     imshow(H);title('Choosen Mask');

    % Multiple H with F
    H = ifftshift(H);
    LPF_f = H.*image_return;

    % Select only real numbers from inverse FFT of G
    LPF_f2 = real(ifft2(LPF_f)); % apply the inverse, discrete Fourier transform
    subplot(3, 3, 8); 
    imshow(LPF_f2);title('output image after inverse 2D DFT');

    % Return the image to its original size (delete the pad)
    LPF_f2 = LPF_f2(1:rows, 1:columns, :); % Resize the image to undo padding

%     subplot(3, 3, 9);
%     imshow(LPF_f2); title('output image');
    
    output_image = LPF_f2;
%     figure(2);
%     imshow(output_image);
end