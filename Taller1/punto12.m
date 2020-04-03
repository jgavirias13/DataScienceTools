% Taller 1 Punto 12
% Con las cuatro metricas, determine quien del grupo es el mas parecido a
% usted y discuta que metrica es la mas conveniente para identificarlo.
% Ensaye introduciendo en la base un par de fotos suyas mas. Construya una
% vecindad con centro en usted y un radio tal que la vecindad tenga 5
% imagenes. Muestre las imagenes. Explique con buenos argumentos si su
% imagen es punto interior, punto frontera o punto de acumulacion del
% conjunto de imagenes del grupo.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Preparacion de la informacion
% Se cargan todas las imagenes
rows = 378;
columns = 472;
n = 40;
imagenes = zeros(rows,columns,n);
for i=1:n
    % Se carga la imagen y se convierte a gris
    nombre = strcat(string(i),'.jpeg');
    imagen = imread(nombre);
    grises = rgb2gray(imagen);
    
    % Se recalcula el tamano de la imagen para que todas sean iguales
    nuevaImagen = imresize(grises,[rows, columns]);
    imagenes(:,:,i) = nuevaImagen;
end

imagenCentral = imread('44.jpeg');
imagenCentral = rgb2gray(imagenCentral);
imagenCentral = imresize(imagenCentral,[rows, columns]);

% Se calcula las distancias para las cuatro metricas
distancia1 = zeros(n,1);
distancia2 = zeros(n,1);
distanciainf = zeros(n,1);
distanciafro = zeros(n,1);

for i=1:n
    xy = double(imagenCentral) - imagenes(:,:,i);
    distancia1(i) = norm(xy,1);
    distancia2(i) = norm(xy,2);
    distanciainf(i) = norm(xy,Inf);
    distanciafro(i) = norm(xy,'fro');
end

percentil = 12.5;

min1 = min(distancia1);
inx1 = find(distancia1==min1);
sim1 = uint8(imagenes(:,:,inx1));
vecInd = prctile(distancia1, percentil);
dist = find(distancia1 < vecInd);
vecindad1 = uint8(imagenes(:,:,dist));

min2 = min(distancia2);
inx2 = find(distancia2==min2);
sim2 = uint8(imagenes(:,:,inx2));
vecInd = prctile(distancia2, percentil);
dist = find(distancia2 < vecInd);
vecindad2 = uint8(imagenes(:,:,dist));

mininf = min(distanciainf);
inxinf = find(distanciainf==mininf);
siminf = uint8(imagenes(:,:,inxinf));
vecInd = prctile(distanciainf, percentil);
dist = find(distanciainf < vecInd);
vecindadinf = uint8(imagenes(:,:,dist));

minfro = min(distanciafro);
inxfro = find(distanciafro==minfro);
simfro = uint8(imagenes(:,:,inxfro));
vecInd = prctile(distanciafro, percentil);
dist = find(distanciafro < vecInd);
vecindadfro = uint8(imagenes(:,:,dist));

figure
imshow([sim1 sim2 siminf simfro]);

figure
imshow(vecindad1(:,:));

figure
imshow(vecindad2(:,:));

figure
imshow(vecindadinf(:,:));

figure
imshow(vecindadfro(:,:));
