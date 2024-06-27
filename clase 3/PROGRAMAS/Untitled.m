clear all,close all,clc
F=10;
Fs=100;
L=50;
%vector tiempo 
n=0:L-1;
%señal discreta
s=sin(2*pi*F*n/Fs);

figure(1)
subplot(211)
stem(n,s)
title('Señal seno')
xlabel('n')
ylabel('amplitud')

r