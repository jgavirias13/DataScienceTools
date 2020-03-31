% N es la dimension de la matriz (ancho)
n = 10;
valores = [3,6,4,1,7];
m = length(valores);
vandermonde = zeros(m,n);

for i=0:n-1
    for j=1:m
       vandermonde(j,i+1) = power(valores(j),i);
    end
end

