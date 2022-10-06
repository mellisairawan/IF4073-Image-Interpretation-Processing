function result_img = frequency_noise_cancelling(img, rows, cols)
    frequency_img = fft2(double(img));
    frequency_img = fftshift(frequency_img);
    
    [~, ~, d] = size(img);
    [~, len] = size(rows);

    debug = log(abs(frequency_img) + 1);
    figure; imagesc(uint8(10 * debug));
    
    for i=1:len
        for k=1:d
            frequency_img(rows(i), cols(i), k) = 0;
        end
    end
    debug = log(abs(frequency_img) + 1);
    figure; imagesc(uint8(10 * debug));

    result_img = ifftshift(frequency_img);
    result_img = ifft2(result_img);
    result_img = uint8(abs(result_img));
end