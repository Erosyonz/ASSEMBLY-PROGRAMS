; Filename: DELAPENA.ASM
; Programmer: DELA PENA, ALLEAH I.
; Date: September 18, 2025
; Description: Create an Assembly Language program based on the sample output below. Before the from displays, ask the user to input all the needed data as shown on the summary form. Afterwords, display the form with all the data entered by the user.

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
    mov cl, [buf+1]       ; get the number of characters typed
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

    ;newline
    newline db 13,10,'$'

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


; set prompts + buffers

    setcursor 0, 1
	mov ah, 09h
	mov dx, offset txt_0_R0_C0
	int 21h

        mov ah, 9
        lea dx, newline
        int 21h

    ;first buf
    setcursor 2, 1
    mov ah, 9
    lea dx, prompt1
    int 21h

        setcursor 2, 18
        ;buffer
        mov ah, 0ah
        lea dx, buf1
        int 21h

        mov ah, 9
        lea dx, newline
        int 21h

    ;second buf
    setcursor 3, 1
    mov ah, 9
    lea dx, prompt2
    int 21h

        setcursor 3, 17
        ;buffer
        mov ah, 0ah
        lea dx, buf2
        int 21h

        mov ah, 9
        lea dx, newline
        int 21h

    ;third buf
    setcursor 4, 1
    mov ah, 9
    lea dx, prompt3
    int 21h
    
        setcursor 4, 15
        ;buffer
        mov ah, 0ah
        lea dx, buf3
        int 21h

        mov ah, 9
        lea dx, newline
        int 21h
        
    ;fourth buf
    setcursor 5, 1
    mov ah, 9
    lea dx, prompt4
    int 21h

        setcursor 5, 22
        ;buffer
        mov ah, 0ah
        lea dx, buf4
        int 21h

        mov ah, 9
        lea dx, newline
        int 21h
        
    ;fifth buf
    setcursor 6, 1
    mov ah, 9
    lea dx, prompt5
    int 21h

        setcursor 6, 17
        ;buffer
        mov ah, 0ah
        lea dx, buf5
        int 21h

        mov ah, 9
        lea dx, newline
        int 21h
        
	setcursor 8, 1
	mov ah, 09h
	mov dx, offset txt_6_R8_C0
	int 21h

	setcursor 9, 1
	colorz ' ', 1fh, 60
	mov ah, 09h
	mov dx, offset txt_7_R9_C0
	int 21h

	setcursor 10, 1
	colorz ' ', 1fh, 11
	mov ah, 09h
	lea dx, fullname
	int 21h

	setcursor 10, 12        ; col 11 -> 12
	renderc 20h, 0, 1fh, 6

	setcursor 10, 18        ; col 17 -> 18
	colorz ' ', 1fh, 2
	mov ah, 09h
	mov dx, offset txt_9_R10_C17
	int 21h

    ; set second column
        setcursor 10, 20        
        colorz ' ', 1fh, 40
        print_buffer_dos buf1


        setcursor 10, 60      
        colorz ' ', 1fh, 1
        mov ah, 09h
        mov dx, offset txt_10_R10_C59
        int 21h

        setcursor 11, 1
        colorz ' ', 1fh, 60
        mov ah, 09h
        mov dx, offset txt_11_R11_C0
        int 21h

	setcursor 12, 1
	colorz ' ', 1fh, 10
	mov ah, 09h
	lea dx, bday
	int 21h

	setcursor 12, 11        ; col 10 -> 11
	renderc 20h, 0, 1fh, 7

	setcursor 12, 18        ; col 17 -> 18
	colorz ' ', 1fh, 2
	mov ah, 09h
	mov dx, offset txt_13_R12_C17
	int 21h

    ;set second column
        setcursor 12, 20        ; col 18 -> 19
        colorz ' ', 1fh, 40
        print_buffer_dos buf2

        setcursor 12, 60        ; col 59 -> 60
        colorz ' ', 1fh, 1
        mov ah, 09h
        mov dx, offset txt_14_R12_C59
        int 21h

	setcursor 13, 1
	colorz ' ', 1fh, 60
	mov ah, 09h
	mov dx, offset txt_15_R13_C0
	int 21h

	setcursor 14, 1
	colorz ' ', 1fh, 8
	mov ah, 09h
	lea dx, gender
	int 21h

	setcursor 14, 9         ; col 8 -> 9
	renderc 20h, 0, 1fh, 9

	setcursor 14, 18        ; col 17 -> 18
	colorz ' ', 1fh, 2
	mov ah, 09h
	mov dx, offset txt_17_R14_C17
	int 21h

    ;set second column
        setcursor 14, 20      ; col 18 -> 19
        colorz ' ', 1fh, 40
        print_buffer_dos buf3

        setcursor 14, 60        ; col 59 -> 60
        colorz ' ', 1fh, 1
        mov ah, 09h
        mov dx, offset txt_18_R14_C59
        int 21h

	setcursor 15, 1
	colorz ' ', 1fh, 60
	mov ah, 09h
	mov dx, offset txt_19_R15_C0
	int 21h

	setcursor 16, 1
	colorz ' ', 1fh, 15
	mov ah, 09h
	lea dx, email
	int 21h

	setcursor 16, 16        ; col 15 -> 16
	renderc 20h, 0, 1fh, 2

	setcursor 16, 18        ; col 17 -> 18
	colorz ' ', 1fh, 2
	mov ah, 09h
	mov dx, offset txt_21_R16_C17
	int 21h

    ;set second column
        setcursor 16, 20       ; col 18 -> 19
        colorz ' ', 1fh, 40
        print_buffer_dos buf4

        setcursor 16, 55        ; col 54 -> 55
        colorz ' ', 1fh, 6
        mov ah, 09h
        mov dx, offset txt_22_R16_C54
        int 21h

	setcursor 17, 1
	colorz ' ', 1fh, 60
	mov ah, 09h
	mov dx, offset txt_23_R17_C0
	int 21h

	setcursor 18, 1
	colorz ' ', 1fh, 10
	mov ah, 09h
	lea dx, pass
	int 21h

	setcursor 18, 11        ; col 10 -> 11
	renderc 20h, 0, 1fh, 7

	setcursor 18, 18        ; col 17 -> 18
	colorz ' ', 1fh, 2
	mov ah, 09h
	mov dx, offset txt_25_R18_C17
	int 21h

    ;set second column
        setcursor 18, 20        ; col 18 -> 19
        colorz ' ', 1fh, 40
        print_buffer_dos buf5

        setcursor 18, 60        ; col 59 -> 60
        colorz ' ', 1fh, 1
        mov ah, 09h
        mov dx, offset txt_26_R18_C59
        int 21h

	setcursor 19, 1
	colorz ' ', 1fh, 60
	mov ah, 09h
	mov dx, offset txt_27_R19_C0
	int 21h

	setcursor 21, 1
	colorz ' ', 4fh, 8
	mov ah, 09h
	mov dx, offset txt_28_R21_C0
	int 21h

	setcursor 21, 11        ; col 10 -> 11
	colorz ' ', 4fh, 8
	mov ah, 09h
	mov dx, offset txt_29_R21_C10
	int 21h

	setcursor 21, 21        ; col 20 -> 21
	colorz ' ', 4fh, 6
	mov ah, 09h
	mov dx, offset txt_30_R21_C20
	int 21h

    mov ah, 4Ch      ; DOS exit function
    mov al, 0        ; Return code 0
    int 21h          ; Call DOS interrupt
end start ; end program
