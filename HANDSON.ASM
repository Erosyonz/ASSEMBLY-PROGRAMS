; Filename: EXAM2.ASM
; Programmer: DELA PENA, ALLEAH I.
; Date: September 25, 2025
; Description: Create an Assembly Language program based on the sample output below.
; Ask user to input registration details, then display summary with chosen background color. 

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

colorz MACRO char, color, write
    mov ah, 09h 
    mov al, char
    mov bl, color
    mov cx, write
    int 10h
ENDM

print_buffer_dos MACRO buf
    LOCAL print_loop
    LOCAL end_print_loop
    mov cl, [buf+1]       ; get number of characters typed
    lea si, buf+2         ; point to first character typed
print_loop:
    cmp cl, 0
    je end_print_loop
    mov dl, [si]          ; get current character
    mov ah, 2             ; DOS function: print character in DL
    int 21h
    inc si
    dec cl
    jmp print_loop
end_print_loop:
ENDM

.model small
.data

    HOW db "How do you like to display the summary table?",'$'
    blue db "1 - blue background",'$'
    red db "2 - red background",'$'
    promptBG db "Enter your choice: ",'$'
    newline db 13,10,'$'

    colorChoice db ?   ; stores chosen color attribute

	txt_0_R0_C0 db "FISHBOOK ACCOUNT REGISTRATION",'$'
	prompt1 db "Enter Full Name:",'$'
	prompt2 db "Enter Birthday:",'$'
	prompt3 db "Enter Gender:",'$'
	prompt4 db "Enter Email Address:",'$'
	prompt5 db "Enter Password:",'$'
	txt_6_R8_C0 db "Please review account registration details below:",'$'
	txt_7_R9_C0 db "------------------------------------------------------------",'$'
	fullname db "|Full Name:",'$'
	txt_9_R10_C17 db "|",'$'
	txt_10_R10_C59 db "|",'$'
	txt_11_R11_C0 db "|----------------|-----------------------------------------|",'$'
	bday db "|Birthday:",'$'
	txt_13_R12_C17 db "|",'$'
	txt_14_R12_C59 db "|",'$'
	txt_15_R13_C0 db "|----------------|-----------------------------------------|",'$'
	gender db "|Gender:",'$'
	txt_17_R14_C17 db "|",'$'
	txt_18_R14_C59 db "|",'$'
	txt_19_R15_C0 db "|----------------|-----------------------------------------|",'$'
	email db "|Email Address:",'$'
	txt_21_R16_C17 db "|",'$'
	txt_22_R16_C54 db "     |",'$'
	txt_23_R17_C0 db "|----------------|-----------------------------------------|",'$'
	pass db "|Password:",'$'
	txt_25_R18_C17 db "|",'$'
	txt_26_R18_C59 db "|",'$'
	txt_27_R19_C0 db "------------------------------------------------------------",'$'
	txt_28_R21_C0 db " SUBMIT ",'$'
	txt_29_R21_C10 db " CANCEL ",'$'
	txt_30_R21_C20 db " EDIT ",'$'
    invalid_input_msg db 13,10,"Invalid input!",13,10,'$'

    ;buffers
    buf1 db 40, ?, 40 dup(?) ;name
    buf2 db 30, ?, 30 dup(?) ;bday
    buf3 db 10, ?, 10 dup(?) ;gender
    buf4 db 50, ?, 50 dup(?) ;email
    buf5 db 20, ?, 20 dup(?) ;password

.code
.stack 100h
start :
    mov ax, @data
    mov ds, ax

    ; Set to video mode 
    mov ah, 00h
    mov al, 03h ; 80x25 color text mode
    int 10h

    ; --- REGISTRATION FORM INPUTS ---

    setcursor 0, 1
	mov ah, 09h
	mov dx, offset txt_0_R0_C0
	int 21h

    mov ah, 9
    lea dx, newline
    int 21h
    ;first buf
    setcursor 1, 1
    mov ah, 9
    lea dx, prompt1
    int 21h

    setcursor 1, 18
    mov ah, 0ah
    lea dx, buf1
    int 21h

    mov ah, 9
    lea dx, newline
    int 21h

    ;second buf
    setcursor 2, 1
    mov ah, 9
    lea dx, prompt2
    int 21h

    setcursor 2, 17
    mov ah, 0ah
    lea dx, buf2
    int 21h

    mov ah, 9
    lea dx, newline
    int 21h

    ;third buf
    setcursor 3, 1
    mov ah, 9
    lea dx, prompt3
    int 21h

    setcursor 3, 15
    mov ah, 0ah
    lea dx, buf3
    int 21h

    mov ah, 9
    lea dx, newline
    int 21h

    ;fourth buf
    setcursor 4, 1
    mov ah, 9
    lea dx, prompt4
    int 21h

    setcursor 4, 22
    mov ah, 0ah
    lea dx, buf4
    int 21h

    mov ah, 9
    lea dx, newline
    int 21h

    ;fifth buf
    setcursor 5, 1
    mov ah, 9
    lea dx, prompt5
    int 21h

    setcursor 5, 17
    mov ah, 0ah
    lea dx, buf5
    int 21h

    mov ah, 9
    lea dx, newline
    int 21h
    mov ah, 9
    lea dx, newline
    int 21h

    ; --- PROMPT FOR BACKGROUND CHOICE (AFTER PASSWORD) ---
    setcursor 7, 1 
    mov ah, 09h
    mov dx, offset HOW
    int 21h
    mov ah, 09h
    mov dx, offset newline
    int 21h

    setcursor 8, 1 
    mov ah, 09h
    mov dx, offset blue
    int 21h
    mov ah, 09h
    mov dx, offset newline
    int 21h

    setcursor 9, 1 
    mov ah, 09h
    mov dx, offset red
    int 21h
    mov ah, 09h
    mov dx, offset newline
    int 21h

    setcursor 10, 1 
    mov ah, 09h
    mov dx, offset promptBG
    int 21h

   

    mov ah, 01h       ; read single char
    int 21h
    sub al, '0'       ; convert ASCII → number
    cmp al, 1
    je set_blue
    cmp al, 2
    je set_red
    
    setcursor 12, 1 
    mov ah, 09h
    mov dx, offset invalid_input_msg
    int 21h
    jmp exit_program

    ; --- INVALID INPUT ---
     ; continue program after message



set_blue:
    mov colorChoice, 1Fh
    jmp continue_bg
set_red:
    mov colorChoice, 4Fh
continue_bg:

    
   


; --- DISPLAY SUMMARY WITH CHOSEN BACKGROUND ---
    setcursor 11, 1
    mov ah, 09h
    mov dx, offset txt_6_R8_C0
    int 21h

    setcursor 12, 1
    mov bl, colorChoice
    colorz ' ', bl, 60
    mov ah, 09h
    mov dx, offset txt_7_R9_C0
    int 21h

    setcursor 13, 1
    mov bl, colorChoice
    colorz ' ', bl, 11
    mov ah, 09h
    lea dx, fullname
    int 21h

    setcursor 13, 12
    mov bl, colorChoice
    renderc 20h, 0, bl, 6

    setcursor 13, 18
    mov bl, colorChoice
    colorz ' ', bl, 2
    mov ah, 09h
    mov dx, offset txt_9_R10_C17
    int 21h

    ; second column
    setcursor 13, 20        
    mov bl, colorChoice
    colorz ' ', bl, 40
    print_buffer_dos buf1

    setcursor 13, 60      
    mov bl, colorChoice
    colorz ' ', bl, 1
    mov ah, 09h
    mov dx, offset txt_10_R10_C59
    int 21h

    setcursor 14, 1
    mov bl, colorChoice
    colorz ' ', bl, 60
    mov ah, 09h
    mov dx, offset txt_11_R11_C0
    int 21h

    setcursor 15, 1
    mov bl, colorChoice
    colorz ' ', bl, 10
    mov ah, 09h
    lea dx, bday
    int 21h

    setcursor 15, 11
    mov bl, colorChoice
    renderc 20h, 0, bl, 7

    setcursor 15, 18
    mov bl, colorChoice
    colorz ' ', bl, 2
    mov ah, 09h
    mov dx, offset txt_13_R12_C17
    int 21h

    ; second column
    setcursor 15, 20
    mov bl, colorChoice
    colorz ' ', bl, 40
    print_buffer_dos buf2

    setcursor 15, 60
    mov bl, colorChoice
    colorz ' ', bl, 1
    mov ah, 09h
    mov dx, offset txt_14_R12_C59
    int 21h

    setcursor 16, 1
    mov bl, colorChoice
    colorz ' ', bl, 60
    mov ah, 09h
    mov dx, offset txt_15_R13_C0
    int 21h

    setcursor 17, 1
    mov bl, colorChoice
    colorz ' ', bl, 8
    mov ah, 09h
    lea dx, gender
    int 21h

    setcursor 17, 9
    mov bl, colorChoice
    renderc 20h, 0, bl, 9

    setcursor 17, 18
    mov bl, colorChoice
    colorz ' ', bl, 2
    mov ah, 09h
    mov dx, offset txt_17_R14_C17
    int 21h

    ; second column
    setcursor 17, 20
    mov bl, colorChoice
    colorz ' ', bl, 40
    print_buffer_dos buf3

    setcursor 17, 60
    mov bl, colorChoice
    colorz ' ', bl, 1
    mov ah, 09h
    mov dx, offset txt_18_R14_C59
    int 21h

    setcursor 18, 1
    mov bl, colorChoice
    colorz ' ', bl, 60
    mov ah, 09h
    mov dx, offset txt_19_R15_C0
    int 21h

    setcursor 19, 1
    mov bl, colorChoice
    colorz ' ', bl, 15
    mov ah, 09h
    lea dx, email
    int 21h

    setcursor 19, 16
    mov bl, colorChoice
    renderc 20h, 0, bl, 2

    setcursor 19, 18
    mov bl, colorChoice
    colorz ' ', bl, 2
    mov ah, 09h
    mov dx, offset txt_21_R16_C17
    int 21h

    ; second column
    setcursor 19, 20
    mov bl, colorChoice
    colorz ' ', bl, 40
    print_buffer_dos buf4

    setcursor 19, 55
    mov bl, colorChoice
    colorz ' ', bl, 6
    mov ah, 09h
    mov dx, offset txt_22_R16_C54
    int 21h

    setcursor 20, 1
    mov bl, colorChoice
    colorz ' ', bl, 60
    mov ah, 09h
    mov dx, offset txt_23_R17_C0
    int 21h

    setcursor 21, 1
    mov bl, colorChoice
    colorz ' ', bl, 10
    mov ah, 09h
    lea dx, pass
    int 21h

    setcursor 21, 11
    mov bl, colorChoice
    renderc 20h, 0, bl, 7

    setcursor 21, 18
    mov bl, colorChoice
    colorz ' ', bl, 2
    mov ah, 09h
    mov dx, offset txt_25_R18_C17
    int 21h

    ; second column
    setcursor 21, 20
    mov bl, colorChoice
    colorz ' ', bl, 40
    print_buffer_dos buf5

    setcursor 21, 60
    mov bl, colorChoice
    colorz ' ', bl, 1
    mov ah, 09h
    mov dx, offset txt_26_R18_C59
    int 21h

    setcursor 22, 1
    mov bl, colorChoice
    colorz ' ', bl, 60
    mov ah, 09h
    mov dx, offset txt_27_R19_C0
    int 21h


    ; buttons at row 25+
    ; --- BUTTONS ---
    

    setcursor 24, 1          ; instead of 25,1
    colorz ' ', 4fh, 8
    mov ah, 09h
    mov dx, offset txt_28_R21_C0   ; "Submit"
    int 21h

    setcursor 24, 11
    colorz ' ', 4fh, 8
    mov ah, 09h
    mov dx, offset txt_29_R21_C10  ; "Edit"
    int 21h

    setcursor 24, 21
    colorz ' ', 4fh, 6
    mov ah, 09h
    mov dx, offset txt_30_R21_C20  ; "Exit"
    int 21h
exit_program:
    mov ah, 4Ch       ; DOS terminate program
    int 21h

end start
