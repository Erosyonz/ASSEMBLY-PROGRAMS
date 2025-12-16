; Filename: EXER37.ASM
; Programmer Name: Alleah Dela Pena
; Date: October 10, 2025
; Description: Using a loop, horizontally display the numbers 1 to 20, WIth space between each number.

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

    MOV CX, 20      ; Loop 20 times for numbers 1–20
    MOV BX, 1       ; Start number = 1

DISPLAY_LOOP:
    MOV AX, BX
    CALL PRINT_NUM  ; Print number in AX

    ; Print space (except after last number)
    CMP BX, 20
    JE SKIP_SPACE
    MOV DL, ' '
    MOV AH, 02h
    INT 21h

SKIP_SPACE:
    INC BX          ; Next number
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
