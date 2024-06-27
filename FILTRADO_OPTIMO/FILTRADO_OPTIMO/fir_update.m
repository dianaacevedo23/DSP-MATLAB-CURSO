function xn=fir_update(x,xnew)
%longitud de x
M=length(x);
xn=x;
for k =1:M
    if(k<M)
     
    xn(k+1)=x(k);

    end
    xn(1)=xnew;
end
 
end

