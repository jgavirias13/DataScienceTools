% Taller 1 Punto 6
% Programe la distancia de Mahalanobis utilizando la covarianza habital,
% luego la covarianza bajo el shrinkage de Ledoit and Wolf. (cov1para.m),
% y la covarianza y vector de medias robustos obtenida bajo el metodo de
% mınima curtosis (kurmain.m). Ilustre ejemplos concretos donde el
% shrinkage y el metodo robusto presenta un mejor rendimiento y comente
% los resultados.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% Preparacion de la data
n = 10000;
mu = [0.5 0.7];
sigma = [1 0.9; 0.9 1];
x = mvnrnd(mu, sigma, n);
plot(x(:,1),x(:,2),'o');

% Distancia con covarianza habitual
covarianza = cov(x);
mu = mean(x);
distHabitual = mahalanobis(x, covarianza, mu);

% Distancia con covarianza shrinkage
covarianza = cov1para(x);
mu = mean(x);
distShrinkage = mahalanobis(x, covarianza, mu);

% Distancia con covarianza minima curtosis
[idx, dm, mu, covarianza] = kur_main(x);
distMinCur = mahalanobis(x, covarianza, mu);

function dist = mahalanobis(x, covarianza, mu)
    inversa = inv(covarianza);
    row= size(x,1);
    
    dist = zeros(row,1);
    for i=1:row
        xdiff = x(i,:)-mu;
        dist(i) = xdiff*inversa*xdiff';
    end
end