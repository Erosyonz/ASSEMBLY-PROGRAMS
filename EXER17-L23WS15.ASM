; Filename:Exer17.asm
; Programmer name: Alleah Dela Pena
; Date: September 11, 2025
; This assembly program will continuoesly get character input and display back input until enter key is pressed

.MODEL small
.STACK 200h
.DATA
    String1 DB 'SURE! ', 13,10, '$'
    String2 DB 'GEATAY!', 13,10, '$'
.CODE
ProgramStart:
    EchoLoop:
        mov ax, @data
        mov ds, ax
        
        mov ah, 09h
        mov dx, OFFSET String1
        INT 21H

        mov ah, 1
        int 21h

        cmp al, 13          ; compare input with Enter key (carriage return)
        jz EchoDone       ; if Enter key, jump to done

        mov dl, al           ; move input character to DL for display
        mov ah, 2
        int 21h              ; display the character

        mov ah, 9 
        mov dx, OFFSET string2 
        int 21h

        jmp EchoLoop         ; repeat the loop
    EchoDone:
        mov ax, 4CH
        int 21h
        ret
    ;EchoLoop ENDP

END ProgramStart