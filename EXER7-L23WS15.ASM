;Filename: EXER7.ASM
;Display different foreground and background colors
;Alleah Dela Pena
;August 28, 2025

.model small
.code
    NewLine MACRO 
        mov ah, 02h
        mov dl, 0AH
        int 21h
    ENDM

    ColorDisplay MACRO size, BG, FG
    mov ah, 00h
    mov al, 03h  ; 80x25 text mode 
    mov ah, 09h
    mov bl, (BG SHL 4) OR FG
    mov cx, size      ; Number of characters to color
    int 10h  

     mov dx, 03CAh
     in  al, dx 
    ENDM

    ColorDisplayEnd MACRO
    mov ah, 09h
    mov bl, 07h    ; Reset to default
    mov cx, 0
    int 10h 
    
    ENDM

    printChar MACRO Char
    mov ah, 02H
    mov dl, Char
    int 21h 
    ENDM
.stack 1000
start:
; Display "COLLEGE" - Yellow background, Black foreground
    ColorDisplay 7,6, 0
    printChar 'C'
    printChar 'O'
    printChar 'L'
    printChar 'L'
    printChar 'E'
    printChar 'G'
    printChar 'E'
    ColorDisplayEnd
    
    NewLine
    

    ColorDisplay 2, 4, 14   ; BG=4 (red), FG=0Eh (yellow) 
    printChar 'O'
    printChar 'F'
    ColorDisplayEnd

    



end start