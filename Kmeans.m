x1 = randn(100,2);
x2 = 4 + randn(100,2);
X = [x1
    x2];
I = kmeans(X,2);

%Distancia de Mahalanobish
I = kmeans(data5,2);
plot(data5(:,1),data5(:,2), 'o');
d = mahal(data5(:,[1,2]),data5(:,[1,2]));
hist(d); %Sigue una distribucion chi2
P = prctile(d,99);
I = find(d > P);
plot(data5(:,1), data5(:,2),'o')
hold
plot(data5(I,1), data5(I,2),'or');


x = data5(:,1)
y = data5(:,2)
fitlm(x,y) %r-squared: Porcentaje explicado por el modelo
