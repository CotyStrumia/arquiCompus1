.global ping_pong
.global disp_binary
.global delay
.global GetAsyncKeyState

.data
tabla: .byte 0xC2, 0x62, 0x52, 0x4A, 0x46, 0x43, 0x46, 0x4A, 0x52, 0x62, 0xC2

.text
ping_pong:
    @ Guardar registros necesarios
    push {r4, r5, r6, r7, lr}

    @ Inicializar variables
    ldr r0, =500        @ speed
    mov r1, #1          @ v
    mov r2, #0          @ count
    ldr r3, =tabla      @ puntero a la tabla

    @ Imprimir mensajes iniciales
    ldr r0, =msg1
    bl printf
    ldr r0, =msg2
    bl printf
    ldr r0, =msg3
    bl printf
    ldr r0, =msg4
    bl printf

loop:
    @ Si count es 0, recorrer toda la tabla
    cmp r2, #0
    bne not_first_time

first_time:
    mov r6, #0
    ldrb r4, [r3, r6]
    mov r7, #11
    bl loop_inner
    b loop_done

not_first_time:
    mov r6, #1
    ldrb r4, [r3, r6]
    mov r7, #10
    bl loop_inner

loop_done:
    @ Comprobar tecla de escape
    ldr r0, =VK_ESCAPE
    bl GetAsyncKeyState
    cmp r0, #0
    beq skip_exit

    @ Ajustar velocidad con teclas de flecha
    ldr r0, =VK_UP
    bl GetAsyncKeyState
    cmp r0, #0
    beq skip_up
    sub r1, r1, #50
skip_up:
    ldr r0, =VK_DOWN
    bl GetAsyncKeyState
    cmp r0, #0
    beq skip_down
    add r1, r1, #50
skip_down:

    b loop

loop_inner:
    @ r7 contiene el tamaño del bucle
    @ r6 contiene el índice actual
loop_inner_start:
    cmp r6, r7
    bge loop_inner_end

    ldrb r4, [r3, r6]
    bl disp_binary
    bl leds
    ldr r0, [sp, #8]    @ speed
    bl delay

    add r6, r6, #1
    b loop_inner_start

loop_inner_end:
    add r2, r2, #1
    bx lr

skip_exit:
    @ Restaurar registros y salir
    pop {r4, r5, r6, r7, pc}

