; Filename: EXER27.ASM
; Programmer Name: Alleah Dela Pena
; Date: October 6, 2025
; Description: Make a program to input two integers. Compare the two integers.
; Display which one is greater and which one is smaller.

.model small
.stack 100h

.data
    prompt1 db 'Enter first number (0-9): $'
    prompt2 db 0Dh, 0Ah, 'Enter second number (0-9): $'
    msgGreater db 0Dh, 0Ah, 'Bigger number: $'
    msgSmaller db 0Dh, 0Ah, 'Smaller number: $'
    msgEqual db 0Dh, 0Ah, 'Both numbers are equal.', '$'
    num1 db ?
    num2 db ?

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Prompt and input first number
    mov ah, 09h
    lea dx, prompt1
    int 21h
    mov ah, 01h
    int 21h
    sub al, '0'
    mov num1, al

    ; Prompt and input second number
    mov ah, 09h
    lea dx, prompt2
    int 21h
    mov ah, 01h
    int 21h
    sub al, '0'
    mov num2, al

    ; Compare num1 and num2
    mov al, num1
    cmp al, num2
    je equal

    ; If not equal, determine which is greater and smaller
    ja first_is_greater ; unsigned compare (both values are between 0–9)

second_is_greater:
    ; Display greater = num2
    mov ah, 09h
    lea dx, msgGreater
    int 21h
    mov al, num2
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h

    ; Display smaller = num1
    mov ah, 09h
    lea dx, msgSmaller
    int 21h
    mov al, num1
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h

    jmp exit_program

first_is_greater:
    ; Display greater = num1
    mov ah, 09h
    lea dx, msgGreater
    int 21h
    mov al, num1
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h

    ; Display smaller = num2
    mov ah, 09h
    lea dx, msgSmaller
    int 21h
    mov al, num2
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h

    jmp exit_program

equal:
    ; Display "Both numbers are equal"
    mov ah, 09h
    lea dx, msgEqual
    int 21h

exit_program:
    mov ax, 4C00h
    int 21h

main endp
end main
