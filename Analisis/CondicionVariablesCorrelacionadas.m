%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Se analiza el numero condicion de dos variables correlacionadas
% Si dos variables estan correlacionadas el numero condicion es malo
% Debido a que una explica la otra.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X = randn(100,2);
Y=[];
% Se itera agregando ruido. Las primeras iteraciones tienen mucho ruido
% A medida que va creciendo tiene menos ruido
for n=1:200
    Y = 5*X + (100/n)*randn(100,1);
    c1= corrcoef(X,Y);
    rho(n) = c1(1,2);
    C = cov(X,Y);
    con(n) = cond(C);
end

plot(con)