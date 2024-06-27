clear all,close all,clc

%lectura de datos .mat
load('dato_H1.mat');
x=h;
L=length(x);
Fs=500;
Dur=L/Fs;
E=nextpow2(L);
N=2^E;

X=fft(x,N);
X=fftshift(X);
X_m=abs(X);
%Normalizar: 0-1
X_m=X_m/max(X_m);
F=linspace(-Fs/2,Fs/2,N);
plot(F,X_m);
title('ESPECTRO DE FRECUENCIA ')
xlabel('F [Hz]')
ylabel('Magnitud')
xlim([-100,100])


 
