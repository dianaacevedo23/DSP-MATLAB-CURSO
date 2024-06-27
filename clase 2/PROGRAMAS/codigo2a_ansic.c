
#include <stdio.h>

//CANTIDAD DE COEFICIENTES
#define M 11

float x[]={1,1,1,1,100};
//FILTRO FIR DE DASE LINEAL 
float b[M]={0.2,-0.25,0.33,-0.5,1,0,-1,0.5,-0.33,0.25,-0.2};//b[n] antisimetrico
float yn=0;
unsigned int n=0;
//*condiciones iniclaes
float x_n1=0,x_n2=0,x_n3=0,x_n4=0,x_n5=0,x_n6=0,x_n7=0,x_n8=0,x_n9=0,x_n10=0;
int main(void)
{

 
    //leer las muestras de x
   for (n=0;n<=4;n++)
   {
       //leer el valor del ADC

       yn=b[0]*x[n]+b[1]*x_n1+b[2]*x_n2+b[3]*x_n3+b[4]*x_n4+b[5]*x_n5+b[6]*x_n6+b[7]*x_n7+b[8]*x_n8+b[9]*x_n9+b[10]*x_n10;
       //actualizar
       x_n10=x_n9;
        x_n9=x_n8;
        x_n8=x_n7;
        x_n7=x_n6;
        x_n6=x_n5;
        x_n5=x_n4;
        x_n4=x_n3;
        x_n3=x_n2;
        x_n2=x_n1;
        x_n1=x[n];       
       //------MOSTRAR DATOS EN LA CONSOLA
       printf("x[%d]=%.4f----------> y[%d]=%.4f\r\n",n,x[n],n,yn);

   }
 
    return 0;
}