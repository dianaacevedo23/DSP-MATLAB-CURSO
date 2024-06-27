clear all,close all,clc
%========ESPECIFICACIÓN EN FRECUENCIA============
Fc=30;
Fstop=60;
Fstart=20;
Fs=500;
%w=2*pi*f , f=F/Fs
wc=2*pi*Fc/Fs;
delta_w=2*pi*(Fstop-Fstart)/Fs;
%Determinar M para Blackman
M=11*pi/delta_w;
M=round(M);
%Crear el vector n
n=0:M-1;
alpha=(M-1)/2;
%1)Crear filtro ideal 
h=(wc/pi)*sinc(wc*(n-alpha)/pi);
%2)Crear Ventana Blackman
w_blackman=blackman(M);
%3)Filtro FIR a implementar
hr=h.*w_blackman';
% %=======0-pi================w<=>rad/muestra 
% %=======0-Fs/2==============F<=>Hz
% Hf=freqz(h,1,1024);
% Hm=abs(Hf);
% F=linspace(0,Fs/2,1024);
% plot(F,Hm);
%=======0-2pi================w<=>rad/muestra 
%=======0-Fs==============F<=>Hz
subplot(211)
Hf=freqz(h,1,'whole',1024);
Hm=abs(Hf);
Hm=fftshift(Hm);
F=linspace(-Fs/2,Fs/2,1024);
plot(F,Hm);
%=======0-2pi================w<=>rad/muestra 
%=======0-Fs==============F<=>Hz
subplot(212)
Hf=freqz(hr,1,'whole',1024);
Hm=abs(Hf);
Hm=fftshift(Hm);
F=linspace(-Fs/2,Fs/2,1024);
plot(F,Hm);

