clear all
close all
clc
Fc=150;
wc=2*pi*Fc;%rad/seg
w=2*pi*linspace(0,1400,2000);
%---FILTRO PASABAJO BUTTERWORTH DE ORDEN 4
b=7.89e11;
a=[1,2463,3.033e06,2.188e09,7.89e11];
%RESPUESTA EN FRECUENCIA
Hs=freqs(b,a,w);
%TRANSFORMADA DE FOURIER
Hm=abs(Hs);
%--------PLOTEOS-------------
subplot(311)
plot(w/(2*pi),Hm,'LineWidth',1)
hold on
xlabel('Frecuencia')
ylabel('Magnitud')
subplot(312)
Hdb=20*log10(Hm+0.000001);
plot(w/(2*pi),Hdb,'LineWidth',1)
hold on
xlabel('Frecuencia')
ylabel('dB')
fprintf('H(s)')
fprintf('Numerador Filtro ')
disp(b)
fprintf('denominador Filtro ')
disp(a)
%---------------------------------------------------------------------------------------------------------------------------------------x
%------------Secciones en cascada de 2do orden----------------------------
[cs2,g] = tf2sos(b,a);
%g:ganancia
%cs2:matriz 
%mostrar dimension de la matriz SOS
disp('DIMENSIÓN DE LA MATRIZ \r\n');
size(cs2);
%redondear los coeficientes
disp('MATRIZ SOS\r\n');
cs2=round(cs2);
 
%---------H1(s)=(b01)/(s^2+a11s+a21)
%---------H2(s)=(b02)/(s^2+a12s+a22)
%----------g*b01*b02=a21*a22
%----------b01=b02=1
%----------g=a21*a22;


%---numerador de H1(s)
num1=[cs2(1,6)];%cs2(1,6)
%denominador de H1(s)
a11=cs2(1,5);
a21=cs2(1,6);
den1=[1,a11,a21];
%---------RESPUESTA EN FRECUENCIA DE LA ETAPA 1 (2do orden)
Hs1=freqs(num1,den1,w);

%-----------numerador de H2(s)
%numerador de H2(s)
num2=[cs2(2,6);];%cs2(2,6)
%denominador de H2(s)
a12=cs2(2,5);
a22=cs2(2,6);
den2=[1,a12,a22];
%---------RESPUESTA EN FRECUENCIA DE LA ETAPA2(2do orden
Hs2=freqs(num2,den2,w);

%Transformada de fourier de sistema en cascada
Hs=Hs1.*Hs2;
%Magnitud
Hm=abs(Hs);
subplot(313)
plot(w/(2*pi),Hm)
xlabel('F')
ylabel('Hz')