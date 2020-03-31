%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%La mediana se calcula con un indicador de distancia
%Es el elemento que tiene menor distancia a los demas elementos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Preparacion de data
%data5(:,1)=[] %Eliminar las fechas
%plotmatrix(data5);
%data2=data5(:,[1 2]);

% Se generan datos aleatorios
data2=randn(4000,2);
plot(data2(:,1),data2(:,2),'o');

[m, n]=size(data2);
I=[];
parfor i=1:m
    for j=1:m
        I(i,j)=norm(data2(i,:)-data2(j,:)); %Aplicacion de Norma 2
        %I(i,j)=norm(data2(i,:)-data2(j,:),1); %Aplicacion de Norma 1
    end
    
end
I2=sum(I,2); %Sumar en segunda dimension
I3=prctile(I2,80); %Se toma el numero del percentil 80
I4=find(I2>I3);

if n == 2
    plot(data2(:,1),data2(:,2),'o');
    hold on
    plot(data2(I4,1),data2(I4,2),'or');
end