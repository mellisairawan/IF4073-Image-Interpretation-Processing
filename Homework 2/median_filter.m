function filtered_image = median_filter(img, median_row, median_col)
    % INPUT: Image as matrix, rows of filter (default 3), columns of filter (default 3)
    % OUTPUT: Matrix of filtered image
    
    % Menentukan panjang dan lebar index median filter
    if nargin < 3
        median_row = 5;
        median_col = 5;
    end
    median_row_lo = -int16((median_row-1)/2);
    median_row_hi = median_row_lo + median_row-1;
    median_col_lo = -int16((median_col-1)/2);
    median_col_hi = median_col_lo + median_col-1;

    [r, c, d] = size(img);
    filtered_image = img;
    temp_array = zeros(median_row * median_col);
    for img_i=1:r
        for img_j=1:c
            % Masukkan cell terdekat sesuai filter size ke temp_array
            for img_k=1:d
                temp_length = 0;
                for median_i = median_row_lo:median_row_hi
                    for median_j = median_col_lo:median_col_hi
                        % Cek jika index row dan col masih di dalam matrix
                        if img_i+median_i >= 1 && img_i+median_i <= r
                            if img_j+median_j >= 1 && img_j+median_j <= c
                                temp_length = temp_length+1;
                                temp_array(temp_length) = img(img_i+median_i, img_j+median_j, img_k);
                            end
                        end
                    end
                end
                % Cari median
                temp_array(1:temp_length) = sort(temp_array(1:temp_length));
                filtered_image(img_i, img_j, img_k) = temp_array(uint16(temp_length/2));
            end
        end
    end
    filtered_image = uint8(filtered_image);
end