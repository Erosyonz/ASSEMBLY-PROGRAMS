; Filename: EXER19.ASM
; Programmer Name: ALLEAH DELA PENA
; Date: September 12, 2025
; Description: Get string input and display it back.

.MODEL small
.STACK 100h
.DATA
MAXIMUM_STRING_LENGTH EQU 1000
StringInput DB MAXIMUM_STRING_LENGTH DUP (?)
InputPrompt DB 'Enter text: $'

.CODE
ProgramStart:
    mov ax,@data
    mov ds,ax

    mov dx,OFFSET InputPrompt
    mov ah,9
    int 21h

    mov ah,3fh
    mov bx,0
    mov cx,MAXIMUM_STRING_LENGTH
    mov dx,OFFSET StringInput
    int 21h

    and ax,ax
    jz Done
    mov cx,ax
    mov bx,OFFSET StringInput

    mov ah,40h
    mov bx,1
    mov dx,OFFSET StringInput
    int 21h

Done:
    mov ah,4ch
    int 21h
END ProgramStart
