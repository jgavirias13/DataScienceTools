%% Generacion de datos aleatorios con Cholesky

function datos = GeneracionDatosAleatorios(covarianza,n)
    col = size(covarianza,2);
    % z ruido aleatorio independiente
    z = randn(col,n);
    % datos simulados = LZ, donde L es el factor de descomposicion de cholesky
    L = chol(covarianza);
    L = L';
    datosSimulados = L*z;
    datos = datosSimulados';
end