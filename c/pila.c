#include <stdio.h>
#include <stdlib.h>


void disp_binary(int i);
void delay(unsigned long int *a);
int Leds(int num);


void pila() {
    unsigned long int speed = 500;
    int v = 1;
    unsigned char output;
    unsigned char output1;
    unsigned char output2;
    unsigned char output3;
    unsigned char output4;
    unsigned char output5;
    unsigned char output6;
    unsigned char output7;
    unsigned char output8;

   
        output1 = 0x80;
        output2 = 0x80;
        output3 = 0x80;
        output4 = 0x80;
        output5 = 0x80;
        output6 = 0x80;
        output7 = 0x80;
        output8 = 0x80;

        for (int i = 0; i < 8; i++) {
            output = output1;
            disp_binary(output);
            Leds(output);
            delay(&speed); // Espera un momento
            if (output1 != 0x01)
                output1 = output1 >> 1; // ">>" desplazamiento a la derecha
        }
        
        for (int i = 0; i < 7; i++) {
            output = output2 + output1;
            disp_binary(output);
            Leds(output);
            delay(&speed); // Espera un momento
            if (output2 != 0x02)
                output2 = output2 >> 1; // ">>" desplazamiento a la derecha
        }
         

        for (int i = 0; i < 6; i++) {
            output = output3 + output2 + output1;
            disp_binary(output);
            Leds(output);
            delay(&speed); // Espera un momento
            if (output3 != 0x04)
                output3 = output3 >> 1; // ">>" desplazamiento a la derecha
        }
       

        for (int i = 0; i < 5; i++) {
            output = output4 + output3 + output2 + output1;
            disp_binary(output);
            Leds(output);
            delay(&speed); // Espera un momento
            
            if (output4 != 0x08)
                output4 = output4 >> 1; // ">>" desplazamiento a la derecha
        }
        
        for (int i = 0; i < 4; i++) {
            output = output5 + output4 + output3 + output2 + output1;
            disp_binary(output);
           Leds(output);
            delay(&speed); // Espera un momento
          
            if (output5 != 0x10)
                output5 = output5 >> 1; // ">>" desplazamiento a la derecha
        }
        

        for (int i = 0; i < 3; i++) {
            output = output6 + output5 + output4 + output3 + output2 + output1;
            disp_binary(output);
            Leds(output);
            delay(&speed); // Espera un momento
           
            if (output6 != 0x20)
                output6 = output6 >> 1; // ">>" desplazamiento a la derecha
        }
       

        for (int i = 0; i < 2; i++) {
            output = output7 + output6 + output5 + output4 + output3 + output2 + output1;
            disp_binary(output);
           Leds(output);
            delay(&speed); // Espera un momento
            
            if (output7 != 0x40)
                output7 = output7 >> 1; // ">>" desplazamiento a la derecha
        }
       

        output = output8 + output7 + output6 + output5 + output4 + output3 + output2 + output1;
        disp_binary(output);
       Leds(output);
        delay(&speed); // Espera un momento
    

    //if (GetAsyncKeyState(VK_ESCAPE) & 0x8000) {
    //  v = 0;
    //}
}