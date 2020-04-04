% Calculo de la covarianza con coeficiente de correlacion de spearman y
% kendal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


n = 10000;
col = 3;
mu = zeros(1,3);
sigma = [1 0.5 0.8
         0.5 1 0.7
         0.8 0.7 1]

P = mvnrnd(mu, sigma, n); % Distribucion normal bivariante

spearman = zeros(col);
kendal = zeros(col);
CovSp = zeros(col);
CovKnd = zeros(col);

for j=1:col
    for i=1:col
        spearman(i,j) = corr(P(:,i),P(:,j),'Type', 'Spearman');
        kendal(i,j) = corr(P(:,i),P(:,j),'Type','Kendal');
        stdi = std(P(:,i));
        stdj = std(P(:,j));
        CovSp(i,j) = spearman(i,j)*stdi*stdj;
        CovKnd(i,j) = kendal(i,j)*stdi*stdj;
    end
end

kendalCon = cond(kendal);
spearmanCond = cond(spearman);
habitualCond = cond(cov(P));

detKendal = det(kendal);
detSpearman = det(spearman);
detHabitual = det(cov(P));