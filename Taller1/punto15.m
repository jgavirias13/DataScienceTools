% Taller 1 Punto 15
% Considere x = [1 2 3 4 5 6 7 8 9 10 11 12]. Defina b = H12x. Resuelva el
% sistema con la forma x = H−1b. Que conclusion obtiene. Busque
% alternativas para resolver el problema observado.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x = [1;2;3;4;5;6;7;8;9;10;11;12];

% Se crea la matriz de hilbert 12
n = 12;
hilber = zeros(n,n);
for i=1:n
    for j=1:n
        hilber(i,j) = 1/(i+j-1);
    end
end

b = hilber*x;

% Calculo de x habitual
xcalc = inv(hilber)*b;

% Se mejora la matriz de hilber
mu = zeros(1,n);
data = mvnrnd(mu,hilber,10000);
cov = cov1para_sam(data,hilber);
xcalcme = inv(cov)*b;

% Se usa la funcion invhilb para calcular la inversa exacta
inversa = invhilb(n);
xcalcmat = inversa * b;


% Se calcula el error en cada caso
errorcal = sum(abs(x-xcalc));
errormej = sum(abs(x-xcalcme));
errormat = sum(abs(x-xcalcmat));
