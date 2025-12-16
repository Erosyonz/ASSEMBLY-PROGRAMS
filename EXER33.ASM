; Filename: EXER27.ASM
; Programmer Name: Alleah Dela Pena
; Date: October 6, 2025
; Description: Create a program that inputs a number. Display the following messages depending on the value of the number
; "The number is equal to 5."
; "The number is less than 5."
; "The number is greater than 5."

.model small
.stack 100h

.data
    prompt db 'Enter a number (0-9): $'
    msgEqual db 0Dh, 0Ah, 'The number is equal to 5.', '$'
    msgLess db 0Dh, 0Ah, 'The number is less than 5.', '$'
    msgGreater db 0Dh, 0Ah, 'The number is greater than 5.', '$'

.code
main proc
    mov ax, @data
    mov ds, ax
    
    ; Display prompt
    mov ah, 09h
    lea dx, prompt
    int 21h
    
    ; Read number
    mov ah, 01h
    int 21h
    sub al, '0'  ; Convert ASCII to number
    
    ; Compare with 5
    cmp al, 5
    je equal
    jl less
    jg greater
    
equal:
    mov ah, 09h
    lea dx, msgEqual
    int 21h
    jmp exit_program
    
less:
    mov ah, 09h
    lea dx, msgLess
    int 21h
    jmp exit_program
    
greater:
    mov ah, 09h
    lea dx, msgGreater
    int 21h
    
exit_program:
    mov ax, 4c00h
    int 21h
main endp
end main