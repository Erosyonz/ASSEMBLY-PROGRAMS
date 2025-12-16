; Filename:Exer.asm
; Displaying single characters, numbers, and symbols
; Name: Alleah Dela Pena;
; Date: August 14, 2025

    .model small ; directive to use "small" memory model
    .code ; section of program containing executable code.
    .stack 100 ;define the size of the program's stack.
    start: ; start of program



    mov ah, 02h
    mov cl,  'I';
    mov dl,cl
    int 21h 

    mov ah, 02h
    mov cl,  'D';
    mov dl,cl
    int 21h 

    mov ah, 02h
    mov cl, " "
    mov dl,cl
    int 21h

    mov ah, 02h
    mov cl, 'N'
    mov dl,cl;
    int 21h 

    mov ah, 02h
    mov cl, 'O'
    mov dl,cl
    int 21h

    mov ah,02h
    mov cl, ":";
    mov dl,cl 
    int 21h

    mov ah,02h
    mov cl, ' '
    mov dl,cl 
    int 21h

    mov ah, 02h
    mov cl, '2'
    mov dl,cl 
    int 21h

    mov ah,02h
    mov cl, '4'
    mov dl,cl 
    int 21h

    mov ah, 02h
    mov cl, '-'
    mov dl,cl 
    int 21h

    mov ah, 02h
    mov cl, '4'
    mov dl,cl 
    int 21h
    
    mov ah, 02h
    mov cl, '8'
    mov dl,cl 
    int 21h

    mov ah, 02h
    mov cl, '3'
    mov dl,cl 
    int 21h

    mov ah, 02h
    mov cl, '1'
    mov dl,cl 
    int 21h 

    mov ah, 02h
    mov cl, '-'
    mov dl,cl 
    int 21h

    mov ah, 02h
    mov cl, '4'
    mov dl,cl 
    int 21h

    mov ah ,02h
    mov cl, '5'
    mov dl,cl 
    int 21h

    mov ah,02h
    mov cl, '8'
    mov dl,cl 
    int 21h 

    mov ah, 02h
    mov cl, 0Ah
    mov dl,cl 
    int 21h

    mov ah,02h
    mov cl, 'F'
    mov dl,cl 
    int 21h

    mov ah, 02h
    mov cl, 'I'
    mov dl,cl 
    int 21h 

    mov ah, 02h
    mov cl, 'R'
    mov dl,cl 
    int 21h 

    mov ah, 02h
    mov cl, 'S'
    MOV DL,CL  
    INT 21H

    MOV AH, 02h
    MOV CL, 'T'
    MOV DL,CL 
    INT 21H 

    MOV AH, 02H
    MOV CL, ':'
    MOV DL,CL 
    INT 21H

    MOV AH, 02h
    MOV CL, ' '
    MOV DL,CL 
    INT 21H 

    MOV AH, 02h
    MOV CL, 'A'
    MOV DL,CL 
    INT 21H 
    
    MOV AH, 02H 
    MOV CL, 'L'
    MOV DL,CL 
    INT 21H 

    MOV AH, 02h
    MOV CL, 'L'
    MOV DL,CL  
    INT 21H 

    MOV AH, 02H 
    MOV CL, 'E'
    MOV DL,CL 
    INT 21H 

    MOV AH, 02H  
    MOV CL, 'A'
    MOV DL,CL 
    INT 21H 

    MOV AH, 02H 
    MOV CL, 'H'
    MOV DL,CL 
    INT 21H

    MOV AH, 02h
    MOV CL, 0aH
    MOV DL,CL 
    INT 21H

    MOV AH, 02H 
    MOV CL, 'M'
    MOV DL,CL 
    INT 21H

    MOV AH, 02h
    MOV CL, 'I'
    MOV DL,CL
    INT 21H

    MOV AH, 02H 
    MOV CL, 'D'
    MOV DL,CL  
    INT 21H

    MOV AH, 02H 
    MOV CL, 'D'
    MOV DL,CL 
    INT 21H 

    MOV AH, 02H
    MOV CL, 'L'
    MOV DL,CL 
    INT 21H

    MOV AH, 02H
    MOV CL, 'E'
    MOV DL,CL 
    INT 21H 

    MOV AH, 02H 
    MOV CL, ':'
    MOV DL, CL
    INT  21H

    mov ah, 02H
    mov cl, ' '
    mov dl,cl 
    int 21h 

    mov ah, 02h 
    mov cl, 'I'
    MOV DL,CL 
    INT 21H 

    MOV AH, 02H 
    MOV CL, 'N'
    MOV DL,CL 
    INT 21H 

    MOV AH, 02h
    MOV CL,  'O'
    MOV DL,CL 
    INT 21H 

    MOV AH, 02h
    MOV DL, 'C'
    INT 21H

    MOV AH, 02h
    MOV CL, 0aH
    MOV DL,CL 
    INT 21H

    MOV AH, 02H 
    MOV CL, 'L'
    MOV DL,CL  
    INT 21H 

    MOV AH, 02H 
    MOV CL, 'A'
    MOV DL,CL 
    INT 21H

    MOV AH, 02h
    MOV CL, 'S'
    MOV DL,CL 
    INT 21H

    MOV AH, 02H 
    MOV CL, 'T'
    MOV DL,CL 
    INT 21H

    MOV AH, 02H 
    MOV CL, ':'
    MOV DL,CL 
    INT 21H 

    MOV AH, 02H 
    MOV CL, ' '
    MOV DL,CL 
    INT 21H 

    MOV AH, 02H 
    MOV CL, 'D'
    MOV DL,CL 
    INT 21H 

    MOV AH, 02H 
    MOV CL, 'E'
    MOV DL,CL 
    INT 21H 

    MOV AH, 02H 
    MOV CL, 'L'
    MOV DL,CL 
    INT 21H 

    MOV AH, 02H 
    MOV CL, 'A'
    MOV DL,CL  
    INT 21H

    MOV AH, 02H
    MOV CL, ' '
    MOV DL,CL 
    INT 21H 

    MOV AH, 02H 
    MOV CL, 'P'
    MOV DL,CL 
    INT 21H

    MOV AH, 02H 
    MOV CL, 'E'
    MOV DL,CL 
    INT 21H

    MOV AH, 02H 
    MOV CL, 'N'
    MOV DL,CL 
    INT 21H

    MOV AH, 02h
    MOV CL, 'A'
    MOV DL,CL 
    INT 21H

    MOV AH, 02H 
    MOV CL, 0AH
    MOV DL,CL 
    INT 21H

    MOV AH, 02H 
    MOV CL, 'C'
    MOV DL,CL 
    INT 21H 

    MOV AH, 02H 
    MOV CL, 'O'
    MOV DL,CL 
    INT 21H 

    MOV AH, 02h
    MOV CL, 'U'
    MOV DL,CL 
    INT 21H  

    MOV AH, 02H 
    MOV CL, 'R'
    MOV DL,CL 
    INT 21H 
    
    MOV AH, 02H 
    MOV CL,  'S'
    MOV DL,CL 
    INT 21H 

    MOV AH, 02h
    MOV CL, 'E'
    MOV DL,CL 
    INT 21H 

    MOV AH, 02H 
    MOV CL, ' '
    MOV DL,CL 
    INT 21H 


    MOV AH, 02H 
    MOV CL, 'A'
    MOV DL,CL
    INT 21H

    MOV AH, 02H 
    MOV CL, 'N'
    MOV DL,CL 
    INT 21H 

    MOV AH, 02H 
    MOV CL ,'D'
    MOV DL,CL 
    INT 21H 

    MOV AH, 02H 
    MOV CL , ' '
    MOV DL,CL 
    INT 21H

    MOV AH, 02H 
    MOV CL, 'Y'
    MOV DL,CL 
    INT 21H 

    MOV AH, 02H 
    MOV CL, 'E'
    MOV DL,CL 
    INT 21H 

    MOV AH, 02h
    MOV CL, 'A'
    MOV DL,CL 
    INT 21H

    MOV AH, 02h
    MOV CL, 'R'
    MOV DL,CL 
    INT 21H 

    MOV AH, 02H 
    MOV CL, ':'
    MOV DL,CL 
    INT 21H 

    MOV AH, 02H 
    MOV CL, ' '
    MOV DL,CL 
    INT 21H


int 27h
end start   



