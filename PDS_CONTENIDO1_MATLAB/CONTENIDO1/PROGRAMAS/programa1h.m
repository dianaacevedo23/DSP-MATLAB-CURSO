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

%-------------CODIGO 

%condiciones iniciales de la entrada :x
xk1=0;
xk2=0;
xk3=0;
xk4=0;
xk5=0;
xk6=0;
%condiciones iniciales de la salida :y
yk1=0;
yk2=0;
yk3=0;
yk4=0;
yk5=0;
yk6=0;

%para cada elemento del vector x
%crear arreglo para la SALIDA (solo para visualizar) esto en
%microcontrolador no es aconsable por los bajos recursos de memoria .
ys=zeros(1,L);
%L:Numero de muestras del arreglo de entrada (en uC esto se puede almacenar en un arreglo)
%float x[L] , donde un periferico ADC se encarga de digitalizar la señal
%analogica en intervalos de tiempo constantes (Ts : esto normalmente se
%define por software o por hardware(Timer)) y luego cada muestra se
%almacena en x[];
for k=1:L
    yk=b(1)*x(k)+b(2)*xk1+b(3)*xk2+b(4)*xk3+b(5)*xk4+b(6)*xk5+b(7)*xk6...
        -a(2)*yk1-a(3)*yk2-a(4)*yk3-a(5)*yk4-a(6)*yk5-a(7)*yk6;
    %actualizaciones 
    xk6=xk5;
    xk5=xk4;
    xk4=xk3;
    xk3=xk2;
    xk2=xk1;
    xk1=x(k);
    
    yk6=yk5;
    yk5=yk4;
    yk4=yk3;
    yk3=yk2;
    yk2=yk1;
    yk1=yk;
 
   %En hardware DSP (Digital Signal processor) normalmente ya todo se
   %realiza por hardware y hay que entender la libreria que permite acceder
   %a tales recursos (dsPIC33FJ ,dsPIC33EP , DSP texas instruments ,entre
   %otros).
  
   %_--------RECORDAR---------
   %---esto solo es para plotear en matlab (en uc no se suele realizar , lo anterior a este codigo si se realiza (tambien 
   % hay otras formas (uso de vectores para las condiciones iniciales o como variables independientes)))
    ys(k)=yk;
end
figure(3)
subplot(211)
plot(t,x)
xlabel('t [seg]')
ylabel('Amplitud')
title('señal eog sin filtrada : x')
subplot(212)
plot(t,ys)
xlabel('t [seg]')
ylabel('Amplitud')
title('señal eog  filtrada : ys')
%---------------------VERIFICAR SI SALE LO MISMO EMPLEANDO LA FUNCIÓN
%filter (ver figura numero 2)