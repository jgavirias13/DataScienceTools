% Taller 1 Punto 6
% Programe la distancia de Mahalanobis utilizando la covarianza habital,
% luego la covarianza bajo el shrinkage de Ledoit and Wolf. (cov1para.m),
% y la covarianza y vector de medias robustos obtenida bajo el metodo de
% mınima curtosis (kurmain.m). Ilustre ejemplos concretos donde el
% shrinkage y el metodo robusto presenta un mejor rendimiento y comente
% los resultados.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





function dist = mahalanobis(x, cov, mu)
    invCov = inv(cov);
    dist = sqrt(((x-y)')*invCov*(x-y));
end