h = hilb(15);
ones15 = ones(15,1);
b = zeros(15,1,100);
x = zeros(15,1,100);
xcalc = zeros(15,1,100);
error = zeros(100,1);

% Se mejora hilbert
hmejorada = cov1para(h,0.0005);
xcalcmej = zeros(15,1,100);
errormej = zeros(100,1);

for n=1:100
    x(:,:,n) = n*ones15;
    b(:,:,n) = h*x(:,:,n);
    xcalc(:,:,n) = inv(h)*b(:,:,n);
    xcalcmej(:,:,n) = inv(hmejorada)*b(:,:,n);
    error(n) = norm(x(:,:,n)-xcalc(:,:,n),2);
    errormej(n) = norm(x(:,:,n)-xcalcmej(:,:,n),2);
end

legend1 = 'Hilbert';
legend2 = 'Shrink Hilbert';

figure
plot(error);
title('Normal Hilbert');

figure
plot(errormej);
title('Shrink Hilbert');

figure
plot(error);
hold on
plot(errormej);
hold off
title('Hilbert vs Shrink hilbert');
legend(legend1,legend2);
