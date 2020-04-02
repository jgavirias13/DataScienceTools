% Taller 1 Punto 4
% Simule 10000 aleatorios de una distribucion Normal bivariante.
% Para cada una de las metricas de la diapositiva 26, calcule todas las
% distancias de cada dato a su media. Pinte de rojo los puntos cuya
% distancia a la media se encuentra en el 10 % de las mayores distancias.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = 10000;
mu = [0 0]; % Media
sigma = [1 0.75; 0.75 1]; % Correlacion de las variables
P = mvnrnd(mu, sigma, n); % Distribucion normal bivariante
I = zeros(n);

% Se recorren todos los elementos de P para calcular su distancia a la
% media
for i=1:n
    I(i) = terceraMetrica(P(i,:),mu);
end

% Se saca el 10% mas raros
percentil90 = prctile(I,90);
raros = find(I > percentil90);

plot(P(:,1),P(:,2),'o');
hold on
plot(P(raros,1),P(raros,2),'ro');

% Primera metrica
% No aplica debido a que P esta definido en R2 y la metrica esta definida
% para R

% Segunda metrica
% No aplica debido a que P esta definido en R2 y la metrica esta definida
% para R

% Tercera metrica
% Se define una funcion que calcula la distancia para x,y pertenecientes a
% R2
function d = terceraMetrica(x, y)
   x1 = x(1,1);
   x2 = x(1,2);
   y1 = y(1,1);
   y2 = y(1,2);
   
   sumaX = x1^2 + x2^2;
   sumaY = y1^2 + y2^2;
   
   if sumaX == sumaY
       d = sqrt((x1 - y1)^2 + (x2 -y2)^2);
   else
       d = sqrt(x1^2 + x2^2) + sqrt(y1^2 + y2^2);
   end
end

% Cuarta metrica
% No aplica debido a que P esta definido en R2 y la metrica esta definida
% para N