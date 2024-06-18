#include <stdio.h>
#include <string.h>
#include <stdlib.h>
//#include <windows.h>
#include "c/pila.c"
#include "c/choque.c"
#include "c/auto_fantastico.c"
#include "c/ping_pong.c"
#include <ncurses.h>
#include <unistd.h>
#include "EasyPio.h"
#include "assembly/funciones_Ass.h" //cuando probemos estas funciones hay que anular las librerias de las otras porque sino se pisan

void disp_binary(int i);
void delay(unsigned long int *a);
int Leds(int num);


const int led[] = {7, 8, 25, 24, 23, 18, 15, 14};

int main() {
    char CLAVE[] = "river";
    char clave[6];
    int intentos = 0;
    int ingresar = 0;
    char caracter;
    int i;
    int aux = 0;

    pioInit();

    
    for (int i = 0; i < 8; i++) {
        pinMode(led[i], OUTPUT);
    }

    

    initscr(); // Inicializar pantalla
    cbreak(); // Deshabilitar buffering de línea
    noecho(); // No mostrar las teclas ingresadas

    do {
        i = 0;
        printw("\n\t Ingrese su clave: ");
        refresh();

        while ((caracter = getch()) != '\n') {
            if (caracter == 127) {  // Retroceso
                if (i > 0) {
                    i--;
                    printw("\b \b");
                    refresh();
                }
            }
            else {
                if (i < 5) {
                    printw("*");
                    refresh();
                    clave[i] = caracter;
                    i++;
                }
            }
        }
        clave[i] = '\0';  // Terminar la cadena de caracteres con el carácter nulo

        if (strcmp(clave, CLAVE) == 0) {
            ingresar = 1;
        }
        else {
            printw("\n\tClave incorrecta\n");
            intentos++;
        }
        refresh();

    } while (intentos < 3 && ingresar == 0);

    endwin(); // Finalizar pantalla

    if (ingresar == 0) {
        printf("\n\tNumero de intentos superados, abortando programa\n");
    }
    else {

        

        while (ingresar){
        printf("\n\tBienvenido al menu\n");
        printf("\n\t|1|Auto fantastico");
        printf("\n\t|2|Choque");
        printf("\n\t|3|Ping Pong");
        printf("\n\t|4|Llenado de una pila");
        printf("\n\tIngrese una opción: ");
        scanf("%d", &aux);


        switch (aux)
        {
            case 1:{
            printf("\n\tAUTO FANTASTICO");
            auto_fantastico();
            break;
        }
        case 2:
            printf("\n\tCHOQUE");
                choque();
            break;

        case 3:
            printf("\n\tPING PONG");
            ping_pong();
            break;
        case 4:
            printf("\n\tPILA");
            pila();
            break;

        default:
            break;
        }

    }
    }


    return 0;
}


void disp_binary(int i) {
    for (int t = 128; t > 0; t = t / 2) {
        if (i & t) {
            printf("*");
        }
        else {
            printf("_");
        }
    }
    printf("\n");
    Leds(i);
}

/*void delay(unsigned long int *a) { esta funcion es especifica para windows, se uso a modo de prueba
    if (GetAsyncKeyState(VK_DOWN) & 0x8000) {
        *a += 50;
    }
    if (*a > 50) {
        if (GetAsyncKeyState(VK_UP) & 0x8000) {
            *a -= 50;
        }
    }
    Sleep(*a);
}*/



void delay(unsigned long int *a) {
    // Inicializa ncurses
    initscr();
    cbreak();
    noecho();
    nodelay(stdscr, TRUE); // No espera por la entrada del usuario
    keypad(stdscr, TRUE);

    int ch = getch();

    // Detecta la tecla de flecha hacia abajo
    if (ch == KEY_DOWN) {
        *a += 50;
    }
    // Detecta la tecla de flecha hacia arriba
    if (*a > 50 && ch == KEY_UP) {
        *a -= 50;
    }


    // Espera por el tiempo especificado en *a milisegundos
    usleep(*a * 1000);

    // Termina ncurses
    endwin();
}

int Leds(int num) {
    int i, numval;
    for (i = 0; i < 8; i++) {
        numval = (num >> i) & 0x01;
        digitalWrite(led[i], numval);
    }
    delayMillis(300); 
    return 0;
}
