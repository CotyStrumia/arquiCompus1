#include <stdio.h>

void disp_binary(int i);
void delay(unsigned long int *a);
int Leds(int num);


void choque() {
    unsigned long int speed=500;
    unsigned char tabla[] = { 0x81, 0x42, 0x24, 0x18, 0x18, 0x24, 0x42, 0x81 };

    printf("\t |EL CHOQUE|\n\n");
    printf("Presione E para volver al menu principal\n\n\n");
    printf("\tDelay: %ld ms\t", speed);
    printf("\n\n");
    int v = 1;
    
        for (int i = 0; i < 8; ++i) {
           
            disp_binary(tabla[i]);
            Leds(-tabla[i]);
            delay(&speed); // Espera un momento
            
        }
    
       // if (GetAsyncKeyState(VK_ESCAPE) & 0x8000) {
         //   v = 0;
        //}
}

