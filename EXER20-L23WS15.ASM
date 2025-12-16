; Filename:Exer18.asm
; Programmer name: Alleah Dela Pena
; Date: September 11, 2025
; This assembly program will get string input and display the reverse of the string.

.MODEL small
.STACK 100h
.DATA
max_len EQU 1000
StringToReverse DB max_len DUP (?)
ReverseString DB max_len DUP (?) 

.CODE
ProgramStart:
    mov ax, @data
    mov ds, ax

    mov ah, 3fh
    mov bx, 0  
    mov cx, MAX_LEN

    mov dx, OFFSET StringToReverse
    int 21h
    and ax, ax
    jz Done
    mov cx, ax

    push cx
    mov bx, OFFSET StringToReverse
    mov si, OFFSET ReverseString
    add si, cx
    dec si  

    ReversesLoop:
        mov al, [bx]
        mov [si], al
        inc bx 
        dec si

        loop ReversesLoop
        pop cx
        mov ah, 40h
        mov bx, 1
        mov dx, OFFSET ReverseString
        int 21h
Done:
    mov ah, 4ch
    int 21h



END ProgramStart