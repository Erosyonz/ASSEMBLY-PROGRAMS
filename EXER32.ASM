; Filename: EXER27.ASM
; Programmer Name: Alleah Dela Pena
; Date: October 6, 2025
; Description: Create a program that inputs a character. If the character is the capital letter A, display message "You entered A.", else display "You entered not A"

.model small
.stack 100h

.data
    prompt db 'Enter a character: $'
    msgA db 0Dh, 0Ah, 'You entered A.', '$'
    msgNotA db 0Dh, 0Ah, 'You entered not A.', '$'

.code
main proc
    mov ax, @data
    mov ds, ax
    
    ; Display prompt
    mov ah, 09h
    lea dx, prompt
    int 21h
    
    ; Read character
    mov ah, 01h
    int 21h
    
    ; Compare with 'A'
    cmp al, 'A'
    cmp al, 'a'\
    je is_A
    
    ; Not A
    mov ah, 09h
    lea dx, msgNotA
    int 21h
    jmp exit_program
    
is_A:
    mov ah, 09h
    lea dx, msgA
    int 21h
    
exit_program:
    mov ax, 4c00h
    int 21h
main endp
end main