;Filename: EXER9.ASM
; Display: Display imojis and blinking characters
; Name: Alleah Dela Pena
; Date: 8/31/2024Z

.model small
.code
.stack
    Letter MACRO letter, color
       

        MOV AH, 09h
        mov bl, color
        MOV CX, 1
        INT 10H

        
        mov ah, 02h
        mov dl, letter
        int 21h
    ENDM

    Space Macro 
    mov ah, 02h
    mov dl, ' '
    int 21h
    ENDM

start:

    Letter 'I', 0Eh
    Space
    Letter 03h, 04H
    Space
    Letter 'U', 0Eh
    
end start