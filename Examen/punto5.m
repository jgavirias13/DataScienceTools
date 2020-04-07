data = portfolioE1;
[filas,columnas] = size(data);
dataBinaria = zeros(filas,columnas);
positivos = find(data>0);
dataBinaria(positivos) = 1;
ultimaColumna = dataBinaria(:,columnas);
distancias = zeros(columnas-1,1);

for i=1:(columnas-1)
    a = sum(and(dataBinaria(:,i),ultimaColumna));
    b = sum(and(dataBinaria(:,i),~ultimaColumna));
    c = sum(and(~dataBinaria(:,i),ultimaColumna));
    d = sum(and(~dataBinaria(:,i),~ultimaColumna));
    distancias(i) = pearson(a,b,c,d);
end

maximos = maxk(distancias,2);
indexmax = ismember(distancias,maximos);
parecidos = data(:,indexmax);
mu = mean(parecidos);

figure
plot(parecidos(:,1),parecidos(:,2),'o');
title('Datos originales');

% Distancia mahalanobis con covarianza habitual
covarianza = cov(parecidos);
distHabitual = mahalanobis(parecidos, covarianza, mu);
percentil90 = prctile(distHabitual,90);
rarosHabitual = find(distHabitual > percentil90);
figure
plot(parecidos(:,1),parecidos(:,2),'o');
hold on
plot(parecidos(rarosHabitual,1),parecidos(rarosHabitual,2), 'ro');
hold off
title('Outliers con covarianza habitual');
legend('Data','Outliers');


% Distancia mahalanobis con cov1para
covarianza = cov1para(parecidos);
distShrink = mahalanobis(parecidos,covarianza,mu);
percentil90 = prctile(distShrink,90);
rarosShrink = find(distShrink > percentil90);
figure
plot(parecidos(:,1),parecidos(:,2),'o');
hold on
plot(parecidos(rarosShrink,1),parecidos(rarosShrink,2), 'ro');
hold off
title('Outliers con covarianza Ledoit and Wolf');
legend('Data','Outliers');

% Distancia mahalanobis con minima curtosis
[idx,dm,promedio,covarianza] = kur_main(parecidos);
distCurtosis = mahalanobis(parecidos,covarianza,mu);
percentil90 = prctile(distCurtosis,90);
rarosCurtosis = find(distCurtosis > percentil90);
figure
plot(parecidos(:,1),parecidos(:,2),'o');
hold on
plot(parecidos(rarosCurtosis,1),parecidos(rarosCurtosis,2), 'ro');
hold off
title('Outliers con covarianza de minima curtosis');
legend('Data','Outliers');

% Outliers idx
figure
plot(parecidos(:,1),parecidos(:,2),'o');
hold on
plot(parecidos(idx==1,1),parecidos(idx==1,2), 'ro');
hold off
title('Outliers con idx de minima curtosis');
legend('Data','Outliers');


function distance = pearson(a,b,c,d)
    distance = (a*d - b*c)/sqrt((a+c)*(b+d)*(a+b)*(c+d));
end

function distance = mahalanobis(x, covarianza, mu)
    inversa = inv(covarianza);
    row= size(x,1);
    
    distance = zeros(row,1);
    for i=1:row
        xdiff = x(i,:)-mu;
        distance(i) = sqrt(xdiff*inversa*xdiff');
    end
end