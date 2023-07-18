%Pre processamento
% Passando para YCbCr
function imagem_preen = projeto_final()
imagem = imread("teste.jpg");
imagem_cinza = rgb2ycbcr(imagem);
imshow(imagem_cinza);

% Binariza a imagem
limiar = graythresh(imagem_cinza);
imagem_bin = im2bw(imagem_cinza, limiar);
imshow(imagem_bin);

% Preenche os buracos 
imagem_comp = imcomplement(imagem_bin);
imagem_preen = imfill(imagem_comp, 'holes');
imshow(imagem_preen);

%Segmentação
imagem_seg = kmeans(imagem_preen, 2);
imshow(imagem_seg);

