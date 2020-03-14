%data5(:,1)=[] %Eliminar las fechas
%plotmatrix(data5);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Datos circulares
data2=randn(2000,2);
%plot(data2(:,1),data2(:,2),'o');

%data2=data5(:,[1 2]);

[m, n]=size(data2);
I=[];
for i=1:m
    for j=1:m
        %I(i,j)=norm(data2(i,:)-data2(j,:)); %Norma 2
        I(i,j)=norm(data2(i,:)-data2(j,:),1); %Norma 1
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