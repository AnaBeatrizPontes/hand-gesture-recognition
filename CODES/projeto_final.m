function imagem_preen = projeto_final()
image = imread('../teste8.jpg');
imagem_cinza = rgb2ycbcr(image);

% Binariza a imagem
limiar = graythresh(imagem_cinza);
imagem_bin = im2bw(imagem_cinza, limiar);

% Preenche os buracos
imagem_comp = imcomplement(imagem_bin);
imagem_preen = imfill(imagem_comp, "holes");
imshow(imagem_preen);

% Verificar orientacaoo da imagem
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

% Calculo para Identificando da horientacaoo

% Calculo das distancias
heigth = pdist([topMostPoint;bottomMostPoint],'euclidean');
width = pdist([leftMostPoint;rightMostPoint],'euclidean');

if (heigth/width)>1
  disp("Orientation: Vertical");
else
  disp("Não foi possívelaplicar rotação ");
  return
end

% Encontrar dedao
% 0, 0, 0, 0, 0 => none
% 1, 0, 0, 0, 0 => rigth
% 1, 0, 0, 0, 0 => left
fingers = [0, 0, 0, 0, 0];

offset = 15;

leftArea = imagem_preen(topMostPoint(1):bottomMostPoint(1), leftMostPoint(2):leftMostPoint(2)+offset);
rigthArea = imagem_preen(topMostPoint(1):bottomMostPoint(1), rightMostPoint(2)-offset:rightMostPoint(2));

% Contagem de pixels brancos na imagem binarizada
totalWhitePixels = sum(imagem_preen(:) == 1)
leftWhitePixels = sum(leftArea(:) == 1)
rigthWhitePixels = sum(rigthArea(:) == 1)
whitePixelLimit = totalWhitePixels * 0.07

% Definindo posicaoo do dedao
if (leftWhitePixels > whitePixelLimit && rigthWhitePixels > whitePixelLimit)
  disp("No thumb")
elseif (leftWhitePixels < whitePixelLimit && rigthWhitePixels < whitePixelLimit)
  disp("No thumb")
elseif (leftWhitePixels < whitePixelLimit)
  fingers = [1, 0, 0, 0, 0];
  disp("Thumb: To the left")
else (leftWhitePixels < whitePixelLimit)
  fingers = [1, 0, 0, 0, 0];
  disp("Thumb: To the rigth")
end

% Encontrando a centroid
% Calcular os momentos da imagem
props = regionprops(imagem_preen, 'Area', 'Centroid', "MajorAxisLength","MinorAxisLength");

% Props para o plot do circulo
diameters = mean([props.MajorAxisLength props.MinorAxisLength],2);
radii = diameters/2;

% Calcular o centroide ponderado
centroid = zeros(1, 2);
totalArea = sum([props.Area]);
for i = 1:numel(props)
    centroid = centroid + props(i).Area * props(i).Centroid;
end
weightedCentroid = centroid / totalArea;

% Procurando pelos dedos na imagem
 pos = findFirstOnes(imagem_preen, fix(weightedCentroid(2)), fix(weightedCentroid(1)), radii);
 coord = findLocalMaxima(pos, [fix(weightedCentroid(1)), fix(weightedCentroid(2))]);
 image_seg = filterClosePoints(coord, 3);
 qtde_final_dedos = size(image_seg)(:,1)

% Exibir o centroide ponderado e os pontos na imagem
disp(['Weighted Centroid: (' num2str(fix(weightedCentroid(1))) ', ' num2str(fix(weightedCentroid(2))) ')']);
hold on
  plot(weightedCentroid(:,1),weightedCentroid(:,2),'b*')
  scatter(pos (:,2),pos (:,1), "r", "filled") % pontos vermelhos sao os candidatos a topo
  scatter(coord (:,2),coord (:,1), "y", "filled") % topos amarelos sao os pontos que geraram duvida
  scatter(image_seg (:,2),image_seg (:,1), "g", "filled") % pontos verdes na imagem correspondem aos dedos encontrados
  viscircles(weightedCentroid,radii)
hold off
