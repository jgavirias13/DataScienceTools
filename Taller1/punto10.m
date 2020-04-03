% Taller 1 Punto 10
% Saque una foto suya y defina una sucesion de imagenes que sea
% convergente a su foto. Muestre los 10 primeros elementos de la sucesion y
% el elemento 1000-esimo. Como la sucesion de imagenes es convergente,
% obtenga la imagen tal que las imagenes siguientes de la sucesion tienen
% una distancia (en norma (1,2, ∞ y Frobenius)) menor a 0.01.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

imagenOriginal = imread('imagenPersonal.jpg');
imagenOriginal = im2double(imagenOriginal);
Rcomponent = imagenOriginal(:,:,1);
Gcomponent = imagenOriginal(:,:,2);
Bcomponent = imagenOriginal(:,:,3);

inicial = 1;
final = 10000;
distance1 = zeros(final,1);
distance2 = zeros(final,1);
distanceinf = zeros(final,1);
distancefro = zeros(final,1);

parfor i=inicial:final
    [newR, newG, newB] = agregarRuido(Rcomponent,Gcomponent,Bcomponent,i);
    newImage = cat(3,newR,newG,newB);
    [norm1, norm2, norminf, normfro] = distancias(imagenOriginal, newImage);
    distance1(i) = norm1;
    distance2(i) = norm2;
    distanceinf(i) = norminf;
    distancefro(i) = normfro;
    %imshow([imagenOriginal newImage]);
end

plot(distance1, 'r');
hold on
plot(distance2, 'b');
hold on
plot(distanceinf, 'y');
hold on
plot(distancefro, 'g');

% Funcion para distorcionar la imagen
function [newR, newG, newB] = agregarRuido(R,G,B,n)
    [row, column] = size(R);
    ruidor = cos(randn(row,column)).*randn(row,column)*10/n;
    ruidog = cos(randn(row,column)).*randn(row,column)*10/n;
    ruidob = cos(randn(row,column)).*randn(row,column)*10/n;
    newR = mat2gray(R + ruidor);
    newG = mat2gray(G + ruidog);
    newB = mat2gray(B + ruidob);
end

% Calculo de distancias
function [distance1,distance2,infinito,frobenius] = distancias(x,y)
    xyR = x(:,:,1) - y(:,:,1);
    xyG = x(:,:,2) - y(:,:,2);
    xyB = x(:,:,3) - y(:,:,3);
    distanceR = sum(norm(xyR,1));
    distanceG = sum(norm(xyG,1));
    distanceB = sum(norm(xyB,1));
    distance1 = distanceR + distanceG + distanceB;
    
    distanceR = sum(norm(xyR,2));
    distanceG = sum(norm(xyG,2));
    distanceB = sum(norm(xyB,2));
    distance2 = distanceR + distanceG + distanceB;
    
    distanceR = sum(norm(xyR,Inf));
    distanceG = sum(norm(xyG,Inf));
    distanceB = sum(norm(xyB,Inf));
    infinito = distanceR + distanceG + distanceB;
    
    distanceR = sum(norm(xyR,'fro'));
    distanceG = sum(norm(xyG,'fro'));
    distanceB = sum(norm(xyB,'fro'));
    frobenius = distanceR + distanceG + distanceB;
end