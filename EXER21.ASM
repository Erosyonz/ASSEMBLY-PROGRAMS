; filepath: c:\Users\Arvy\OneDrive - Cebu Institute of Technology University\CS243DELAPENA\EXER21.ASM

; Filename: EXER21.ASM
; Programmer Name: Alleah Dela Pena
; Date: September 12, 2025
; Description: This assembly language programa program will asks the user to input 3 characters. Then display each character on its own line.

.MODEL SMALL
.STACK 100H

.DATA
    prompt      DB 'Enter 3 characters: $'
    charArr     DB 3 DUP(?)
    
    String1    DB 'Enter first character: ', '$'
    String2    DB 13,10,'Enter second character: ', '$'
    String3    DB 13,10,'Enter third character: ', '$'
    String4    DB 13,10,'The first character is: ', '$'
    String5    DB 13,10,'The second character is: ', '$'
    String6    DB 13,10,'The third character is: ', '$'
    newlineStr DB 13,10,'$'
NEWLINE MACRO
    mov ah, 9
    mov dx, offset newlineStr
    int 21h
ENDM
.CODE
MAIN PROC
   MOV AX, @DATA
    MOV DS, AX

    ; Read first character
    mov ah, 9
    mov dx, offset String1
    int 21h
    
    mov ah, 1
    int 21h
    mov charArr, al

    NEWLINE
    ; Read second character
    mov ah, 9
    mov dx, offset String2
    int 21h

    mov ah, 1
    int 21h
    mov charArr+1, al
    
    NEWLINE
    ; Read third character
    mov ah, 9
    mov dx, offset String3
    int 21h

    mov ah, 1
    int 21h
    mov charArr+2, al
    
    NEWLINE
    ; Print each character on its own line
    lea si, charArr
    mov cx, 3

PRINT_LOOP:

    ; Print first character
    mov ah, 9
    mov dx, offset String4
    int 21h

    mov dl, charArr
    mov ah, 2
    int 21h

    NEWLINE
    
    ; Print second character
    mov ah, 9
    mov dx, offset String5
    int 21h

    mov dl, charArr+1
    mov ah, 2
    int 21h

    NEWLINE
    ; Print third character
    mov ah, 9
    mov dx, offset String6
    int 21h

    mov dl, charArr+2
    mov ah, 2
    int 21h

     NEWLINE   
    ; Exit program
    mov ah, 4ch
    int 21h
; End of program
MAIN ENDP
END MAIN