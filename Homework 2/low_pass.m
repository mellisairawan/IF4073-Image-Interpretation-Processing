function low_pass_img = low_pass(img, conv_row, conv_col)
    % INPUT image matrix, jml baris dan colom dari matrix convolusi (default 5,5)
    % OUTPUT matrix low_pass_image
    
    % Menentukan panjang dan lebar index smoothing filter
    if nargin < 3
        conv_row = 5;
        conv_col = 5;
    end
    conv_row_lo = -uint8((conv_row-1)/2);
    conv_row_hi = conv_row_lo + conv_row - 1;
    conv_col_lo = -uint8((conv_col-1)/2);
    conv_col_hi = conv_col_lo + conv_col - 1;
    div = conv_row*conv_col;

    [r, c] = size(img);
    low_pass_img = double(img * 0.0);
    
    for img_i=1:r
        for img_j=1:c
            % Convolute dengan cell sekitar
            for conv_i=conv_row_lo:conv_row_hi
                for conv_j=conv_col_lo:conv_col_hi
                    % Cek apakah cell sekitar punya index valid
                    if img_i+int16(conv_i) >= 1 && img_i+int16(conv_i) <= r
                        if img_j+int16(conv_j) >= 1 && img_j+int16(conv_j) <= c
                            low_pass_img(img_i, img_j) = low_pass_img(img_i, img_j) + double(img(img_i+int16(conv_i), img_j+int16(conv_j)))/div;
                        end
                    end
                end
            end
        end
    end
    
end