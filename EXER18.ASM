; Filename: EXER18.ASM
; Programmer Name: ALLEAH DELA PENA
; Date: September 12, 2025
; Description: Get char input. If 'y' or 'Y', print Good Afternoon. Else, Good Morning.

.MODEL small
.STACK 100h
.DATA
    TimePrompt DB 'Is it after 12 noon (Y/N)?$'
    GoodMorningMessage DB 13,10,'Good morning, world!',13,10,'$'
    GoodAfternoonMessage DB 13,10,'Good afternoon, world!',13,10,'$'

.CODE
ProgramStart:
    mov ax,@data
    mov ds,ax

    mov dx,OFFSET TimePrompt
    mov ah,9
    int 21h

    mov ah,1
    int 21h

    cmp al,'y'
    jz IsAfternoon
    cmp al,'Y'
    jz IsAfternoon

IsMorning:
    mov dx,OFFSET GoodMorningMessage
    jmp DisplayGreeting

IsAfternoon:
    mov dx,OFFSET GoodAfternoonMessage

DisplayGreeting:
    mov ah,9
    int 21h

    mov ah,4ch
    int 21h
END ProgramStart
