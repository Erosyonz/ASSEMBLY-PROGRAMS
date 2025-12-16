; Filename:Exer18.asm
; Programmer name: Alleah Dela Pena
; Date: September 11, 2025
; This assembly program will get string input and display back string.


.MODEL small
.STACK 100h

.DATA
MAX_LEN EQU 1000
StringInput DB MAX_LEN DUP (?)
InputPrompt DB 'Enter text: $'


.CODE
ProgramStart:
    mov ax, @data
    mov ds, ax

    ; Print prompt
    mov dx, OFFSET InputPrompt
    mov ah, 9
    int 21h

    ; Prepare to read string
    mov ah, 3fh          ; DOS buffered input function
    mov bx, 0
    mov cx, MAX_LEN

    ; Store input length
    mov dx, OFFSET StringInput
    int 21h 
    and ax, ax  
    jz Done  
    mov cx, ax

    push cx  
    mov bx, OFFSET StringInput

    
    pop cx 
    mov ah, 40h 
    mov bx, 1 
    mov dx, OFFSET StringInput 
    int 21h 
Done: 
    mov ah, 4ch 
    int 21h               

END ProgramStart
