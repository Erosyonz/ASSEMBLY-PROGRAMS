; Filename: EXER29.ASM
; Programmer Name: Alleah Dela Pena
; Date: October 6, 2025
; Description: Input two single-digit numbers, divide the two numbers, and display the quotient of the two numbers.
.model small
.stack 100h

.data
     msg1 db 'Enter first number (0-9): $'
    msg2 db 'Enter second number (0-9): $'
    ERROR db 'ayaw zero gaw!!!: $'
    resultMsg db 'The result is: $'
    num1 db ?
    num2 db ?
    result db ?

.code
NEWLINE MACRO
    MOV AH, 02h
    MOV DL, 13       ; Carriage return
    INT 21h
    MOV DL, 10       ; Line feed
    INT 21h
ENDM   
StringOutput MACRO StrDisplay
    LEA DX, StrDisplay
    MOV AH, 09h
    INT 21h
ENDM
NumInput MACRO buffNum
    call read_number
    mov buffNum, al
ENDM

MultiplyCalculate MACRO n1, n2, location
    MOV AL, n1
    xor ah, ah
    MOV BL, n2
    DIV BL
    MOV location, AL
ENDM
start:
    mov ax, @data
    mov ds, ax
    
    ; Prompt for first number   
    StringOutput msg1
    NumInput num1
    NEWLINE

    ; Prompt for second number
    StringOutput msg2
    NumInput num2
    NEWLINE
    
      
    ; Check for division by zero
    cmp num2, 0
    je div_by_zero


    ; Subtract
    MultiplyCalculate num1, num2, result
 
    ; Display result
    StringOutput resultMsg
    call print_result
    
    mov ax, 4C00h
    int 21h

div_by_zero:
   StringOutput msg2
   StringOutput ERROR
    mov ax, 4C00h
    int 21h

read_number proc
    mov ah, 01h
    int 21h
    sub al, '0'
    ret
read_number endp

print_result proc
    add result, '0'
    mov ah, 0Eh
    mov al, result
    int 10h
    ret
print_result endp

end start