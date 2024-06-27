clear all,close all,clc
%---------coeficientes constantes (esto representa la ultima parte del diseño de filtros )
b=[4.83825267e-08,2.90295160e-07,7.25737900e-07,9.67650534e-07,...
    7.257379e-07,2.90295160e-07,4.83825267e-08];
a=[ 1,-5.51498094,12.69112968,-15.59729098,10.79661625,-3.99086913,0.61539821];
%cargar la señal de entrada x
load('dato_H1.mat');
x=h;
L=length(x);
Fs=500;
%x=linspace(0,100,L);
t=(0:L-1)/Fs;
Dur=L/Fs;
E=nextpow2(L);
N=2^E;
X=fft(x,N);
X=fftshift(X);
X_m=abs(X);
%Normalizar: 0-1
X_m=X_m/max(X_m);
F=linspace(-Fs/2,Fs/2,N);

%----filtrado
y=filter(b,a,x);
Y=fft(y,N);
Y=fftshift(Y);
Y_m=abs(Y);
Y_m=Y_m/max(Y_m);
F=linspace(-Fs/2,Fs/2,N);
%--------sección graficos
figure(1)
subplot(211)
plot(F,X_m);
title('ESPECTRO DE FRECUENCIA (Señal sin filtrar x)')
xlabel('F [Hz]')
ylabel('Magnitud')
xlim([-100,100])
subplot(212)
plot(F,Y_m);
title('ESPECTRO DE FRECUENCIA (Señal filtrada y) ')
xlabel('F [Hz]')
ylabel('Magnitud')
xlim([-100,100])
figure(2)
subplot(211)
plot(t,x)
xlabel('t [seg]')
ylabel('Amplitud')
title('señal eog sin filtrada : x')
subplot(212)
plot(t,y)
xlabel('t [seg]')
ylabel('Amplitud')
title('señal eog  filtrada : y')
%...............APLICACION DEL FILTRO DERIVADA 1
M=11;
alpha=(M-1)/2;
h=zeros(1,M);
y=[1,1,1,1,100];
%filtro ideal
for n=0:M-1
    if n==alpha
        h(n+1)=0;
    else
        h(n+1)=cos(pi*(n-alpha))/(n-alpha);
    end
end
n=0:M-1;
%aplicación de la ventana 
wh=blackman(1,M);
h=h.*wh;
yn=filter(h,1,y);
figure(3)
stem(n,h)
xlabel('n')
ylabel('Amplitud')
title('filtro digital diferenciador h[n]');
ylim([-1.1,1.1])
figure(4)
plot(t,yn)
xlabel('t [seg]')
ylabel('Amplitud')
title('derivada de la señal eog filtrada')

%---------- APLICACION DE LA DERIVADA DISCRETA SOBRE LA SEÑAL DE ENTRADA y
y_n1=0;
yd2=zeros(1,L);
for n=1:L
    %para n=(0,1,2,3,L-1)+1 , dado que en matlab el indice 0 no es viable
    yd2(n)=y(n)-y_n1;
    %actualización
    y_n1=y(n);
end

figure(5)
plot(t,yd2)
xlabel('t [seg]')
ylabel('Amplitud')
title('derivada de la señal eog filtrada')
