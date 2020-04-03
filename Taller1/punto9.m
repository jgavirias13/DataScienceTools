% Taller 1 Punto 9
% Describa y ejecute un proceso de identificacion de outliers en variables
% binarias. Utilıcelo para identificar que meses en portfolio100, version
% binario siendo 1 si hay valor positivo, son considerados meses atıpicos.
% Comparelos con los meses identificados en el punto 7.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Preparacion de la data
data = readmatrix('100_Portfolios_ME_OP_10x10_tratado.txt');
fechas = data(:,1);
data(:,1) = [];
[rows, columns] = size(data);
matrizBinaria = zeros(rows, columns);
positivos = find(data >= 0);
matrizBinaria(positivos) = 1;

% Calculo de la media

% Se calcula la media y luego se pasa a la variable binaria
media = mean(data);
mu1 = zeros(1,columns);
positivos = find(media >= 0);
mu1(positivos) = 1;

% Se calcula la distancia de todos los meses a la media
distancias = distanciaBinaria(matrizBinaria, mu1);
recorte = prctile(jaccardDistance,90);
outliers = find(jaccardDistance > jaccard90);

fechasRaras = fechas(outliers);


% Se implementa una funcion que calcula la distancia de todos los puntos
% de x a la media, siendo x y la media vectores binarios. Se utiliza
% la distancia Jaccard.
function distancia = distanciaBinaria(x, mu)
    rows = size(x,1);
    distancia = zeros(rows,1);
    
    for i=1:rows
        a = sum(and(x(i,:),mu));
        b = sum(and(x(i,:),~mu));
        c = sum(and(~x(i,:),mu));
        d = sum(and(~x(i,:),~mu));
        
        distancia(i) = jaccardC(a,b,c,d);
    end
end

% Distancia Jaccard
function distance = jaccardC(a,b,c,d)
    distance = a / (b+c+d);
end