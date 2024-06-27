clear all,close all,clc
%=========APLICACION DEL FILTRO WIENER SOBRE UNA SE?AL=============
%'shuffle':generar una secuencia aleatoria distinta
 rng('default');
%==========RUIDO BLANCO GAUSSIANO========
sdv=0.15;
power=10*log10(sdv^2);
N=300;
power=-8;
%===========SE?AL DE RUIDO x[k]==========
v=wgn(N,1,power);
%===========SE?AL 

mu=mean(v);%Media de la se?al de ruido
Pv=var(v);%Potencia de la se?al de ruido en Wats
%=========SE?AL DESEADA s[n]================
F1=250;
F2=250;
F=200;
Fs=1000;
n=0:N-1;
%==========SE?AL DE INFORMACION==========
s=sin(2*pi*F*n/Fs)';
Ps=sum(s.^2)/N;
%=========SE?AL RECIBIDA x[n]================
x=s+v;
figure()
subplot(311)
plot(n/Fs,s);
ylim([-0.5+min(s),0.5+max(s)])
title('s[n]','FontSize',18)
subplot(312)
plot(n/Fs,x);
ylim([-0.5+min(x),0.5+max(x)])
title('xn]','FontSize',18)

%======================M:Orden del filtro FIR wiener============
M=37;
%=====================CARGAR EL FILTRO WIENER
load 'mi_filtro_wiener.mat';
w=w_wiener;
y=filter(w,1,x);
subplot(313)
plot(n/Fs,y);
ylim([-0.5+min(y),0.5+max(y)])
title('y[n]: Salida del filtro Wiener FIR','FontSize',18)


figure(2)
Ndft=2^nextpow2(length(s));
Ndft=2048;
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
title('Y[F]','FontSize',18)
