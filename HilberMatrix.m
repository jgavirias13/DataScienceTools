determinantes = zeros(1,9);
enes = zeros(1,9);
condiciones = zeros(1,9);
for n=2:10
    hilber = zeros(n,n);
    for i=1:n
        for j=1:n
            hilber(i,j) = 1/(i+j-1);
        end
    end
    determinantes(n-1) = det(hilber);
    enes(n-1) = n;
    condiciones(n-1) = cond(hilber);
end

plot(enes,determinantes);
plot(enes,condiciones);