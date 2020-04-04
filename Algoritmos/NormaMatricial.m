% Calculo de normas matriciales
% Se hace simulacion montecarlo para simular los x cuya ||x||p = 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%A = [1 2;1 5;3 1;];
A = rand(100,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Norma 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Se coloca x como un par sen(teta) cos(teta)
% Se simulan valores aleatorios para theta
theta = 2*pi*rand(1000,1);
x = sin(theta);
y = cos(theta);

% Cada columna de X es un par x,y
X = [x y]';

% Se calculan todos los vectores AX
% Cada columan en v es un vector AX
v = A*X;
% Se calcula la norma de cada vector
n = size(v,2);
norma = zeros(1,n);
for i=1:n
    norma(i) = norm(v(:,i),2);
end

normaA = max(norma);

%%%% Valor exacto de la norma 2 %%%%

% Se coloca A como cuadrada
A2 = A'*A;
% Calculo de autovalor
valor = eig(A2);
% Maximo auto valor
lambda = max(valor);
normaAEx = sqrt(lambda);

error = abs(normaA-normaAEx);