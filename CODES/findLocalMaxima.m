
function localMaxima = findLocalMaxima(coordinates, fixedPoint)
    % Calcular a distancia euclidiana entre as coordenadas e o ponto fixo
    distances = pdist2(coordinates, fixedPoint);

    % Inicializar a matriz de maximos locais
    localMaxima = [];

    for index = 2:size(distances, 1)-1
        dist_atual = distances(index);
        prox_dist = distances(index+1);
        ant_dist = distances(index-1);

        if ((index == 2 && (dist_atual > prox_dist)))
            localMaxima = [localMaxima; coordinates(index, :)];
            continue
        endif

        if (dist_atual > prox_dist && dist_atual > ant_dist )
            localMaxima = [localMaxima; coordinates(index, :)];
        end
    end
end
