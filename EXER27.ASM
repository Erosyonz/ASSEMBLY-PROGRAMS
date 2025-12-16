; Filename: EXER27.ASM
; Programmer Name: Alleah Dela Pena
; Date: October 6, 2025
; Description: Program to accept 3 string inputs and output again the 3 strings on separate lines.


.MODEL SMALL
.STACK 100h

.DATA
inputString1 DB 50 DUP('$')
inputString2 DB 50 DUP('$')  
inputString3 DB 50 DUP('$')
promptString1 DB 'Enter first string: $'
promptString2 DB 'Enter second string: $'
promptString3 DB 'Enter third string: $'
outputString1 DB 'You entered first string: $'
outputString2 DB 'You entered second string: $'
outputString3 DB 'You entered third string: $'
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
StringInput MACRO buffNum
    LEA DX, buffNum
    MOV AH, 0Ah
    INT 21h
ENDM
OutputInput MACRO buffNum
    LEA DX, buffNum + 2
    MOV AH, 09h
    INT 21h
ENDM


.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ; Prompt and read first string
    StringOutput promptString1
    StringInput inputString1
    NEWLINE
    ; New line
    
    
    ; Prompt and read second string  
    StringOutput promptString2
    StringInput inputString2
    NEWLINE
    
    ; Prompt and read third string
    StringOutput promptString3
    StringInput inputString3
    NEWLINE
    

    ; Display outputs
    StringOutput outputString1
    OutputInput inputString1 
    NEWLINE
    
    StringOutput outputString2
    OutputInput inputString2
    NEWLINE

    StringOutput outputString3
    OutputInput inputString3
    NEWLINE

    MOV AX, 4C00h
    INT 21h
MAIN ENDP
END MAIN