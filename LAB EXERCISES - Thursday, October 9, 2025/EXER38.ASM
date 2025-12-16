; Filename: EXER38.ASM
; Programmer Name: Alleah Dela Pena
; Date: October 10, 2025
; Description: Ask user to input a number from 1 to B. Display
; error message if number entered is less than 1 or
; greater than 8. If input is correct, horizontally
; display the numbers, with space between each
; number, from 1 to the number entered by user.

.MODEL SMALL
.STACK 100h
.DATA
    prompt  DB 'Enter a number from 1 to 8: $'
    error   DB 0Dh,0Ah,'Error: Number out of range!$'
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

    ; Get user input (single key)
    MOV AH, 01h
    INT 21h
    SUB AL, '0'          ; Convert ASCII -> number (1–8)
    
    

    ; Validate range 1–8
    CMP AL, 1
    JL SHOW_ERROR
    CMP AL, 8
    JG SHOW_ERROR

    ; Valid input
    MOV CL, AL           ; CL = limit
    MOV BL, 1            ; BL = current number

    MOV AH, 09h
    LEA DX, newline
    INT 21h
DISPLAY_LOOP:
    
    ; Print current number
    MOV AL, BL
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02h
    INT 21h

    ; If not last, print space
    CMP BL, CL
    JE FINISH_DISPLAY
    MOV DL, ' '
    MOV AH, 02h
    INT 21h

    INC BL
    JMP DISPLAY_LOOP

FINISH_DISPLAY:
    ; Print newline
    MOV AH, 09h
    LEA DX, newline
    INT 21h

    JMP INPUT_LOOP       ; Ask again

SHOW_ERROR:
    MOV AH, 09h
    LEA DX, error
    INT 21h
    LEA DX, newline
    INT 21h
    JMP INPUT_LOOP

    ; Exit program (won’t reach here normally)
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
