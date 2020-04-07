% Taller 1 Punto 14
% Sea Hn(i, j) = 1/(2i+2j−1), llamada la matriz de Hilbert. Realice una
% grafica de n en el eje x con el numero condicion en el eje y. Que tipo de
% comportamiento observa. Haga lo mismo para su determinante. Realice lo
% mismo utilizando el shrinkage de Ledoit and Wolf pero cambiando en la
% linea 18 de cov1para.m sample = (1/t). ∗ (x′ ∗ x); por sample = Hn.
% Compare los resultados. Haga una analsis grafico y de visualizacion donde
% se observe si al final el shrinkage mejora el numero condicion.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Se calcula la matriz de Hilbert
% Se haya el determinante y la covarianza habitual
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
    hilber = zeros(n);
    for i=1:n
        for j=1:n
            hilber(i,j) = 1/(2*i+2*j-1);
        end
    end
    determinantesHab(n) = det(hilber);
    condicionesHab(n) = cond(hilber);
    
    % Para hayar determinante y covarianza Shrinkage, se debe simular datos
    % con covarianza hilbert
    mu = zeros(1,n);
    data = mvnrnd(mu,hilber,10000);
    [cov,sr] = cov1para_sam(data,hilber);
    condicionesShr(n) = cond(cov);
    determinantesShr(n) = det(cov);
end
figure
plot(determinantesHab);
title('Determinante Habitual');
figure
plot(condicionesHab);
title('Condicion Habitual');

figure
plot(determinantesShr);
title('Determinante Shrink');

figure
plot(condicionesShr);
title('Condicion Shrink');
