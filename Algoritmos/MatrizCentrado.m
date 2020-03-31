%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matriz de centrado
%%%%%%%%%%%%%%%%%%%%%%%%%%
% La matriz de centrado es una matriz que hace que los datos se acerquen
% mas a la media. La media de una matriz centrada es 0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x = 10+ rand(5,2); % Se crea una matriz de aleatorios entre 10 y 11
media = mean(x); % Media de la matriz
n = 5; % Numero de filas
% Se crea una matriz identidad n y se le resta una matriz de unos / n
% Para crear una matriz de centrado
P = eye(n)-ones(n)/n;
% Se centra la matriz x al multiplicarla por la matriz de centrado
DC = P*x;
mediaCentrada = mean(DC) % La media centrada debe ser cero

% Se comparan los datos centrados vs los no centrados
plot(x(:,1), x(:,2), 'o')
hold on
plot(DC(:,1), DC(:,2), 'or');