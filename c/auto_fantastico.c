#include <stdio.h>
#include <stdlib.h>


void disp_binary(int i);
void delay(unsigned long int *a);
int Leds(int num);



void auto_fantastico() {
    unsigned long int timeAuto=500;  // Tiempo de retardo inicial en milisegundos
    unsigned char output, output1;  // Un entero de 8 bits sin signo (rango de 0 a 255)
    int v = 1;
    
        // Ida
        output = 0x80;
        output1 = 0x02;
        for (int i = 0; i < 8; i++) {
            disp_binary(output);
            Leds(output);
            delay(&timeAuto); // Espera un momento
            output = output >> 1; // ">>" desplazamiento a la derecha
        }
        
        for (int i = 0; i < 7; i++) {
            disp_binary(output1);
            Leds(output1);
            delay(&timeAuto); // Espera un momento
            output1 = output1 << 1; // "<<" desplazamiento a la izquierda
        }

        //if (GetAsyncKeyState(VK_RETURN) & 0x8000) { funcion especifica para prueba en windows
          //  v = 0;
           // break;
        //}


    
}






