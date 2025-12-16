;File name: EXER6.ASM
;Display any 20 special character with space in between
;Alleah Dela Pena
;August 28,2025

.model small
.code
 SpecialChar MACRO Special 
    mov ah, 02H
    mov dl, Special
    int 21h
 ENDM
 Space MACRO 
        mov ah, 02H
        mov dl, ' '
        int 21h
 ENDM
 NewLine MACRO params
    mov ah, 02H
    mov dl, 0AH 
    int 21h
 ENDM



.stack 100
start:
    SpecialChar '0'
    Space
    SpecialChar '1'
    Space
    SpecialChar '2'
    Space
    SpecialChar '3'
    Space
    SpecialChar '4'
    Space
    SpecialChar '5'
    Space
    SpecialChar '6'
    Space
    SpecialChar '7'
    Space
    SpecialChar '8'
    Space
    SpecialChar '9'
    Space

    NewLine

    SpecialChar '!'
    Space
    SpecialChar '@'
    Space
    SpecialChar '#'
    Space
    SpecialChar '$'
    Space
    SpecialChar '%'
    Space
    SpecialChar '^'
    Space
    SpecialChar '&'
    Space
    SpecialChar '*'
    Space
    SpecialChar '('
    Space
    SpecialChar ')'
    Space

    NewLine

    SpecialChar '-'
    Space
    SpecialChar '_'
    Space
    SpecialChar '+'
    Space
    SpecialChar '='
    Space
    SpecialChar '{'
    Space
    SpecialChar '}'
    Space
    SpecialChar '['
    Space
    SpecialChar ']'
    Space
    SpecialChar '<'
    Space
    SpecialChar '?'
    Space

int 27h
end start
