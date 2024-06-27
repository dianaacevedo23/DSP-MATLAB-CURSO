clear all
close all
clc
%DISEÑO DE FILTRO PASA BAJO BUTTERWORTH

%FRECUENCIA DE CORTE DEL FILTRO PASA BAJO
Fc=150;
Fst=[1000,1000,1000];
wc=2*pi*Fc;%rad/seg
c=['k','b','r'];
%atenuación en la Frecuencia Fst
Adb=60;
r=10^(-Adb/20);
%orden del filtro
for i=1:3 
ws=2*pi*Fst(i);
%---------Orden del filtro butterworth
N=log10((1/(r^2))-1)/(2*log10(ws/wc));
N=round(N);
%Determinar filtro pasa bajo de orden N
[z,p,k]=buttap(N);
p=p*wc;
k=k*(wc^N);
num=k*poly(z);
den=poly(p);
w=2*pi*linspace(0,1400,2000);
Hs=freqs(num,den,w);
Hm=abs(Hs);
subplot(311)
plot(w/(2*pi),Hm,c(i),'LineWidth',1)
hold on
xlabel('Frecuencia')
ylabel('Magnitud')
subplot(312)
Hdb=20*log10(Hm+0.000001);
plot(w/(2*pi),Hdb,c(i),'LineWidth',1)
hold on
xlabel('Frecuencia')
ylabel('dB')
end
disp('ORDEN DEL FILTRO BUTTERWORTH')
disp(N)
b=num;
a=den;
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
disp('DIMESNON DE LA MATRIZ \r\n');
size(cs2);
%redondear los coeficientes
disp('MATRIZ SOS\r\n');
cs2=round(cs2);
 
%---------H1(s)=(b01)/(s^2+a11s+a21)
%---------H2(s)=(b02)/(s^2+a12s+a22)
%----------g*b01*b02=a21*a22
%----------b01=b02=1
%----------g=a21*a22;

%-----------numerador de H2(s)

%numerador de H2(s)
a22=cs2(2,6);
num2=[a22];%cs2(2,6)
%---numerador de H1(s)
a21=g/a22;%cs2(1,6)
num1=[a21];

%denominador de H1(s)
a11=cs2(1,5);
a21=cs2(1,6);
den1=[1,a11,a21];
%--------------------------
Hs1=freqs(num1,den1,w);

%denominador de H2(s)
a12=cs2(2,5);
a22=cs2(2,6);
den2=[1,a12,a22];
%Respuesta en frecunecia 
Hs2=freqs(num2,den2,w);
%Transformada de fourier de sistema en cascada
Hs=Hs1.*Hs2;
%Magnitud
Hm=abs(Hs);
subplot(313)
plot(w/(2*pi),Hm)