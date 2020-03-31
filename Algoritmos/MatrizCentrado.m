X = randn(100,2);
Y=[];
for n=1:200
    Y = 5*X + (100/n)*randn(100,1);
    c1= corrcoef(X,Y);
    rho(n) = c1(1,2);
    C = cov([X Y]);
    con(n) = cond(C);
end

plot(con)

%%%%%%%%%%%%%%%%%%%%%%5
% Matriz de centrado

x = 10+ rand(5,2);mat
mean(x);
n = 5;
P = eye(n)-ones(n)/n;
DC = P*x;
mean(DC)