clear all,close all,clc
%programa2a) 
%lectura de datos .mat
load('dato_H1.mat');
%canal horizontal de una señal EOG
x=h;
%--------(TIMER o por software)
Fs=500;
L=length(x);
%tiempo discreto
n=0:L-1;
%periodo de muestreo
Ts=1/Fs;
%---tiempo en continuo
t=n*Ts;

Dur=L/Fs;
E=nextpow2(L);
N=2^E;
X=fft(x,N);
X=fftshift(X);
X_m=abs(X);
%Normalizar: 0-1
X_m=X_m/max(X_m);
F=linspace(-Fs/2,Fs/2,N);
figure(1)
subplot(211)
plot(t,x)
title('SEÑAL EOG : CANAL X ')
xlabel('t[seg]')
ylabel('amplitud')
subplot(212)
plot(F,X_m);
title('ESPECTRO DE FRECUENCIA ')
xlabel('F [Hz]')
ylabel('Magnitud')
xlim([-100,100])
%-----------------------ECUACION EN DIFERENCIAS ----------
% -------EJEMPLO 2(DIAPOSITIVA 1)
% h=[1/3,1/3,1/3];
% %asumir condiciones iniciales
% x_n1=0;
% x_n2=0;
% %--------vector de salida y[n] (para visualizar el efecto del filtro en la E.E.D)
% y=zeros(1,L);
% for n=1:L
%     %salida
%     y(n)=h(1)*x(n)+h(2)*x_n1+h(3)*x_n2;
%     x_n2=x_n1;
%     x_n1=x(n);
% end

% -------EJEMPLO 3(DIAPOSITIVA 1)
b=[1,0,0.2];
a=[1,0.1,0.2];
%r condiciones iniciales entrada
x_n1=0;
x_n2=0;
%condicones iniciales salida
y_n1=0;
y_n2=0;
%--------vector de salida y[n] (para visualizar el efecto del filtro en la E.E.D)
y=zeros(1,L);
for n=1:L
    %salida
    y(n)=x(n)+0.2*x_n2-0.1*y_n1-0.2*y_n2;
    x_n2=x_n1;
    x_n1=x(n);
    
    y_n2=y_n1;
    y_n1=y(n);
end

Y=fft(y,N);
Y=fftshift(Y);
Y_m=abs(Y);
%Normalizar: 0-1
Y_m=Y_m/max(Y_m);
figure(2)
subplot(211)
plot(t,y)
title('SEÑAL EOG : CANAL X FILTRADA ')
xlabel('t[seg]')
ylabel('amplitud')
subplot(212)
plot(F,Y_m);
title('ESPECTRO DE FRECUENCIA ')
xlabel('F [Hz]')
ylabel('Magnitud')
xlim([-100,100])