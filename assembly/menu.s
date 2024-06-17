

.text

.global pila
.global ping_pong


pila:
 
    push {r4, r5, r6, r7, lr}

    ldr r0, =speed
    ldr r0, [r0]       @ speed
    mov r1, #1         @ v
    mov r2, #0x80      @ output1
    mov r3, #0x80      @ output2
    mov r4, #0x80      @ output3
    mov r5, #0x80      @ output4
    mov r6, #0x80      @ output5
    mov r7, #0x80      @ output6
    mov r8, #0x80      @ output7
    mov r9, #0x80      @ output8

loop
    
    cmp r1, #0
    beq end_loop

    mov r10, r2
    bl disp_binary
    bl Leds
    mov r11, #8
    
output1_loop:
    cmp r11, #0
    beq output2_start
    lsr r2, r2, #1
    subs r11, r11, #1
    mov r10, r2
    bl disp_binary
    bl Leds
    bl delay

    b output1_loop

output2_start:
    @ output2 + output1
    add r10, r3, r2
    bl disp_binary
    bl Leds
    bl delay
    mov r11, #7
output2_loop:
    cmp r11, #0
    beq output3_start
    lsr r3, r3, #1
    subs r11, r11, #1
    add r10, r3, r2
    bl disp_binary
    bl Leds
    bl delay

    b output2_loop

output3_start:
    @ output3 + output2 + output1
    add r10, r4, r3
    add r10, r10, r2
    bl disp_binary
    bl Leds
    bl delay

    mov r11, #6
output3_loop:
    cmp r11, #0
    beq output4_start
    lsr r4, r4, #1
    subs r11, r11, #1
    add r10, r4, r3
    add r10, r10, r2
    bl disp_binary
    bl Leds
bl delay

    b output3_loop

output4_start:
    @ output4 + output3 + output2 + output1
    add r10, r5, r4
    add r10, r10, r3
    add r10, r10, r2
    bl disp_binary
    bl Leds
bl delay

    mov r11, #5
output4_loop:
    cmp r11, #0
    beq output5_start
    lsr r5, r5, #1
    subs r11, r11, #1
    add r10, r5, r4
    add r10, r10, r3
    add r10, r10, r2
    bl disp_binary
    bl Leds
bl delay

    b output4_loop

output5_start:
    @ output5 + output4 + output3 + output2 + output1
    add r10, r6, r5
    add r10, r10, r4
    add r10, r10, r3
    add r10, r10, r2
    bl disp_binary
    bl Leds
bl delay

    mov r11, #4
output5_loop:
    cmp r11, #0
    beq output6_start
    lsr r6, r6, #1
    subs r11, r11, #1
    add r10, r6, r5
    add r10, r10, r4
    add r10, r10, r3
    add r10, r10, r2
    bl disp_binary
    bl Leds
bl delay

    b output5_loop

output6_start:
    @ output6 + output5 + output4 + output3 + output2 + output1
    add r10, r7, r6
    add r10, r10, r5
    add r10, r10, r4
    add r10, r10, r3
    add r10, r10, r2
    bl disp_binary
    bl Leds
bl delay

    mov r11, #3
output6_loop:
    cmp r11, #0
    beq output7_start
    lsr r7, r7, #1
    subs r11, r11, #1
    add r10, r7, r6
    add r10, r10, r5
    add r10, r10, r4
    add r10, r10, r3
    add r10, r10, r2
    bl disp_binary
    bl Leds
    bl delay

    b output6_loop

output7_start:
    @ output7 + output6 + output5 + output4 + output3 + output2 + output1
    add r10, r8, r7
    add r10, r10, r6
    add r10, r10, r5
    add r10, r10, r4
    add r10, r10, r3
    add r10, r10, r2
    bl disp_binary
    bl Leds
    bl delay

    mov r11, #2
output7_loop:
    cmp r11, #0
    beq output8_start
    lsr r8, r8, #1
    subs r11, r11, #1
    add r10, r8, r7
    add r10, r10, r6
    add r10, r10, r5
    add r10, r10, r4
    add r10, r10, r3
    add r10, r10, r2
    bl disp_binary
    bl Leds
    bl delay

    b output7_loop

output8_start:
    @ output8 + output7 + output6 + output5 + output4 + output3 + output2 + output1
    add r10, r9, r8
    add r10, r10, r7
    add r10, r10, r6
    add r10, r10, r5
    add r10, r10, r4
    add r10, r10, r3
    add r10, r10, r2
    bl disp_binary
    bl Leds
    bl delay

    b loop

end_loop:
    @ Restaurar registros y salir
    pop {r4, r5, r6, r7, lr}
    bx lr
    
ping_pong:
    @ Guardar registros necesarios
    push {r4, r5, r6, r7, lr}

    @ Inicializar variables
    ldr r0, =500        @ speed
    mov r1, #1          @ v
    mov r2, #0          @ count
    ldr r3, =tabla      @ puntero a la tabla
  

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

  
loop_inner:
loop_inner_start:
    cmp r6, r7
    bge loop_inner_end

    ldrb r4, [r3, r6]
    bl disp_binary
    bl leds
    ldr r0, [sp, #8]    @ speed
 bl disp_binary
    bl Leds

    bl delay

    add r6, r6, #1
    b loop_inner_start

loop_inner_end:
    add r2, r2, #1
    bx lr

skip_exit:
    @ Restaurar registros y salir
    pop {r4, r5, r6, r7, pc}


.data
tabla: 
.byte 0xFF
.byte 0xFE
.byte 0xFD
.byte 0xFB
.byte 0xF7
.byte 0xEF
.byte 0xDF
.byte 0xBF
.byte 0x7F
.byte 0x00