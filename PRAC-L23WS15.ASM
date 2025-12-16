; ; VEHICLE STICKER APPLICATION FORM - BASIC TEXT UI EXAMPLE
; ; Author: ChatGPT
; ; Date: 2025

; .MODEL small
; .STACK 100h

; .DATA


; title       DB 'VEHICLE STICKER APPLICATION FORM', 0
; instructions DB 'Please fill out the form below:',0

; label1      DB 'Name of Applicant/Driver: ',0
; label2      DB 'Mobile Number:           ',0
; label3      DB 'Vehicle Make/Brand:      ',0

; input1      DB 30 DUP(0)
; input2      DB 15 DUP(0)
; input3      DB 20 DUP(0)

; promptLen   DW 30

; thankyou    DB 'Thank you for filling out the form!',0
; CR          EQU 13
; LF          EQU 10
; ESC_KEY     EQU 27

; .CODE

; start:
;     mov ax,@data
;     mov ds,ax

;     ; Clear screen and set color attribute (white on blue)
;     mov ah, 09h          ; Function: write char with attribute
;     mov al, ' '          ; space
;     mov bh, 0            ; page
;     mov bl, 1Fh          ; attribute (white on blue)
;     mov cx, 80*25        ; entire screen (80 cols * 25 rows)
;     int 10h

;     ; Print title centered
;     mov si, offset title     
;     call PrintCentered
;     call NewLine

;     ; Print instruction line
;     mov si, offset instructions
;     call PrintString
;     call NewLine
;     call NewLine

;     ; Draw form labels and input fields
;     mov si, offset label1
;     mov dx, 5             ; row 5 (in DL)
;     mov cx, 2             ; column 2 (in CL)
;     call PrintLabelInput

;     mov si, offset label2
;     mov dx, 7             ; row 7
;     mov cx, 2
;     call PrintLabelInput

;     mov si, offset label3
;     mov dx, 9             ; row 9
;     mov cx, 2
;     call PrintLabelInput

;     ; Get input for each field
;     mov si, offset input1
;     mov dx, 5
;     mov cx, 25             ; max input length
;     call InputField

;     mov si, offset input2
;     mov dx, 7
;     mov cx, 15
;     call InputField

;     mov si, offset input3
;     mov dx, 9
;     mov cx, 20
;     call InputField

;     ; Display thank you message
;     mov dx, 12             ; row 12
;     mov cx, 2              ; column 2
;     mov si, offset thankyou
;     call PrintStringAtPos

;     ; Wait for key before exit
;     mov ah, 0
;     int 16h

;     ; Exit program
;     mov ah, 4Ch
;     int 21h

; ; ----------- Subroutines -------------

; ; PrintCentered - prints string centered on row 2
; PrintCentered:
;     push ax bx cx dx si di
;     mov ah, 02h            ; set cursor position
;     mov bh, 0
;     mov dh, 2              ; row 2
;     mov dl, 0              ; column 0 (temporary)
;     int 10h

;     ; calculate string length
;     mov cx, 0
;     mov di, si
; pc_loop:
;     mov al, [di]
;     cmp al, 0
;     je pc_done
;     inc di
;     inc cx
;     jmp pc_loop
; pc_done:

;     mov ax, 40             ; screen width (80 columns / 2 for BIOS cursor)
;     sub ax, cx
;     shr ax, 1              ; (40 - length)/2 for center

;     ; set cursor position (row 2, col ax)
;     mov ah, 02h
;     mov bh, 0
;     mov dh, 2
;     mov dl, al
;     int 10h

;     call PrintString

;     pop di si dx cx bx ax
;     ret

; ; PrintString - prints string pointed by SI
; PrintString:
;     push ax bx cx dx
; print_loop:
;     mov al, [si]
;     cmp al, 0
;     je print_done
;     mov ah, 0Eh           ; teletype output BIOS
;     int 10h
;     inc si
;     jmp print_loop
; print_done:
;     pop dx cx bx ax
;     ret

; ; NewLine - move cursor to next line, column 0
; NewLine:
;     push ax bx cx dx
;     mov ah, 03h           ; get cursor pos
;     mov bh, 0
;     int 10h
;     inc dh                ; row + 1
;     mov ah, 02h           ; set cursor pos
;     mov bh, 0
;     mov dl, 0             ; col 0
;     int 10h
;     pop dx cx bx ax
;     ret

; ; PrintLabelInput - prints label and draws underscore input field
; ; Inputs: SI = label string, DX = row (in DL), CX = column (in CL)
; PrintLabelInput:
;     push ax bx cx dx si di

;     mov ah, 02h            ; set cursor pos
;     mov bh, 0
;     mov dh, dl             ; DH = row
;     mov dl, cl             ; DL = column
;     int 10h

;     ; print label text
;     call PrintString

;     ; move cursor after label
;     mov ah, 03h
;     mov bh, 0
;     int 10h

;     ; draw underscore input box (20 chars)
;     mov cx, 20
;     mov al, '_'
; print_underscores:
;     mov ah, 0Eh
;     int 10h
;     loop print_underscores

;     pop di si dx cx bx ax
;     ret

; ; InputField - gets user input at given position
; ; Inputs:
; ; SI = buffer to store input
; ; DX = row (cursor y) in DL
; ; CX = max length
; InputField:
;     push ax bx cx dx si di
;     mov di, si           ; buffer pointer

;     mov ah, 02h          ; set cursor pos
;     mov bh, 0
;     mov dh, dl           ; row
;     mov dl, 25           ; col after label
;     int 10h

;     mov bx, 0            ; input length counter

; read_loop:
;     mov ah, 0
;     int 16h              ; wait for keypress
;     cmp al, CR
;     je done_input
;     cmp al, ESC_KEY
;     je done_input

;     ; simple input: show character
;     mov ah, 0Eh
;     int 10h

;     ; store char
;     mov [di], al
;     inc di
;     inc bx
;     cmp bx, cx
;     jb read_loop

; done_input:
;     mov byte ptr [di], 0 ; null terminate

;     pop di si dx cx bx ax
;     ret

; ; PrintStringAtPos
; ; Inputs: DX = row (DL), CX = col (CL), SI = string pointer
; PrintStringAtPos:
;     push ax bx cx dx si di
;     mov ah, 02h
;     mov bh, 0
;     mov dh, dl
;     mov dl, cl
;     int 10h
;     call PrintString
;     pop di si dx cx bx ax
;     ret

; END start
