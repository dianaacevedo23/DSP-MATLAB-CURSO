%Programa para corroborar la codificaci�n de la DFT en ANSI C
clear all,close all,clc
N=32;
n=0:N-1;
%se�al discreta
s=0:N-1;
 
%fft
X=fft(s,N);
%Magnitud
Xm=abs(X);
 
