; Filename: EXER17.ASM
; Programmer Name: ALLEAH DELA PENA
; Date: September 12, 2025
; Description: Continuously get character input and display it until Enter is pressed.

.MODEL small
.STACK 200h
.DATA

.CODE
ProgramStart:
EchoLoop:
    mov ah,1
    int 21h
    cmp al,13
    jz EchoDone

    mov dl,al
    mov ah,2
    int 21h
    jmp EchoLoop

EchoDone:
    mov ah,4ch
    int 21h
END ProgramStart
