; Filename:Exer.asm
; Displaying single characters, numbers, and symbols
; Name: Alleah Dela Pena;
; Date: August 14, 2025

.model small ; directive to use "small" memory model
.code ; section of program containing executable code.
.stack 100 ;define the size of the program's stack.
start: ; start of program

    mov ah,02h; Set AH to display a character ; prepare the computer ; high register
    mov cl, 1H ; 4th is capital A  ; integrate value low register
    mov dl, cl ; copies 8-bit value in cl to dl ; for display data
    int 21h ; interrupt for input/output ; interact = int

    int 27h ; template ; stop the program
    end start ; end program