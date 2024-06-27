clear all
close all
clc
%DISEÑO DE FILTRO PASA ALTO PRIMER ORDEN 
%EN TIEMPO CONTINUO

Fc=1.5;
fprintf('Frecuencia de corte %.2f Hertz \n',Fc)

C=1000*(10^(-9)) ;
fprintf('Capacitancia %d nF \n',round(C*(10^9)))

R=1/(2*pi*C*Fc);
fprintf('Resisntecia %d Kohms \n',round(R/1000))
%crear funcion de transferencia
num=[R*C,0];
den=[R*C,1];
w=2*pi*linspace(-200,200,4000);
H=freqs(num,den,w);
Hm=abs(H);
subplot(211)
plot(w/(2*pi),Hm,'LineWidth',2)
title('FILTRO PASA ALTA')
xlabel('FRECUENCIA')
ylabel('MAGNITUD')
subplot(212)
Hdb=20*log10(Hm+0.0000001);

plot(w/(2*pi),Hdb,'LineWidth',2)
title('FILTRO PASA ALTA')
xlabel('FRECUENCIA')
ylabel('MAGNITUD')