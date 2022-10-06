function frequency_img = spatial_to_frequency(spatial_img)
    frequency_img = fft2(double(spatial_img));
    frequency_img = fftshift(frequency_img);
    frequency_img = abs(frequency_img);
    frequency_img = log(frequency_img+1);
end