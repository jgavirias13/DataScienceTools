% Taller 1 Punto 5
% Consulte y programe el algoritmo de k− means. Programelo siendo los
% inputs, el numero de grupos, la distancia p con p = 0, 1, 2, . . . , y
% el numero de iteracciones hasta la parada. Suponga que p = 0 es la
% distancia de Mahalanobis. Simule tres muestras aleatorias de
% distribuciones normales bivariantes con distintas medias, luego haga
% un analisis de que distancia tiene un mejor desempeno para clasificar
% las muestras. (enviar codigo)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Simulacion de distribuciones bivariantes

% Matriz de n, elementos
n = [1000, 4600, 100];
% Matriz de medias
mu = [0 1; 5 5; 8 2.5];
% Correlacion de las variables
sigma1 = [1 0.3; 0.3 1];
sigma2 = [1 0.3; 0.3 1];
sigma3 = [1 0.3; 0.3 1];

distribucion1 = mvnrnd(mu(1,:), sigma1, n(1));
distribucion2 = mvnrnd(mu(2,:), sigma2, n(2));
distribucion3 = mvnrnd(mu(3,:), sigma3, n(3));

X = cat(1, distribucion1, distribucion2, distribucion3);
% plot(X(:,1),X(:,2),'o');

[assig, cent] = custKMeans(X,3,1,100000);

plot(X(assig==1,1),X(assig==1,2),'bo');
hold on
plot(X(assig==2,1),X(assig==2,2),'go');
hold on
plot(X(assig==3,1),X(assig==3,2),'co');
figure
plot(distribucion1(:,1),distribucion1(:,2),'o');
hold on
plot(distribucion2(:,1),distribucion2(:,2),'ro');
hold on
plot(distribucion3(:,1),distribucion3(:,2),'yo');

% Parametros:
% X -> Data
% k -> Numero de grupos
% p -> Distancia
%   0 - Mahalanobis
%   1 - Euclidia
% iteraciones -> Numero de iteraciones para converger
function  [assignments, centers] = custKMeans(X, k, p, iteraciones)
    invcov = inv(cov(X));
    % Seleccion de la funcion de distancia
    switch p
        % Mahal
        case 0
            funcDist = @mahalanobis;
        % Euclidia
        case 1
            funcDist = @euclidia;
        %por defecto se aplica mahalanobis
        otherwise
            invcov = inv(cov(X));
            funcDist = @mahalanobis;
    end
    

    [rows, columns] = size(X); % Se saca el size de la matriz k
    % Se crea una permutacion aleatoria del tamano de las filas de x
    promedio = mean(X);
    standar = std(X)';
    % Se sacan los primeros k elementos de la permutacion aleatoria como
    % centros
    
    centers = randn(k,columns)*standar+promedio;
    % Matriz de asigancion de cada punto al centro
	assignments = ones(1, rows);
    for iter = 1:iteraciones
        assig = assignments';
        clf
        plot(X(assig==1,1),X(assig==1,2),'bo');
        hold on
        plot(X(assig==2,1),X(assig==2,2),'go');
        hold on
        plot(X(assig==3,1),X(assig==3,2),'co');
        hold on
        plot(centers(1,1),centers(1,2),'+');
        hold on
        plot(centers(2,1),centers(2,2),'+');
        hold on
        plot(centers(3,1),centers(3,2),'+');
        
        pause(0.5);
        % guarda el total en cada columan para cada cluster
		clusterTotals = zeros(k, columns);
        % guarda el tamano de cada cluster
		clusterSizes = zeros(k, 1);
        for rowIx = 1:rows
			minDist = realmax;
			assignTo = 0;
            for centerIx = 1:k 
				% Por defecto se usa la distancia euclidiana
                % Pendiente cambiar
                dist = funcDist(X(rowIx,:)',centers(centerIx,:)',invcov);
                % Iterativamente se busca el k a donde asignar los puntos
                if dist < minDist
                    minDist = dist;
                    assignTo = centerIx;
                end
            end
			assignments(rowIx) = assignTo;

			% Keep these information to calculate cluster centers.
			clusterTotals(assignTo, :) = clusterTotals(assignTo, :) + X(rowIx, :);
			clusterSizes(assignTo) = clusterSizes(assignTo) + 1;
        end

		% En caso de que haya un cluster vacio, se recalcula un punto
		% random
        for clusterIx = 1:k
            if (clusterSizes(clusterIx) == 0)
				randomRow = round(1 + rand() * (rows - 1));
				clusterTotals(clusterIx, :) =  X(randomRow, :);
				clusterSizes(clusterIx) = 1;
            end
        end

        % Se recalculan los nuevos centros, centrandolo sobre el conjunto
        % de datos tomado
		newCenters = zeros(k, columns);
        for centerIx = 1:k 
			newCenters(centerIx, :) = clusterTotals(centerIx, : ) / clusterSizes(centerIx);
        end
	
        % Se revisa si los centros variaron
		diff = sum(sum(abs(newCenters - centers)));
        
        if diff < eps
			% Se converge antes de lelgar al maximo numero de iteraciones
            disp('converge antes');
			break;
        end
	
        % Se asignan los nuevos centros recalculados
		centers = newCenters;
    end
    
    % Se retorna los asignados como un vector
	assignments = assignments';
end

function dist = mahalanobis(x,y,invCov)
    dist = sqrt(((x-y)')*invCov*(x-y));
end

function dist = euclidia(x,y,invcov)
    dist = sqrt(sum((x-y)^2));
end