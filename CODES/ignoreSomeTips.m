
function localMaxima = ignoreSomeTips(coordinates, fixedPoint, topMostPoint)
    % Calcular a distancia euclidiana entre as coordenadas e o ponto fixo
    farthestPoint = pdist2(topMostPoint, fixedPoint);
    distances = pdist2(coordinates, fixedPoint)

    % Inicializar a matriz de maximos locais
    localMaxima = [];

    localMaxima = distances >= farthestPoint*0.5 ;
    [row, cols] = find(localMaxima);
    localMaxima = [row, cols];
end
