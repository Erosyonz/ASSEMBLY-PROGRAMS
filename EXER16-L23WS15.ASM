; Filename:Exer16.asm
; Programmer name: Alleah Dela Pena
; Date: September 11, 2025
; This assembly program will get user input and display back character input

.MODEL small
.STACK 200h
.DATA
  input db ?

  inputChar db ?

  inputMsg db 'Enter a character: $'
  outputMsg db 13,10,'You entered: $'
.CODE
Main:
    mov ax, @data
    mov ds, ax

    mov dx, offset inputMsg
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    mov inputChar, al

    mov dx, offset outputMsg
    mov ah, 09h
    int 21h

    mov dl, inputChar
    mov ah, 02h
    int 21h

    mov ax, 4C00H
    int 21h                 
END Main
