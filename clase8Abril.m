%% R2

data = portfolioE1;
%plotmatrix(data);
[m n] = size(data);
C = cov(data);
CI = inv(C);
% Mejor metodo para calcular inversa
CIm = C\eye(n);
%Indicador del porcentaje de variabilidad explicada
R = 1-1./(diag(C).*diag(CI));

% Descomposicion espectral
A = [2 1; 1 2];
[Vector Valor] = eig(C);
Ac = Vector*Valor*Vector';
v = Vector(:,end);

% Proyeccion univariante
proy = data * v;
varianza = var(proy); % Corresponde al maximo autovalor

 D = diag(Valor);
 DO = sort(D,'descend');
 porcentaje = DO/sum(DO);
 P = cumsum(porcentaje);