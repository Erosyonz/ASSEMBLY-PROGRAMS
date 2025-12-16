putc MACRO char
    mov ah, 02h
    mov dl, char
    int 21h
ENDM
renderc MACRO char, page, color, write
    mov ah, 09h
    mov al, char
    mov bh, page
    mov bl, color
    mov cx, write
    int 10h
ENDM
setcursor MACRO row, col
    mov ah, 02h
    mov bh, 00h
    mov dh, row
    mov dl, col
    int 10h
ENDM
colorz MACRO color, write
    mov ah, 09h
    mov bl, color
    mov cx, write
    int 10h
ENDM
.model small
.data
    FB db "FISHBOOK ACCOUNT REGISTRATION",'$'
    review db "Please review account registration details below:",'$'
    txt_17_R20_C7 db "SUBMIT",'$'
    txt_18_R20_C13 db "  ",'$'
    txt_19_R20_C15 db "CANCEL",'$'
    txt_20_R20_C21 db "  ",'$'
    txt_21_R20_C23 db "EDIT",'$'
 
    txt_0_R5_C2 db "__________________________________________",'$'
    txt_1_R6_C2 db "|Full Name:   ",'$'
    txt_2_R6_C18 db "|    ",'$'
    txt_3_R6_C36 db "       |",'$'
    txt_4_R7_C2 db "|Birthday:",'$'
    txt_5_R7_C18 db "|",'$'
    txt_6_R7_C36 db "       |",'$'
    txt_7_R8_C2 db "|Gender:",'$'
    txt_8_R8_C18 db "|",'$'
    txt_9_R8_C36 db "       |",'$'
    txt_10_R9_C2 db "|Email Address:",'$'
    txt_11_R9_C18 db "|",'$'
    txt_12_R9_C36 db "       |",'$'
    txt_13_R10_C2 db "|Password:",'$'
    txt_14_R10_C18 db "|",'$'
    txt_15_R10_C36 db "       |",'$'
    txt_16_R11_C2 db "__________________________________________",'$'
    newlineStr  DB 13,10,'$'
 
    promptName  DB 13,10,'Enter Full Name: $'
    promptBD    DB 13,10,'Enter Birthday: $'
    promptGender  DB 13,10,'Enter Gender: $'
    promptEmail  DB 13,10,'Enter Email Address: $'
    promptPassword  DB 13,10,'Enter Password: $'
 
    Names DB 31, 0, 30 DUP(0)
    BD DB 31, 0, 30 DUP(0)
    Gender DB 31, 0, 30 DUP(0)
    Email DB 31, 0, 30 DUP(0)
    Password DB 31, 0, 30 DUP(0)
 
    PrintInput MACRO buffer, row, col, attr
    local .print_loop, .done
 
    mov ah, 02h
    mov bh, 0
    mov dh, row
    mov dl, col
    int 10h
 
    mov si, offset buffer
    mov cl, [si+1]   ; actual input length
    xor ch, ch
    add si, 2        ; skip metadata
 
.print_loop:
    cmp cx, 0
    je .done
    mov al, [si]
    mov ah, 0Eh
    mov bh, 0
    mov bl, attr
    int 10h
    inc si
    dec cx
    jmp .print_loop
.done:
ENDM
 
 
 
 
 
 
RESET MACRO
    mov ah,09h
    mov bl,0fh
    mov cx,1
    int 10h
endm    
RED MACRO
    mov ah,09h
    mov bl,0Fh
    mov cx,1
    int 10h
 
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,04H
    mov cx,78
    int 10h
 
    mov ah,02h
    mov dl,219d
    mov cx,78
    draw_line1:
        int 21h
        loop draw_line1
 
    mov ah,09h
    mov bl,0Fh
    mov cx,1
    int 10h
 
    mov ah,02h
    mov dl,219d
    int 21h
ENDM    
SPACE MACRO
    mov ah, 2
    mov dl, ' '
    int 21h
ENDM  
GetInput MACRO address
    lea dx, address
    mov ah,0Ah
    int 21h
 
 
ENDM
 
 
InputStr MACRO str
    mov ah, 9
    mov dx, offset str
    int 21h
ENDM
 
NEWLINE MACRO
    mov ah, 9
    mov dx, offset newlineStr
    int 21h
ENDM
 
.code
 
.stack 100h
start :
    mov ax, @data
    mov ds, ax
 
    ; Set to video mode
    mov ah, 00h
    mov al, 03h ; 80x25 color text mode
    int 10h
    InputStr FB
    NEWLINE
 
    InputStr promptName
    GetInput Names
 
    InputStr promptBD
    GetInput BD
 
    InputStr promptGender
    GetInput Gender
 
    InputStr promptEmail
    GetInput Email
 
    InputStr promptPassword
    GetInput Password
 
    setcursor 9, 2
    InputStr review
   
 
 
    setcursor 10, 2
    colorz 31, 42
    mov ah, 09h
    mov dx, offset txt_0_R5_C2
    int 21h
 
    setcursor 11, 2
    colorz 31, 14
    mov ah, 09h
    mov dx, offset txt_1_R6_C2
    int 21h
 
   
    setcursor 11, 16
    renderc 32, 0, 1fh, 2
 
    setcursor 11, 18
    colorz 31, 5
    mov ah, 09h\
    mov dx, offset txt_2_R6_C18
    int 21h
 
   
    setcursor 11, 23
    renderc 32, 0, 1fh, 13
 
    setcursor 11, 19
    renderc 20h, 0, 1Fh, 17
    PrintInput Names, 11, 20, 1Fh
 
    setcursor 11, 36
    colorz 31, 8
    mov ah, 09h
    mov dx, offset txt_3_R6_C36
    int 21h
 
    setcursor 12, 2
    colorz 31, 10
    mov ah, 09h
    mov dx, offset txt_4_R7_C2
    int 21h
 
    setcursor 12, 12
    renderc 32, 0, 1fh, 6
 
    setcursor 12, 18
    colorz 31, 1
    mov ah, 09h
    mov dx, offset txt_5_R7_C18
    int 21h
 
    setcursor 12, 19
    renderc 32, 0, 1fh, 25
    PrintInput BD, 12, 20, 1Fh
   
    setcursor 12, 36
    colorz 31, 3
    mov ah, 09h
    mov dx, offset txt_6_R7_C36
    int 21h
 
    setcursor 13, 2
    colorz 31, 8
    mov ah, 09h
    mov dx, offset txt_7_R8_C2
    int 21h
 
    setcursor 13, 10
    renderc 32, 0, 1fh, 8
 
    setcursor 13, 18
    colorz 31, 1
    mov ah, 09h
    mov dx, offset txt_8_R8_C18
    int 21h
 
    setcursor 13, 19
    renderc 32, 0, 1fh, 17
    PrintInput Gender, 13, 20, 1Fh
 
    setcursor 13, 36
    colorz 31, 8
    mov ah, 09h
    mov dx, offset txt_9_R8_C36
    int 21h
 
    setcursor 14, 2
    colorz 31, 15
    mov ah, 09h
    mov dx, offset txt_10_R9_C2
    int 21h
 
    setcursor 14, 17
    renderc 32, 0, 1fh, 1
 
    setcursor 14, 18
    colorz 31, 1
    mov ah, 09h
    mov dx, offset txt_11_R9_C18
    int 21h
 
    setcursor 14, 19
    renderc 32, 0, 1fh, 17
    PrintInput Email, 14, 20, 1Fh
 
    setcursor 14, 36
    colorz 31, 8
    mov ah, 09h
    mov dx, offset txt_12_R9_C36
    int 21h
 
    setcursor 15, 2
    colorz 31, 10
    mov ah, 09h
    mov dx, offset txt_13_R10_C2
    int 21h
 
    setcursor 15, 12
    renderc 32, 0, 1fh, 6
 
    setcursor 15, 18
    colorz 31, 1
    mov ah, 09h
    mov dx, offset txt_14_R10_C18
    int 21h
 
    setcursor 15, 19
    renderc 32, 0, 1fh, 17
    PrintInput Password, 15, 20, 1Fh
 
    setcursor 15, 36
    colorz 31, 8
    mov ah, 09h
    mov dx, offset txt_15_R10_C36
    int 21h
 
    setcursor 16, 2
    colorz 31, 42
    mov ah, 09h
    mov dx, offset txt_16_R11_C2
    int 21h
 
   
    setcursor 18, 7
    colorz 79, 6
    mov ah, 09h
    mov dx, offset txt_17_R20_C7
    int 21h
 
    setcursor 18, 13
    colorz 0, 2
    mov ah, 09h
    mov dx, offset txt_18_R20_C13
    int 21h
 
    setcursor 18, 15
    colorz 79, 6
    mov ah, 09h
    mov dx, offset txt_19_R20_C15
    int 21h
 
    setcursor 18, 21
    colorz 0, 2
    mov ah, 09h
    mov dx, offset txt_20_R20_C21
    int 21h
 
    setcursor 18, 23
    colorz 79, 4
    mov ah, 09h
    mov dx, offset txt_21_R20_C23
    int 21h
 
 
    mov ah, 4Ch      ; DOS exit function
    mov al, 0        ; Return code 0
    int 21h          ; Call DOS interrupt
end start ; end program