
; Filename: EXER22.ASM
; Programmer Name: Alleah Dela Pena
; Date: September 12, 2025
; Description: This assembly language programa program will asks user to input a character. Determine if character is letter A and display message "Yes, you have entered letter A." If not, display "No, you have not entered letter A. You entered character _."


.MODEL SMALL
.STACK 100H

.DATA
    prompt      DB 'Enter a character: $'
    yesMsg      DB 13,10,'Yes, you have entered letter A.$'
    noMsg       DB 13,10,'No, you have not entered letter A. You entered character ', '$'
    newlineStr  DB 13,10,'$'
    inputChar   DB ?
    dot         DB '.','$'
NEWLINE MACRO
    mov ah, 9
    mov dx, offset newlineStr
    int 21h
ENDM

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Prompt user
    mov ah, 9
    mov dx, offset prompt
    int 21h

    ; Read character
    mov ah, 1
    int 21h
    mov inputChar, al

    cmp al, 'A'
    je IS_A
    cmp al, 'a'
    jne NOT_A
    IS_A:
    mov ah, 9
    mov dx, offset yesMsg
    int 21h
    jmp EXIT

    ; If 'A'
    mov ah, 9
    mov dx, offset yesMsg
    int 21h
    jmp EXIT

NOT_A:
    mov ah, 9
    mov dx, offset noMsg
    int 21h

    mov dl, inputChar
    mov ah, 2
    int 21h

    mov ah, 9
    mov dx, offset dot
    int 21h
EXIT:
    mov ah, 4ch
    int 21h
MAIN ENDP
END MAIN