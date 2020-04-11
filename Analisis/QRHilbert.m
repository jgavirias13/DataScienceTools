%% Resolucion de sistema de ecuacion Hilbert con QR

dim = 10;
h = hilb(dim);
ones15 = ones(dim,1);
b = zeros(dim,1,100);
x = zeros(dim,1,100);
xcalc = zeros(dim,1,100);
error = zeros(100,1);

[Q,R] = qr(h);

% Se mejora hilbert
xcalcmej = zeros(dim,1,100);
errormej = zeros(100,1);

for n=1:100
    x(:,:,n) = n*ones15;
    b(:,:,n) = h*x(:,:,n);
    xcalc(:,:,n) = inv(h)*b(:,:,n);
    
    y = Q'*b(:,:,n);
    xcalcmej(:,:,n) = inv(R)*y;
    error(n) = norm(x(:,:,n)-xcalc(:,:,n),2);
    errormej(n) = norm(x(:,:,n)-xcalcmej(:,:,n),2);
end

legend1 = 'Hilbert';
legend2 = 'QR';

figure
plot(error);
title('Normal Hilbert');

figure
plot(errormej);
title('QR Hilbert');

figure
plot(error);
hold on
plot(errormej);
hold off
title('Hilbert vs QR hilbert');
legend(legend1,legend2);
