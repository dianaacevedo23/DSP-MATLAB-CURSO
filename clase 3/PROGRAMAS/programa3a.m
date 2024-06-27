clear all,close all,clc
F=10;
Fs=200;
L=256;
f=F/Fs;%10/200=1/20
%vector tiempo 
n=0:L-1;
%señal discreta
s=sin(2*pi*F*n/Fs);
%Tiempo=Numero_muestras*Ts

%Espectro de frecuencia de la señal discreta x[n]
%N:Numero de muestras del espectro de frecuencia N>=L
N=256;
%fft
X=fft(s,N);
%Magnitud
Xm=abs(X);
%k
k=0:N-1;

figure(1)
subplot(211)
stem(n,s)
title('Señal seno')
xlabel('n')
ylabel('amplitud')
 subplot(212)
stem(k,Xm)
title('DFT')
xlabel('k')
ylabel('Magnitud')
Ts=1/Fs;
%t=n*Ts
t=n*Ts

%k->F(Hz)
Fq=k*Fs/N;
%Fq=linspace(0,Fs,N);
figure(2)
subplot(211)
stem(t,s)
title('Señal seno')
xlabel('t[seg]')
ylabel('amplitud')
 subplot(212)
stem(Fq,Xm)
title('DFT')
xlabel('F[Hz]')
ylabel('Magnitud')
 