; Program: Input 3 characters and display each on its own line
; Author: Alleah Dela Pena

.MODEL small
.STACK 100h
.DATA
    prompt1  db  13,10,'Enter first characters: ', '$'
    prompt2  db 13,10,'Enter second characters: ', '$'
    prompt3  db 13,10,'Enter third characters: ', '$'
    char1   db ?
    char2   db ?
    char3   db ?
    crlf    db 13,10,'$'

.CODE
main PROC
    mov ax, @data
    mov ds, ax

    ; Prompt user
    mov ah, 9
    mov dx, offset prompt1
    int 21h

    ; Read first character
    mov ah, 1
    int 21h
    mov char1, al

    mov ah, 9
    mov dx, offset prompt2
    int 21h

    ; Read second character
    mov ah, 1
    int 21h
    mov char2, al

    mov ah, 9
    mov dx, offset prompt3
    int 21h

    ; Read third character
    mov ah, 1
    int 21h
    mov char3, al

    ; Print first character with newline
    mov dl, char1
    mov ah, 2
    int 21h
    mov ah, 9
    mov dx, offset crlf
    int 21h

    ; Print second character with newline
    mov dl, char2
    mov ah, 2
    int 21h
    mov ah, 9
    mov dx, offset crlf
    int 21h

    ; Print third character with newline
    mov dl, char3
    mov ah, 2
    int 21h
    mov ah, 9
    mov dx, offset crlf
    int 21h

    ; Exit
    mov ah, 4ch
    int 21h
main ENDP

END main