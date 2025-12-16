; Filename:Exer18.asm
; Programmer name: Alleah Dela Pena
; Date: September 11, 2025
; This assembly program will get character input and determine if input is y or Y to display good mroning message else display good afternoon message.


.MODEL small
.STACK 100h
.DATA
    TimePrompt DB 'Is it after 12 noon (Y/N)?$'

    GoodMorningMessage LABEL BYTE
        DB 13,10,'Good morning, world!',13,10,'$'

    GoodAfternoonMessage LABEL BYTE
        DB 13,10,'Good afternoon, world!',13,10,'$'

.CODE
ProgramStart:
    mov ax, @data
    mov ds, ax                          ; set DS to point to data segment

    mov dx, OFFSET TimePrompt           ; point to the time prompt
    mov ah, 9                           ; DOS print string function
    int 21h                             ; display time prompt

    mov ah, 1                           ; DOS get character function
    int 21h                             ; get single character response

    cmp al, 'y'                         ; typed lowercase ‘y’ for after noon?
    jz IsAfternoon                      ; jz = jump if zero. Yes, it’s afternoon

    cmp al, 'Y'                         ; typed uppercase ‘Y’ for afternoon?
    jz IsAfternoon                      ; same: jump to afternoon if yes

IsMorning:
    mov dx, OFFSET GoodMorningMessage  ; point to before noon greeting
    jmp DisplayGreeting                 ; go display it

IsAfternoon:
    mov dx, OFFSET GoodAfternoonMessage ; point to the afternoon greeting

DisplayGreeting:
    mov ah, 9                           ; DOS print string function
    int 21h                             ; display the greeting

    mov ah, 4Ch                         ; DOS terminate program function
    int 21h                             ; terminate program

END ProgramStart
