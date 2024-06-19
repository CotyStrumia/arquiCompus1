.global ping_pong
.global pila

.extern disp_binary
.extern delay
.extern Leds

.section .data
speed:  .word 5000
tabla:  .byte 0xC2, 0x62, 0x52, 0x4A, 0x46, 0x43, 0x46, 0x4A, 0x52, 0x62, 0xC2

.section .text

ping_pong:
    PUSH {LR}          
    LDR R0, =speed     
    LDR R0, [R0]       
    MOV R1, #1         
    MOV R2, #0         

loop:
    CMP R2, #0         
    BEQ forward_loop   

reverse_loop:
    MOV R3, #10        
reverse_inner_loop:
    LDR R6, =tabla      
    ADD R6, R6, R3     
    LDRB R5, [R6]       
    MOV R0, R5
    BL disp_binary
    MOV R0, R5
    BL Leds
    LDR R0, =speed
    BL delay
    SUBS R3, R3, #1     
    BNE reverse_inner_loop
    MOV R2, #0
    B loop

forward_loop:
    MOV R3, #0     

forward_inner_loop:
    LDR R6, =tabla     
    ADD R6, R6, R3     
    LDRB R5, [R6]      
    MOV R0, R5
    BL disp_binary
    MOV R0, R5
    BL Leds
    LDR R0, =speed
    BL delay
    ADDS R3, R3, #1    
    CMP R3, #11       
    BNE forward_inner_loop

    MOV R2, #1         
    B loop             
 
pila:
    PUSH {LR}
    LDR R0, =speed
    LDR R0, [R0]

    MOV R1, #0x80
    MOV R2, #0x80
    MOV R3, #0x80
    MOV R4, #0x80
    MOV R5, #0x80
    MOV R6, #0x80
    MOV R7, #0x80
    MOV R8, #0x80

    MOV R9, #9
output1_loop:
    MOV R12, R1
    MOV R0, R12
    BL disp_binary
    MOV R0, R12
    BL Leds
    LDR R0, =speed
    BL delay
    LSR R1, R1, #1
    SUBS R9, R9, #1
    CMP R9, #0
    BNE output1_loop

    MOV R9, #8
output2_loop:
    ADD R12, R2, R1
    MOV R0, R12
    BL disp_binary
    MOV R0, R12
    BL Leds
    LDR R0, =speed
    BL delay
    LSR R2, R2, #1
    SUBS R9, R9, #1
    CMP R9, #0
    BNE output2_loop

    MOV R9, #7
output3_loop:
    ADD R12, R3, R2
    ADD R12, R12, R1
    MOV R0, R12
    BL disp_binary
    MOV R0, R12
    BL Leds
    LDR R0, =speed
    BL delay
    LSR R3, R3, #1
    SUBS R9, R9, #1
    CMP R9, #0
    BNE output3_loop

    MOV R9, #6
output4_loop:
    ADD R12, R4, R3
    ADD R12, R12, R2
    ADD R12, R12, R1
    MOV R0, R12
    BL disp_binary
    MOV R0, R12
    BL Leds
    LDR R0, =speed
    BL delay
    LSR R4, R4, #1
    SUBS R9, R9, #1
    CMP R9, #0
    BNE output4_loop

    MOV R9, #5
output5_loop:
    ADD R12, R5, R4
    ADD R12, R12, R3
    ADD R12, R12, R2
    ADD R12, R12, R1
    MOV R0, R12
    BL disp_binary
    MOV R0, R12
    BL Leds
    LDR R0, =speed
    BL delay
    LSR R5, R5, #1
    SUBS R9, R9, #1
    CMP R9, #0
    BNE output5_loop

    MOV R9, #4
output6_loop:
    ADD R12, R6, R5
    ADD R12, R12, R4
    ADD R12, R12, R3
    ADD R12, R12, R2
    ADD R12, R12, R1
    MOV R0, R12
    BL disp_binary
    MOV R0, R12
    BL Leds
    LDR R0, =speed
    BL delay
    LSR R6, R6, #1
    SUBS R9, R9, #1
    CMP R9, #0
    BNE output6_loop

    MOV R9, #3
output7_loop:
    ADD R12, R7, R6
    ADD R12, R12, R5
    ADD R12, R12, R4
    ADD R12, R12, R3
    ADD R12, R12, R2
    ADD R12, R12, R1
    MOV R0, R12
    BL disp_binary
    MOV R0, R12
    BL Leds
    LDR R0, =speed
    BL delay
    LSR R7, R7, #1
    SUBS R9, R9, #1
    CMP R9, #0
    BNE output7_loop

    MOV R9, #2
output8_loop:
    ADD R12, R8, R7
    ADD R12, R12, R6
    ADD R12, R12, R5
    ADD R12, R12, R4
    ADD R12, R12, R3
    ADD R12, R12, R2
    ADD R12, R12, R1
    MOV R0, R12
    BL disp_binary
    MOV R0, R12
    BL Leds
    LDR R0, =speed
    BL delay
    LSR R8, R8, #1
    SUBS R9, R9, #1
    CMP R9, #0
    BNE output8_loop
    
    POP {LR}
    BX LR

.end