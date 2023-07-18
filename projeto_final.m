function imagem_preen = projeto_final()
image = imread('teste.jpg');
imagem_cinza = rgb2ycbcr(image);

% Binariza a imagem
limiar = graythresh(imagem_cinza);
imagem_bin = im2bw(imagem_cinza, limiar);

% Preenche os buracos
imagem_comp = imcomplement(imagem_bin);
imshow(imagem_comp, []);
imagem_preen = imfill(imagem_comp, "holes");
imshow(imagem_preen);

% Verificar orientação da imagem
leftMostPoint = [];
rightMostPoint = [];
topMostPoint = [];
bottomMostPoint = [];

% Buscar o pixel mais a esquerda
for col = 1:size(imagem_preen, 2)
    for row = 1:size(imagem_preen, 1)
        if imagem_preen(row, col) == 1
            leftMostPoint = [row, col];
            break;
        end
    end
    if ~isempty(leftMostPoint)
        break;
    end
end

% Buscar o pixel mais a direira
for col = size(imagem_preen, 2):-1:1
    for row = 1:size(imagem_preen, 1)
        if imagem_preen(row, col) == 1
            rightMostPoint = [row, col];
            break;
        end
    end
    if ~isempty(rightMostPoint)
        break;
    end
end

% Buscar o pixel mais ao topo
for row = 1:size(imagem_preen, 1)
    for col = leftMostPoint(2):rightMostPoint(2)
        if imagem_preen(row, col) == 1
            topMostPoint = [row, col];
            break;
        end
    end
    if ~isempty(topMostPoint)
        break;
    end
end

% Buscar o pixel mais baixo
for row = size(imagem_preen, 1):-1:1
    for col = leftMostPoint(2):rightMostPoint(2)
        if imagem_preen(row, col) == 1
            bottomMostPoint = [row, col];
            break;
        end
    end
    if ~isempty(bottomMostPoint)
        break;
    end
end

% Cálculo para Identificando da horientação

% Cálculo das distâncias
heigth = pdist([topMostPoint;bottomMostPoint],'euclidean');
width = pdist([leftMostPoint;rightMostPoint],'euclidean');

if (heigth/width)>1
  disp("Vertical")
else
  disp("Horizontal")
  % J = imrotate(I,1);
end

% Encontrar dedão
% 0, 0 ,0 => none
% 0, 0, 1 => rigth
% 1, 0, 0 => left
thumb = [0, 0 ,0];

offset = 15;

leftArea = imagem_preen(topMostPoint(1):bottomMostPoint(1), leftMostPoint(2):leftMostPoint(2)+offset);
rigthArea = imagem_preen(topMostPoint(1):bottomMostPoint(1), rightMostPoint(2)-offset:rightMostPoint(2));

% Contagem de pixels brancos na imagem binarizada
totalWhitePixels = sum(imagem_preen(:) == 1)
leftWhitePixels = sum(leftArea(:) == 1)
rigthWhitePixels = sum(rigthArea(:) == 1)
whitePixelLimit = totalWhitePixels * 0.07

% Definindo posição do dedão
if (leftWhitePixels > whitePixelLimit && rigthWhitePixels > whitePixelLimit)
  disp("No thumb")
elseif (leftWhitePixels < whitePixelLimit && rigthWhitePixels < whitePixelLimit)
  disp("No thumb")
elseif (leftWhitePixels < whitePixelLimit)
  thumb = [1, 0 ,0];
  disp("To the left")
else (leftWhitePixels < whitePixelLimit)
  thumb = [0, 0 ,1];
  disp("To the rigth")
end

% Encontrando a centroid
% Calcular os momentos da imagem
props = regionprops(imagem_preen, 'Area', 'Centroid', "MajorAxisLength","MinorAxisLength");

% Props para o plot do círculo
diameters = mean([props.MajorAxisLength props.MinorAxisLength],2);
radii = diameters/2;

% Calcular o centroide ponderado
centroid = zeros(1, 2);
totalArea = sum([props.Area]);
for i = 1:numel(props)
    centroid = centroid + props(i).Area * props(i).Centroid;
end
weightedCentroid = centroid / totalArea;

% Exibir o centroide ponderado
disp(['Weighted Centroid: (' num2str(weightedCentroid(1)) ', ' num2str(weightedCentroid(2)) ')']);

hold on
plot(weightedCentroid(:,1),weightedCentroid(:,2),'b*')
viscircles(weightedCentroid,radii)
hold off

