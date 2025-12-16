; Filename: EXER23.ASM
; Programmer Name: Alleah Dela Pena
; Date: September 12, 2025
; Description: Asks for first, middle, and family name, then displays a greeting.

.MODEL SMALL
.STACK 100H

.DATA
    Registered  DB 'REGISTRATION FORM', 13,10,'$'
    prompt1     DB 'Enter First Name: $'
    prompt2     DB 13,10,'Enter Middle Name: $'
    prompt3     DB 13,10,'Enter Family Name: $'
    greet1      DB 13,10,'Hello, $'
    space       DB ' $'
    exclaim     DB '!$'
    fname       DB 21 DUP('$')
    mname       DB 21 DUP('$')
    lname       DB 21 DUP('$')
    newlineStr  DB 13,10,'$'

NEWLINE MACRO
    mov ah, 9
    mov dx, offset newlineStr
    int 21h
ENDM

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    mov ah, 9
    mov dx, offset Registered
    int 21h

    NEWLINE
    ; Prompt and read first name
    mov ah, 9
    mov dx, offset prompt1
    int 21h

    mov ah, 0Ah
    lea dx, fname
    int 21h

    NEWLINE
    ; Prompt and read middle name
    mov ah, 9
    mov dx, offset prompt2
    int 21h

    mov ah, 0Ah
    lea dx, mname
    int 21h

    NEWLINE
    ; Prompt and read family name
    mov ah, 9
    mov dx, offset prompt3
    int 21h

    mov ah, 0Ah
    lea dx, lname
    int 21h

    NEWLINE
    ; Display greeting
    mov ah, 9
    mov dx, offset greet1
    int 21h

    ; Print first name
    lea si, fname
    mov cl, [si+1]      ; length of input
    mov ch, 0
    add si, 2           ; point to first char
PRINT_FNAME:
    cmp cl, 0
    je PRINT_MNAME
    mov dl, [si]
    mov ah, 2
    int 21h
    inc si
    dec cl
    jmp PRINT_FNAME

PRINT_MNAME:
    mov ah, 9
    mov dx, offset space
    int 21h

    lea si, mname
    mov cl, [si+1]
    mov ch, 0
    add si, 2
PRINT_MNAME_LOOP:
    cmp cl, 0
    je PRINT_LNAME
    mov dl, [si]
    mov ah, 2
    int 21h
    inc si
    dec cl
    jmp PRINT_MNAME_LOOP

PRINT_LNAME:
    mov ah, 9
    mov dx, offset space
    int 21h

    lea si, lname
    mov cl, [si+1]
    mov ch, 0
    add si, 2
PRINT_LNAME_LOOP:
    cmp cl, 0
    je PRINT_EXCLAIM
    mov dl, [si]
    mov ah, 2
    int 21h
    inc si
    dec cl
    jmp PRINT_LNAME_LOOP

PRINT_EXCLAIM:
    mov ah, 9
    mov dx, offset exclaim
    int 21h

    ; Exit
    mov ah, 4Ch
    int 21h
MAIN ENDP
END MAIN