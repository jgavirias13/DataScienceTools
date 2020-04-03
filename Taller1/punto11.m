% Taller 1 Punto 11
% Envıe al grupo 4 im´agenes de su rostro. Pase cada imagen a escala de
% grises. Para las cuatro normas matriciales discutidas en clase (1,2, ∞ y
% Frobenius). Calcule, con la metrica inducida por las normas, la distancia
% de cada persona a todas las personas. Defina un indicador de lejanıa del
% individuo j como el promedio de las distancias del individuo j a todos.
% Un concepto sencillo de imagen mediana serıa aquel individuo cuyo
% indicador de lejanıa es el menor. Obtenga con las cuatro metricas quien
% de ustedes es la mediana, es decir, el mas tıpico.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Preparacion de la informacion
% Se cargan todas las imagenes
rows = 378;
columns = 472;
n = 41;
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


% Se calcula la distancia entre todas las imagenes
distancia1 = zeros(n);
distancia2 = zeros(n);
distanciainf = zeros(n);
distanciafro = zeros(n);

for i=1:n
   for j=1:n
       xy = imagenes(:,:,i)-imagenes(:,:,j);
       distancia1(i,j) = norm(xy,1);
       distancia2(i,j) = norm(xy,2);
       distanciainf(i,j) = norm(xy,Inf);
       distanciafro(i,j) = norm(xy,'fro');
   end
end

% Se calcula el indicador de lejania para cada imagen
indLej1 = mean(distancia1,2);
indLej2 = mean(distancia2,2);
indLejinf = mean(distanciainf,2);
indLejfro = mean(distanciafro,2);

indmed1 = min(indLej1);
inxmed1 = find(indLej1 == indmed1);
med1 = imagenes(:,:,inxmed1);

indmed2 = min(indLej2);
inxmed2 = find(indLej2 == indmed2);
med2 = imagenes(:,:,inxmed2);

indmedinf = min(indLejinf);
inxmedinf = find(indLejinf == indmedinf);
medinf = imagenes(:,:,inxmedinf);

indmedfro = min(indLejfro);
inxmedfro = find(indLejfro == indmedfro);
medfro = imagenes(:,:,inxmedfro);

imshow([uint8(med1) uint8(med2) uint8(medinf) uint8(medfro)]);