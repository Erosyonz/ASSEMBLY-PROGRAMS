; Filename:Exer.asm
; Displaying single characters, numbers, and symbols
; Name: Alleah Dela Pena;
; Date: August 14, 2025

.model small
.code
.stack 100
start:
;A
    mov ah,02h 
    mov cl, 'A'
    mov dl,cl
    int 21h
;B
    mov ah, 02h
    mov cl, 'B'
    mov dl, cl
    int 21h
;C
    mov ah, 02h
    mov cl, 'C'
    mov dl, cl
    int 21h
;D
    mov ah,02h
    mov cl, 'D'
    mov dl, cl
    int 21h 
;E
    mov ah, 02h
    mov cl, 'E'
    mov dl,cl 
    int 21h
;F
    mov ah, 02h
    mov cl, 'F' 
    mov dl, cl
    int 21h 
;G
    mov ah, 02h
    mov cl, 'G'
    mov dl,cl 
    int 21h
;H
    mov ah,02h
    mov cl, 'H'
    mov dl, cl
    int 21h
;I
    mov ah, 02h
    mov  cl, 'I'
    mov dl,cl
    int 21h
;J
    mov ah, 02h
    mov cl, "J"
    mov dl,cl
    int 21h
;K
    mov ah, 02h
    mov cl, 'K'
    mov dl,cl
    int 21h
;L
    mov ah, 02h
    mov cl, 'L'
    mov dl,cl 
    int 21h
;M
    mov ah, 02h
    mov cl, 'M'
    mov dl,cl
    int 21h
;N
    mov ah, 02h
    mov cl, 'N'
    mov dl,cl 
    int 21h
;O
    mov ah, 02h
    mov cl, 'O'
    mov dl, cl 
    int 21h
;P
    mov ah, 02h 
    mov cl, 'P'
    mov dl,cl 
    int 21h 
;Q
    mov ah, 02h
    mov cl, 'Q'
    mov dl,cl
    int 21h 
;R
    mov ah, 02h 
    mov cl, 'R'
    mov dl,cl 
    int 21h 
;S
    mov ah, 02h
    mov cl, 'S'
    mov dl,cl 
    int 21h
;T
    mov ah, 02h
    mov cl, 'T'
    mov dl,cl 
    int 21h
;U
    mov ah, 02h
    mov cl, 'U'
    mov dl,cl 
    int 21h
;V
    mov ah, 02h
    mov cl, 'V'
    mov dl,cl 
    int 21h
;W
    mov ah, 02h
    mov cl, 'W'
    mov dl,cl 
    int 21h
;X
    mov ah, 02h
    mov cl, 'X'
    mov dl,cl 
    int 21h
;Y
    mov ah, 02h
    mov cl, 'Y'
    mov dl,cl 
    int 21h
;Z
    mov ah, 02h
    mov cl, 'Z'
    mov dl,cl 
    int 21h



    
    
 int 27h
 end start    