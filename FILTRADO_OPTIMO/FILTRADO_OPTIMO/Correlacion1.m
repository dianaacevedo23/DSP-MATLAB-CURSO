clear all,close all,clc
%========CORRELACION CRUZADA ===========
x=[1,2,3,-2,-1];

y=[0,0,1,2,3];
N=length(x);
k=0:N-1;
subplot(411)
stem(k,x)
title('x[k]','FontSize',18)
subplot(412)
stem(k,y)
title('y[k]=x[k-2]','FontSize',18)

%=======rxy===========
[rxy,l]=xcorr(x,y,'coeff');
subplot(413)
stem(l,rxy)
title('rxy(l)','FontSize',18)

[ryx,l]=xcorr(y,x,'coeff');
subplot(414)
stem(l,ryx)
title('ryx(l)','FontSize',18)
%---------------------------se?al periodica x[n]------------------
x=[1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4];
N=length(x);
k=0:N-1;
[rx,l]=xcorr(x,'coeff');
figure
subplot(211)
stem(k,x)
title('x[k]','FontSize',18)

 
subplot(212)
stem(l,rx)
title('rx(l)','FontSize',18)

%-------------------------ruido blanco gaussiano-------------
N=500;
k=0:N-1;
powerdB=-10;%-10dB
v=wgn(N,1,powerdB);
%--------determina la autocorrelaci?n
figure
subplot(211)
plot(k,v)
title('v[k]','FontSize',18)
[rv,l]=xcorr(v,'coeff');
subplot(212)
plot(l,rv)
title('rv[l]','FontSize',18)
 


