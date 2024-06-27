#include <stdio.h>
#include <math.h>

#define N 32
typedef struct {

    float real;
    float imag;
}Complex;

/*Declración de funciones*/
void DFT(float x[],Complex X[],int N_data);//x[n],X[k] y N
void Abs_DFT(float Xm[],Complex X[],int N_Data);

/*Declaración de variables*/
Complex XDFT[N];//DFT de N puntos
float Xmag[N];//Magnitud de la DFT de N puntos
float s[N];//Señal de prueba x[n]

int main(void)
{
    /*Recolectar muestras del ADC*/
    int n=0,k=0;
    for(n=0;n<=N-1;n++)
    {
        s[n]=n;
    }
    /*Hallar DGT*/
   DFT(s,XDFT,N);
   /*MAgnitud DFT*/
   Abs_DFT(Xmag,XDFT,N);
    /*Mostrar datos*/
    printf("MAGNITUD DE LA DFT DE N PUNTOS\r\n");

      for(k=0;k<=N-1;k++)
    {
             printf("Xmag[%d]: %.3f \r\n",k,Xmag[k]);

    } 
    return 0;
}
/*Definición de funciones*/
void DFT(float x[],Complex X[],int N_data)//x[n],X[k] y N
{
 /*Variables enteras n,k*/
 int k=0,n=0;
 float Re=0,Img=0;
 for(k=0;k<=N_data-1;k++)
 { 
     Re=0;
     Img=0;
    for(n=0;n<=N_data-1;n++)
    {
        Re+=x[n]*(float)cos(2*3.1416*k*n/N_data);
        Img+=x[n]*(float)sin(-2*3.1416*k*n/N_data);
     }
     X[k].real=Re;//asginar parte real
     X[k].imag=Img;//asginar parte imaginaria
 }
return ;
}
void Abs_DFT(float Xm[],Complex X[],int N_Data)
{

int k=0;
for(k=0;k<=N-1;k++)
{
    //magnitud:sqrt(real^2+imaginario^2)
    Xm[k]=(float)sqrt(pow(X[k].real,2)+pow(X[k].imag,2));

}
return ;
}