% Taller 1 Punto 8
% En el fichero (porfolio100.txt), saque la media de cada fila, es decir
% el vector de media sera un vector de 668 × 1. Defina la variable binaria
% como 1 donde el vector de medias es positivo y cero en otro caso. Defina
% la matriz binaria que vale 1 si en portfolio100 hay un valor positivo y
% cero en otro caso. Con las metricas binarias (Pearson, Jaccard y Dice)
% identifique los 10 activos mas parecidos y los 10 menos parecidos al
% vector binario de medias.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Preparacion de la data
data = readmatrix('100_Portfolios_ME_OP_10x10_tratado.txt');
data(:,1) = [];

% Media de cada fila
filaMedias = mean(data, 2);

% Calculo del vector binario de medias
positivos = find(filaMedias >= 0);
[rows, columns] = size(data);
arregloBinarioMedias = zeros(rows,1);
arregloBinarioMedias(positivos) = 1;

% Calculo de la variable binaria de cada activo
matrizBinaria = zeros(rows, columns);
positivos = find(data >= 0);
matrizBinaria(positivos) = 1;

% Se calculan las tres distancias para cada uno de los activos
pearsonDistance = zeros(columns,1);
jaccardDistance = zeros(columns,1);
diceDistance = zeros(columns,1);
for i=1:columns
    a = sum(and(matrizBinaria(:,i),arregloBinarioMedias));
    b = sum(and(matrizBinaria(:,i),~arregloBinarioMedias));
    c = sum(and(~matrizBinaria(:,i),arregloBinarioMedias));
    d = sum(and(~matrizBinaria(:,i),~arregloBinarioMedias));
    pearsonDistance(i) = pearson(a,b,c,d);
    jaccardDistance(i) = jaccardC(a,b,c,d);
    diceDistance(i) = diceC(a,b,c);    
end

% Se sacan los 10 activos mas parecidos y menos parecidos para cada
% distancia

% pearson
pearson90 = prctile(pearsonDistance,90);
pearson10 = prctile(pearsonDistance,10);
pearson10mas = find(pearsonDistance >= pearson90);
pearson10menos = find(pearsonDistance < pearson10);

% jaccard
jaccard90 = prctile(jaccardDistance,90);
jaccard10 = prctile(jaccardDistance,10);
jaccard10mas = find(jaccardDistance > jaccard90);
jaccard10menos = find(jaccardDistance < jaccard10);

% dice
dice90 = prctile(diceDistance,90);
dice10 = prctile(diceDistance,10);
dice10mas = find(diceDistance >= dice90);
dice10menos = find(diceDistance < dice10);

% Distancia pearson
function distance = pearson(a,b,c,d)
    distance = (a*d - b*c)/sqrt((a+c)*(b+d)*(a+b)*(c+d));
end

% Distancia Jaccard
function distance = jaccardC(a,b,c,d)
    distance = a / (b+c+d);
end

% Distancia Dice
function distance = diceC(a,b,c)
    distance = 2*a / (2*a+b+c);
end