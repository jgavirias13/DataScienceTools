% Taller 1 Punto 13
% Calcule el numero condicion de la matriz de covarianzas de portfolio100.
% Implemente alternativas para mejorarlo o reducirlo a la mitad.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Preparacion de la data
data = readmatrix('100_Portfolios_ME_INV_10x10_tratado.txt');
data(:,1) = [];

% Calculo normal de la covarianza
covarianzaHab = cov(data);
condicionHab = cond(covarianzaHab);

% Calculo de covarianza con shrink automatico
[covarianzaSh, shrink] = cov1para(data);
condicionSh = cond(covarianzaSh);

% Se busca un shrink entre el shrink automatico y 1 que sea menos de la
% mitad del numero condicion habitual
esperado = condicionHab/2;
pivote = 1;
obtenido = 1;
error = 0.00001;
while(abs(obtenido-esperado) < error)
    newShrink = (shrink + pivote)/2;
    newCovarianza = cov1para(data,newShrink);
    newCondicion = cond(newCovarianza);
    if(newCondicion > esperado)
        shrink = newShrink;
    else
        pivote = newShrink;
        obtenido = newCondicion;
    end
end