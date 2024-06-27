clear all,close all,clc
%'default':generar una secuencia aleatoria  'predecible' 
%'shuffle':generar una secuencia aleatoria distinta
rng('default');
%==========RUIDO BLANCO GAUSSIANO========
sdv=0.15;
power=10*log10(sdv^2);
N=200;
power=-3;
v=wgn(N,1,power);
mu=mean(v);%Media de la se?al de ruido
varv=var(v);%Potencia de la se?al de ruido en Wats
%=========SE?AL DESEADA s[n]================
F=50;
Fs=1000;
n=0:N-1;
s=sin(2*pi*F*n/Fs)';
%=========SE?AL RECIBIDA x[n]================
x=s+v;
%-----------------------PLOTEO------------------
figure()
subplot(311)
plot(n/Fs,s);
ylim([-0.5+min(s),0.5+max(s)])
title('s[n]','FontSize',18)

subplot(312)
plot(n/Fs,x);
ylim([-0.5+min(x),0.5+max(x)])
title('x[n]=s[n]+v[n]','FontSize',18)
%======================M:Orden del filtro FIR wiener============
M=37;
%===================== rx: vector de autocorrelaci?n de x=====
rx=xcorr(x,M);
rx=rx(M+1:2*M+1);
%========================Rx:Matriz de autocorrelaci?n======
Rx=toeplitz(rx);
%=======================rsx: vector de correlaci?n cruzada  entre s y x==============
rsx=xcorr(s,x,M);
rsx=rsx(M+1:2*M+1);
%==========================Soluci?n optima===================
if(rank(Rx)==M+1)
disp('===POSEE INVERSA===')
w=inv(Rx)*rsx ;
w_wiener=w;
%=======ALMACENAR EL FILTRO WIENER EN ARCHIVO .MAT===
save ('mi_filtro_wiener.mat','w_wiener');
else
disp('===NO POSEE INVERSA===')
end
%====================== Aplicaci?n del filtrado sobre la se?al x===========

y=filter(w,1,x);
subplot(313)
plot(n/Fs,y);
ylim([-0.5+min(y),0.5+max(y)])
title('y[n]: Salida del filtro Wiener FIR','FontSize',18)

figure(2)
Ndft=2^nextpow2(length(s));
F=linspace(-Fs/2,Fs/2,Ndft);
%========================DFT se?al s
SF=fft(s,Ndft);
SF=fftshift(SF);
SF_m=abs(SF);
subplot(311)
plot(F,SF_m)
title('S[F]','FontSize',18)

%========================DFT se?al x
XF=fft(x,Ndft);
XF=fftshift(XF);
XF_m=abs(XF);
subplot(312)
plot(F,XF_m)
title('X[F]=S[F]+V[F]','FontSize',18)

%========================DFT se?al y
YF=fft(y,Ndft);
YF=fftshift(YF);
YF_m=abs(YF);
subplot(313)
plot(F,YF_m)
title('Y[F]: SE?AL FILTRADA','FontSize',18)
