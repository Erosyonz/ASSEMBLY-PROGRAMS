;Filename: EXER8.ASM
; Display: Display colored patterns (big cross)using just spaces
; redcross(6x8)
; Name: Alleah Dela Pena
; Date: 8/30/2024
.model small
.code
.stack 100
    Space MACRO color, size
     
    mov ah, 02h
    mov dl, ' '
    int 21h

    
    mov ah, 09h
    mov bl, color
    mov cx, size
    int 10h  

    

    ENDM
    
    ResetSpace MACRO


    mov ah, 09h
    mov bl, 07h
    mov cx, 1    
    int 10h
    ENDM


    ResetLine MACRO
    mov ah, 02h
    mov dl, 0Ah        ; line feed
    int 21h

    mov ah, 09h
    mov bl, 07h
    mov cx, 1
    int 10h

    
    
    ENDM


    
 

start:
    
    ;1st row
    Space 11h, 8
    
    ;2nd row
    ResetLine
    Space 12h, 8
    Space 12h, 4
    Space 12h, 4
    Space 40h, 2

    ;4th row
    ResetLine
    Space 12h, 8
    Space 40h, 6
    
    ;3rd row
    ResetLine
    Space 12h, 8
    Space 12h, 4
    Space 12h, 4
    Space 40h, 2

    ;5th row
    ResetLine
    Space 12h, 8
    Space 12h, 4
    Space 12h, 4
    Space 40h, 2
    ;6th row
    ResetLine
    Space 12h, 8


    mov ax, 4C00h
 int 21h
end start