;File name: EXER5.ASM
;display alphabetical letter
;Alleah Dela Pena
;Date:  august 28,2025

.model small
.code
    printChar MACRO Char
        mov ah, 02H
        mov dl, Char
        int 21h 
    ENDM

    Space MACRO 
        mov ah, 02H
        mov dl, " "
        int 21H
    ENDM    
.stack 100
start:

    printChar 'A'
    Space
    printChar 'B'
    Space
    printChar 'C'
    Space
    printChar 'D'
    Space
    printChar 'E'
    Space
    printChar 'F'
    Space
    printChar 'G'
    Space
    printChar 'H'
    Space
    printChar 'I'
    Space
    printChar 'J'
    Space
    printChar 'K'
    Space
    printChar 'L'
    Space
    printChar 'M'
    Space
    printChar 'N'
    Space
    printChar 'O'
    Space
    printChar 'P'
    Space
    printChar 'Q'
    Space
    printChar 'R'
    Space
    printChar 'S'
    Space
    printChar 'T'
    Space
    printChar 'U'
    Space
    printChar 'V'
    Space
    printChar 'W'
    Space
    printChar 'X'
    Space
    printChar 'Y'
    Space
    printChar 'Z'
    
    

int 27h
end start
