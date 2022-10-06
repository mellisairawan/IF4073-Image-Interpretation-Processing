function high_boost_img = high_boost(img, a, conv_row, conv_col)
    % INPUT image matrix, koefisien highboost >= 1, ukuran konvolusi lowpass
    % OUTPUT matrix highboost image

    % Nilai default
    if nargin < 2
        a = 1.0;
    end
    if nargin < 4
        conv_row = 5;
        conv_col = 5;
    end

    low_pass_img = low_pass(img, conv_row, conv_col);
    high_boost_img = double(img) * a - low_pass_img;
    high_boost_img = uint8(high_boost_img);
end