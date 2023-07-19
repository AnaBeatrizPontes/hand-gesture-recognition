function filteredCoordinates = filterClosePoints(coordinates, minDistance)
    % Calcular a matriz de distâncias euclidianas entre as coordenadas
    distances = pdist2(coordinates, coordinates);

    % Inicializar a matriz de índices para filtragem
    indices = false(size(distances));

    % Filtrar os pontos próximos mantendo apenas o primeiro deles
    for i = 1:size(distances, 1)
        closeIndices = find(distances(i, :) < minDistance);
        if ~isempty(closeIndices)
            indices(i, closeIndices(2:end)) = true;
        end
    end

    % Filtrar as coordenadas com base nos índices
    filteredCoordinates = coordinates;
    filteredCoordinates(any(indices, 2), :) = [];
end
