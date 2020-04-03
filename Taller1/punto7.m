% Taller 1 Punto 7
% El fichero (porfolio100.txt) tiene rentabilidades mensuales para 100
% sectores economicos, desde julio de 1963 hasta febrero de 2019, un total
% de 668 registros. Realice un analisis de identificacion de outliers
% utilizando los tres metodos del punto anterior y el metodo de mınima
% curtosis con la salida idx. Comente los resultados.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Preparacion de la data
data = readmatrix('100_Portfolios_ME_OP_10x10_tratado.txt');
data(:,1) = [];
percentilOutlier = 80;

% Identificacion de outliers con covarianza habitual
covarianza = cov(data);
mu = mean(data);
distHabitual = mahalanobis(data, covarianza, mu);
outIndHabitual = prctile(distHabitual,percentilOutlier);
outliersHabitual = find(distHabitual>outIndHabitual);
figure
plot(data(:,1),data(:,2),'o');
hold on
plot(data(outliersHabitual,1), data(outliersHabitual,2),'ro');
title('Ouliers covarianza habitual');

% Identificacion de outliers con covarianza shrinkage
covarianza = cov1para(data);
mu = mean(data);
distShrinkage = mahalanobis(data, covarianza, mu);
outIndShrinkage = prctile(distShrinkage,percentilOutlier);
outliersShrinkage = find(distShrinkage>outIndShrinkage);
figure
plot(data(:,1),data(:,2),'o');
hold on
plot(data(outliersShrinkage,1), data(outliersShrinkage,2),'ro');
title('Outliers covarianza Shrinkage');

% Identificacion de outliers con covarianza minima curtosis
[idx, dm, mu, covarianza] = kur_main(data);
distMinCur = mahalanobis(data, covarianza, mu);
outIndMinCur = prctile(distMinCur,percentilOutlier);
outliersMinCur = find(distMinCur>outIndMinCur);
figure
plot(data(:,1),data(:,2),'o');
hold on
plot(data(outliersMinCur,1), data(outliersMinCur,2),'ro');
title('Outliers covarianza Minima Curtosis');

% Identificacion de outliers con idx en minima curtosis
figure
plot(data(:,1),data(:,2),'o');
hold on
plot(data(idx==1,1),data(idx==1,2),'ro');
title('Outliers idx Minima Curtosis');

% Distancia de Mahalanobis
function dist = mahalanobis(x, covarianza, mu)
    inversa = inv(covarianza);
    row= size(x,1);
    
    dist = zeros(row,1);
    for i=1:row
        xdiff = x(i,:)-mu;
        dist(i) = xdiff*inversa*xdiff';
    end
end