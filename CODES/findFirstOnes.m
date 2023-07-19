function coordinates = findFirstOnes(matrix, centerX, centerY, radius)
    [rows, cols] = size(matrix);
    coordinates = [];

    for col = 1:cols
        for row = 1:rows
            if matrix(row, col) == 1
                distance = sqrt((row - centerX)^2 + (col - centerY)^2);
                if distance > radius && row < centerY
                % if distance > radius
                    coordinates = [coordinates; row, col];
                    break;
                end
            end
        end
    end
end
