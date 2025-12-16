; Filename: EXER28.ASM
; Programmer Name: Alleah Dela Pena
; Date: October 6, 2025
; Description: Make a program to input two single-digit numbers, add the two numbers, and display the sum of the two numbers.


.MODEL SMALL
.STACK 100H
.DATA
    num1 DB ?
    num2 DB ?
    sum DB ?
    msg1 DB 'Enter first number (0-9): $'
    msg2 DB 0DH, 0AH, 'Enter second number (0-9): $'
    msg3 DB 0DH, 0AH, 'The sum is: $'

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
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV buffNum, AL
ENDM
SumCalculate MACRO n1, n2, location
    MOV AL, n1
    ADD AL, n2
    MOV location, AL
ENDM
DisplayCalculation MACRO
    ADD sum, '0'
    MOV DL, sum
    MOV AH, 02H
    INT 21H
ENDM   
.CODE


MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ; Input first number
    StringOutput msg1
    NumInput num1
    
    
    ; Input second number

    StringOutput msg2
    NumInput num2
    
    ; Calculate sum
    SumCalculate num1, num2, sum
    
    ; Display result
    StringOutput msg3
    DisplayCalculation

    MOV AX, 4C00H
    INT 21H
MAIN ENDP
END MAIN