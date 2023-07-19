% Passo 1: Carregar a imagem
image = imread('teste.jpg');

% Passo 2: Converter a imagem para formato adequado
image_double = double(image);

% Passo 3: Redimensionar a matriz de pixels
[m, n, ~] = size(image_double);
pixel_data = reshape(image_double, m * n, []);

% Passo 4: Executar o algoritmo k-means
K = 2;  % N?mero de clusters desejado
[idx, centroids] = kmeans(pixel_data, K);

% Passo 5: Redimensionar os ?ndices para a forma da imagem original
segmented_image = reshape(idx, m, n);

% Passo 6: Visualizar a imagem segmentada
% imshow(segmented_image, []);

% Preenche os buracos
imagem_comp = imcomplement(segmented_image);
imshow(imagem_comp, []);
imagem_preen = imfill(imagem_comp, "holes");


% Binariza a imagem
%limiar = graythresh(imagem_cinza);
%imagem_bin = im2bw(imagem_cinza, limiar);
%imshow(imagem_bin);


stats = regionprops(imagem_preen, "WeightedCentroid", "MajorAxisLength","MinorAxisLength")
diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
radii = diameters/2;

centers = stats.Centroid;
hold on
plot(centers(:,1),centers(:,2),'b*')
viscircles(centers,radii)
hold off


function localMaxima = findLocalMaxima(coordinates, fixedPoint)
    % Calcular a distancia euclidiana entre as coordenadas e o ponto fixo
    distances = pdist2(coordinates, fixedPoint);
    distances1 = sqrt((fixedPoint(1) - coordinates(1))^2 + (fixedPoint(2) - coordinates(2))^2);
    % Inicializar a matriz de maximos locais
    localMaxima = [];

    for index = 1:size(distances, 1)-1
        dist_atual = distances(index)
        prox_dist = distances(index+1)

        if (index == 1 && dist_atual > prox_dist)
            localMaxima = [localMaxima; coordinates(index, :)];
            continue
        endif

        ant_dist = distances(index-1)

        if dist_atual > ant_dist && dist_atual >= prox_dist
            localMaxima = [localMaxima; coordinates(index, :)];
        end
    end
end


