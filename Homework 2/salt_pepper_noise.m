function noise_img = salt_pepper_noise(img, probability)
    if nargin < 2
        probability = 0.1;
    end
    noise_img = img;
    [r, c] = size(img);
    for i=1:r
        for j=1:c
            roll = rand('double');
            if roll < probability
                noise_img(i, j) = noise_img(i, j) * 0;
            end
            if roll < probability/2.0
                noise_img(i, j) = noise_img(i, j) + 255;
            end
        end
    end
end