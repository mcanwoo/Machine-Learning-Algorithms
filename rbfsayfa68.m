%RBF MODELLEME
clear all
close all
clc

t=[-10:1.41:8.85]';
y=[0.2297
    0.2762
    0.2254
    0.2239
    0.0991
    0.3313
    0.9591
    1.2017
    0.6974
    0.1354
    -0.0524
    0.0257
    0.4170
    0.1296]
% y=4.2+0.1*t+7.8*t.^2-1.7*t.^3;

% noise = 0.0*randn(length(y),1); %buradaki katsay� g�r�lt� katsay�s�d�r
% y=y+noise;
tmin=min(t);
tmax=max(t);

n=6; %polinomun derecesiyle oynar
N=size(t,1); %data say�m�z

c(1)=tmin+(tmax-tmin)/(2*n);
for k=2:n
    c(k) =c(k-1)+(tmax-tmin)/(n);
    
end
sigma= (tmax-tmin)/(n);

J=[];
for i=1:N
for j=1:n
    J(i,j)= -exp(-(t(i)-c(j))^2/(sigma)^2); % sayfa 67 deki form�l
end
end
x=-inv(J'*J)*J'*y %kitapta 64.sayfadaki x^* form�l�

yhat=-J*x;
e=y-yhat;
F=e'*e;


x=rand(n,1);
for k=1:2000
    yhat= -J*x;
    e=y-yhat;
    F=e'*e;
    p=-2*J'*e;
    s=0.0001;
    x=x+s*p;
    disp(F)
end
plot(t,y,'b*')
hold on
plot(t,yhat,'r')