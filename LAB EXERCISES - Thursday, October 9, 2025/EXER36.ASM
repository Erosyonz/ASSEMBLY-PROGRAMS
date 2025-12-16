; Filename: EXER36.ASM
; Programmer Name: Alleah Dela Pena
; Date: October 10, 2025
; Description: Using a loop, vertically display the numbers 1 to 10.

.MODEL SMALL
.STACK 100h
.DATA
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV AH, 00h
    MOV AL, 03h
    INT 10h
    
    MOV CX, 10          ; Loop counter from 1 to 10
    MOV BX, 1           ; Start with number 1
    
DISPLAY_LOOP:
    ; Convert number in BX to ASCII and display
    MOV AX, BX
    CALL PRINT_NUM       ; Print number (supports 2 digits)
    
    ; Move to next line
    MOV AH, 02h
    MOV DL, 0Dh          ; Carriage return
    INT 21h
    MOV DL, 0Ah          ; Line feed
    INT 21h

    INC BX
    LOOP DISPLAY_LOOP
    
    ; Exit program
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

;------------------------------------------
; PRINT_NUM - prints number in AX (1–99)
;------------------------------------------
PRINT_NUM PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV CX, 0
    MOV BX, 10

CONVERT_LOOP:
    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNZ CONVERT_LOOP

PRINT_LOOP:
    POP DX
    ADD DL, '0'
    MOV AH, 02h
    INT 21h
    LOOP PRINT_LOOP

    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUM ENDP

END MAIN
