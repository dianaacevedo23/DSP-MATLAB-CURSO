%Programa para corroborar la codificación de la DFT en ANSI C
clear all,close all,clc
N=32;
n=0:N-1;
%señal discreta
s=0:N-1;
 
%fft
X=fft(s,N);
%Magnitud
Xm=abs(X);
 
