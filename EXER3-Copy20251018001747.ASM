; Filename:Exer.asm
; Displaying single characters, numbers, and symbols
; Name: Alleah Dela Pena;
; Date: August 14, 2025

    .model small ; directive to use "small" memory model
    .code ; section of program containing executable code.
    .stack 100 ;define the size of the program's stack.
    start: ; start of program
;1
    mov ah, 02h
    mov cl,  '1';
    mov dl,cl
    int 21h 

    mov ah, 02h 
    mov cl, 20h
    mov dl, cl
    int 21h 
;2
    mov ah, 02h
    mov cl, '2'
    mov dl,cl
    int 21h  

    mov ah, 02h 
    mov cl, 20h
    mov dl, cl
    int 21h 
;3
    mov ah, 02h 
    mov cl, '3'
    mov dl,cl 
    int 21h

    mov ah, 02h
    mov cl, " "
    mov dl,cl
    int 21h 
;4
    mov ah, 02h
    mov cl, '4'
    mov dl, cl 
    int 21h

    mov ah, 02h
    mov cl, " "
    mov dl,cl
    int 21h 
;5    
    mov ah, 02h
    mov cl, '5'
    mov dl,cl
    int 21h  

    mov ah, 02h 
    mov cl, 20h
    mov dl, cl
    int 21h 
;6
    mov ah, 02h 
    mov cl, '6'
    mov dl,cl 
    int 21h

    mov ah, 02h
    mov cl,  ' '
    mov dl,cl
    int 21h
;7
    mov ah, 02h
    mov cl, '7'
    mov dl,cl
    int 21h  

    mov ah, 02h 
    mov cl, 20h
    mov dl, cl
    int 21h 
;8
    mov ah, 02h 
    mov cl, '8'
    mov dl,cl 
    int 21h

    mov ah, 02h
    mov cl, " "
    mov dl,cl
    int 21h 
;9    
    mov ah, 02h
    mov cl,  '9'
    mov dl, cl
    int 21h
    
    mov ah, 02h
    mov cl, " "
    mov dl,cl
    int 21h 
;10
    mov ah, 02h
    mov cl, '1'
    mov dl, cl
    int 21h 
    mov ah, 02h
    mov cl, '0'
    mov dl, cl
    int 21h 
    
    int 27h
    end start