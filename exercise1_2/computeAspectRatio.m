function aRatio = computeAspectRatio(image)
    [num_rows, num_cols] = size(image);

    % Find the indices of non-zero pixels
    [rows, cols] = find(image);

    % Compute the minimum bounding rectangle that encloses the digit
    min_row = min(rows);
    max_row = max(rows);
    min_col = min(cols);
    max_col = max(cols);
    height = max_row - min_row+1;
    width = max_col - min_col+1;
    % Compute the aspect ratio as the ratio of width to height
    aRatio = width/height;
end



