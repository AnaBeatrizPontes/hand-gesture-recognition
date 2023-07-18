function imagem_preen = projeto_final()
% Passo 1: Carregar a imagem
image = imread('teste.jpg');

% Passo 2: Converter a imagem para formato adequado
image_double = double(image);

% Passo 3: Redimensionar a matriz de pixels
[m, n, ~] = size(image_double);
pixel_data = reshape(image_double, m * n, []);

% Passo 4: Executar o algoritmo k-means
K = 2;  % Número de clusters desejado
[idx, centroids] = kmeans(pixel_data, K);

% Passo 5: Redimensionar os índices para a forma da imagem original
segmented_image = reshape(idx, m, n);

% Passo 6: Visualizar a imagem segmentada
% imshow(segmented_image, []);

% Preenche os buracos
imagem_comp = imcomplement(segmented_image);
imagem_preen = imfill(imagem_comp, "holes");
imshow(imagem_preen, []);
