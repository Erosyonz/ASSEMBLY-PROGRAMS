; Filename: EXER39.ASM
; Programmer Name: Alleah Dela Pena
; Date: October 10, 2025
; Description: Repeatedly ask user to input a single digit whole
; number until the number entered is a zero. Display
; "Thank you." When the number entered is zero.

.MODEL SMALL
.STACK 100h
.DATA
    prompt DB 0Dh,0Ah,'Enter a single digit number: $'
    thank_you DB 0Dh,0Ah,'Thank you.$'
    newline DB 0Dh,0Ah,'$'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

      MOV AH, 00h
    MOV AL, 03h
    INT 10h
    
INPUT_LOOP:
    ; Display prompt
    MOV AH, 09h
    LEA DX, prompt
    INT 21h
    
    ; Get input
    MOV AH, 01h
    INT 21h

   
    ; Check if zero
    CMP AL, '0'
    JE EXIT_PROGRAM
    
    MOV AH, 09h
    LEA DX, newline
    INT 21h 
    ; Continue loop
    JMP INPUT_LOOP
    
    
EXIT_PROGRAM:
    ; Display thank you
    MOV AH, 09h
    LEA DX, newline
    INT 21h 
    MOV AH, 09h
    LEA DX, thank_you
    INT 21h
    
    ; Exit
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN