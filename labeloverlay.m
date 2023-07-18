function B = labeloverlay(A, L)
    cmap = jet(max(L(:)));  % Generate a colormap for different labels
    rgb = ind2rgb(L, cmap);  % Convert label matrix to RGB image
    B = imoverlay(A, rgb);   % Overlay the RGB image onto the original image
end
