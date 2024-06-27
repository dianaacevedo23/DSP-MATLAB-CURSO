clear all,close all,clc
%'default':generar una secuencia aleatoria  'predecible' 
%'shuffle':generar una secuencia aleatoria distinta
 rng('default');
%==========RUIDO BLANCO GAUSSIANO x[k]========
sdv=0.15;
power=10*log10(sdv^2);
N=1000;
power=-8;
x=wgn(N,1,power);
 
%=========SE?AL DESEADA s[k]================
F=50;
Fs=1000;
n=0:N-1;
d=1*sin(2*pi*F*n/Fs)';
r=5*x;
%============d[k]+r[k]================
s=d+r;
 
figure()
subplot(311)
plot(n/Fs,d);
ylim([-0.5+min(d),0.5+max(d)])
title('d[k]')
subplot(312)
plot(n/Fs,s);
ylim([-0.5+min(s),0.5+max(s)])
title('s[k]=d[k]+r[k]')
 
%======================M:Orden del filtro FIR wiener============
M=57;
%====================FILTRO FIR DE ORDEN M==============0
%===============INICIALIZACI?N (1 x M+1)===============
wk_0=0.1*randn(1,M+1);
wk_0=wk_0-mean(wk_0);
%===========================================
w=wk_0;
alpha=0.005;
%==========vector de entrada x====
xk=zeros(M+1,1);
%==========salida filtrada yf====
yf=zeros(1,N);
for epoca=1:10
for k=1:N
    xnew=x(k);
    xk=fir_update(xk,xnew);
    yk=w*xk;
    e=s(k)-yk;
    yf(k)=e;
    w=w+2*alpha*e*xk';
end
end
%===guardar el filtro wiener obtenido===
save('w_wiener_lms.mat')
%y=filter(w,1,x);
%yf=s-y;
subplot(313)
plot(n/Fs,yf);
ylim([-0.5+min(yf),0.5+max(yf)])
title('e[k]')



figure(2)
Ndft=2^nextpow2(length(d));
Ndft=2048;
F=linspace(-Fs/2,Fs/2,Ndft);
%========================DFT se?al d
DF=fft(d,Ndft);
DF=fftshift(DF);
DF_m=abs(DF);
subplot(311)
plot(F,DF_m)
%========================DFT se?al s
SF=fft(s,Ndft);
SF=fftshift(SF);
SF_m=abs(SF);
subplot(312)
plot(F,SF_m)
%========================DFT se?al e
YF=fft(yf,Ndft);
YF=fftshift(YF);
YF_m=abs(YF);
subplot(313)
plot(F,YF_m)