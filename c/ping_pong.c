#include <stdio.h>



void disp_binary(int i);
void delay(unsigned long int *a);
int Leds(int num);


void ping_pong() {
    unsigned long int speed = 500;
    int v = 1;
    int count = 0;
    unsigned char output;
    unsigned char tabla[] = {
            0xC2, 0x62, 0x52, 0x4A, 0x46, 0x43,
            0x46, 0x4A, 0x52, 0x62, 0xC2
    };
    printf("\t |PING PONG|\n\n");
    printf("Presione E para volver al menu principal\n\n\n");
    printf("\tDelay: %ld\t", speed);
    printf("\n\n");

   
        if (count == 0) {
            for (int i = 0; i < sizeof(tabla); ++i) {
                output = tabla[i];
                disp_binary(output);
               Leds(-tabla[i]);
                delay(&speed); // Espera un momento
                
                count++;
            }
        } else {
            for (int i = 1; i < sizeof(tabla); ++i) {
                output = tabla[i];
                disp_binary(output);
              Leds(-tabla[i]);
                delay(&speed); // Espera un momento
                
            }
        }
    

    //if (GetAsyncKeyState(VK_ESCAPE) & 0x8000) {
    //  v = 0;
    //}

    if ((getch()) == 'e') { //se supone que si se toca "e" sale del bucle
         return;
        }   
}
