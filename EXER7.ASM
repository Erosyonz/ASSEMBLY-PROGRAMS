;Filename: EXER7.ASM
; Displaying with different foreground and background colors
; Name: Alleah Dela Pena
; Date: August 28, 2025
 
.model small
.code
.stack 1000
start:
 
; Set video mode
mov ah, 00h
mov al, 03h  ; 80x25 text mode
int 10h
 
; Display "COLLEGE" - Yellow background, Black foreground
mov ah, 09h
mov bl, 0E0h AND 7Fh  ; Black foreground (0), Yellow background (E)
mov cx, 7      ; Number of characters to color
int 10h
 
mov ah, 02h
mov dl, 'C'
int 21h
mov dl, 'o'
int 21h
mov dl, 'l'
int 21h
mov dl, 'l'
int 21h
mov dl, 'e'
int 21h
mov dl, 'g'
int 21h
mov dl, 'e'
int 21h
 
; Reset color and add newline
mov ah, 09h
mov bl, 07h    ; Reset to default
mov cx, 0
int 10h
mov ah, 02h
mov dl, 0Ah
int 21h
mov dl, 0Dh
int 21h
 
; Display "Of" - Red background, Yellow foreground
mov ah, 09h
mov bl, 4Eh    ; Yellow foreground (E), Red background (4)
mov cx, 2      ; "Of" has 2 characters
int 10h
 
mov ah, 02h
mov dl, 'O'
int 21h
mov dl, 'f'
int 21h
 
; Reset color and add newline
mov ah, 09h
mov bl, 07h
mov cx, 0
int 10h
mov ah, 02h
mov dl, 0Ah
int 21h
mov dl, 0Dh
int 21h
 
; Display "Computer" - Blue background, Red foreground
mov ah, 09h
mov bl, 14h    ; Red foreground (4), Blue background (1)
mov cx, 8      ; "Computer" has 8 characters
int 10h
 
mov ah, 02h
mov dl, 'C'
int 21h
mov dl, 'o'
int 21h
mov dl, 'm'
int 21h
mov dl, 'p'
int 21h
mov dl, 'u'
int 21h
mov dl, 't'
int 21h
mov dl, 'e'
int 21h
mov dl, 'r'
int 21h
 
; Reset color and add newline
mov ah, 09h
mov bl, 07h
mov cx, 0
int 10h
mov ah, 02h
mov dl, 0Ah
int 21h
mov dl, 0Dh
int 21h
 
; Display "Science" - Black background, White foreground
mov ah, 09h
mov bl, 07h    ; White foreground (7), Black background (0)
mov cx, 7      ; "Science" has 7 characters
int 10h
 
mov ah, 02h
mov dl, 'S'
int 21h
mov dl, 't'
int 21h
mov dl, 'u'
int 21h
mov dl, 'd'
int 21h
mov dl, 'i'
int 21h
mov dl, 'e'
int 21h
mov dl, 's'
int 21h
 
; Exit program
mov ax, 4C00h
int 21h
 
end start