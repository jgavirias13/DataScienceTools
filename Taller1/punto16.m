% Taller 1 Punto 16
% Realice lo mismo que los dos puntos anteriores pero con la matriz de
% Vandermonde en lugar que la Hilbert. Consulte que tipos de problemas
% utiles de aplicaciones matem´aticas en analıtica de datos usan la matriz
% de Vandermonde y la de Hilbert. Tiene alguna sugerencia para contribuir a
% mejorar estas aplicaciones matematicas? ya que son problemas muy mal
% condicionados.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Se calcula la matriz de Vandermonde
% El vector de coeficientes es un vector de 1..n

% Determinante y covarianza habitual
iteraciones = 8;
determinantesHab = zeros(iteraciones,1);
determinantesHab(1) = NaN;
condicionesHab = zeros(iteraciones,1);
condicionesHab(1) = NaN;

% Determinante y covarianza Shrink
determinantesShr = zeros(iteraciones,1);
determinantesShr(1) = NaN;
condicionesShr = zeros(iteraciones,1);
condicionesShr(1) = NaN;


for n=2:iteraciones
    vander = zeros(n);
    for i=1:n
        for j=1:n
            vander(i,j) = i^(j-1);
        end
    end
    determinantesHab(n) = det(vander);
    condicionesHab(n) = cond(vander);
    
    % Para hayar determinante y covarianza Shrinkage, se debe simular datos
    % con covarianza hilbert
    cova = cov1para_vander(vander, 0.035);
    condicionesShr(n) = cond(cova);
    determinantesShr(n) = det(cova);
end
% figure
% plot(determinantesHab);
% title('Determinante Habitual');
% figure
% plot(condicionesHab);
% title('Condicion Habitual');
% 
% figure
% plot(determinantesShr);
% title('Determinante Shrink');
% 
% figure
% plot(condicionesShr);
% title('Condicion Shrink');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = [1;2;3;4;5;6;7;8;9;10;11;12];

% Se crea la matriz de vander 12
n = 12;
vander = zeros(n,n);
for i=1:n
    for j=1:n
        vander(i,j) = i^(j-1);
    end
end

b = vander*x;

% Calculo de x habitual
xcalc = inv(vander)*b;

% Se mejora la matriz de vander
cov = cov1para_vander(vander,0.000000000001);
xcalcme = inv(cov)*b;


% Se calcula el error en cada caso
errorcal = sum(abs(x-xcalc));
errormej = sum(abs(x-xcalcme));
