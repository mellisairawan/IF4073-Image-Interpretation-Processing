function rgb = gray_to_rgb(gray)
    [r, c, d] = size(gray);
    if d==1
        rgb = zeros(r, c, 3);
        for i=1:r
            for j=1:c
                for k=1:3
                    rgb(i, j, k) = rgb(i, j, k) + gray(i, j);
                end
            end
        end
        rgb = uint8(rgb);
    else
        rgb = uint8(gray);
    end
end