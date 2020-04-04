% Factorizacion de matrices LU
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% A no simetrica
data = [ 1 2 3 6
      4 5 6 5
      7 8 9 4
      10 11 12 13];
A = cov(data);
  
[L u] = lu(A);


%% A simetrica
A = [ 1 3 5
      3 6 8
      5 8 9];
[L u] = lu(A);
% Se puede calcular cholesky
L = chol(A);

%% Utilidad de Cholesky en analitica
% Simular datos multivariantes con una estructura de dependencia
% Covarianza como matriz de hilber
col = 5;
c = hilb(col);
n = 1000;

% z ruido aleatorio independiente
z = randn(col,n);
% datos simulados = LZ, donde L es el factor de descomposicion de cholesky
L = chol(c);
L = L';
datosSimulados = L*z;
datos = datosSimulados';
% c -> poblacional
% cEstimada -> muestral
cEstimada = cov(datos);
plot(datos(:,1),datos(:,2),'o');

%% Factorizacion QR
[q r] = qr(c);

%% Factorizacion SVD
singulares = svd(c);