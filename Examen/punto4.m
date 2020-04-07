n = 50;
a = zeros(3,3,n);
amej = zeros(3,3,n);
condicion = zeros(n,1);
condicionmej = zeros(n,1);
determinante = zeros(n,1);
determinantemej = zeros(n,1);

for i=1:n
    a(:,:,i) = [1 2 3
        2+(2/(i^2)) 4+(1/(2*i^2)) 6+(1/(3*i^2))
        3+(1/(i+3)) 6+(1/(2*i+6)) 9+(1/(3*i+9))];
    amej(:,:,i) = cov1para(a(:,:,i), 0.5);
    condicion(i) = cond(a(:,:,i));
    condicionmej(i) = cond(amej(:,:,i));
    determinante(i) = det(a(:,:,i));
    determinantemej(i) = det(amej(:,:,i));
end

figure
plot(condicion)
title('Numero condicion habitual');

figure
plot(determinante)
title('Determinante habitual');

figure
plot(condicionmej)
title('Numero condicion con Shrink');

figure
plot(determinantemej)
title('Determinante con Shrink');

figure
plot(condicion);
hold on
plot(condicionmej);
hold off
title('Numero condicion')
legend('Condicion habitual','Condicion Shrink');

figure
plot(determinante);
hold on
plot(determinantemej);
hold off
title('Determinante');
legend('Determinante habitual','Determinante Shrink');