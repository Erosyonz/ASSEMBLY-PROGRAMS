; Display duck
; Filename: EXER11.ASM
; Programmer: Alleah Dela Pena
; August 31, 2025

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
	txt_0_R2_C6 db "             ",'$'
	txt_1_R3_C6 db "             ",'$'
	txt_2_R4_C6 db "  ",'$'
	txt_3_R4_C8 db " ",'$'
	txt_4_R4_C9 db "       ",'$'
	txt_5_R4_C16 db " ",'$'
	txt_6_R4_C17 db "  ",'$'
	txt_7_R5_C6 db "  ",'$'
	txt_8_R5_C8 db " ",'$'
	txt_9_R5_C9 db "       ",'$'
	txt_10_R5_C16 db " ",'$'
	txt_11_R5_C17 db "  ",'$'
	txt_12_R6_C6 db "  ",'$'
	txt_13_R6_C8 db " ",'$'
	txt_14_R6_C9 db "       ",'$'
	txt_15_R6_C16 db " ",'$'
	txt_16_R6_C17 db "  ",'$'
	txt_17_R7_C6 db "             ",'$'
	txt_18_R8_C6 db "             ",'$'
	txt_19_R9_C6 db "   ",'$'
	txt_20_R9_C9 db "       ",'$'
	txt_21_R9_C16 db "   ",'$'
	txt_22_R10_C6 db "             ",'$'
	txt_23_R11_C6 db "             ",'$'
.code

.stack 100h
start :
    mov ax, @data
    mov ds, ax

    ; Set to video mode 
    mov ah, 00h
    mov al, 03h ; 80x25 color text mode
    int 10h


	setcursor 2, 6
	colorz 96, 13
	mov ah, 09h
	mov dx, offset txt_0_R2_C6
	int 21h

	setcursor 3, 6
	colorz 96, 13
	mov ah, 09h
	mov dx, offset txt_1_R3_C6
	int 21h

	setcursor 4, 6
	colorz 96, 2
	mov ah, 09h
	mov dx, offset txt_2_R4_C6
	int 21h

	setcursor 4, 8
	colorz 0, 1
	mov ah, 09h
	mov dx, offset txt_3_R4_C8
	int 21h

	setcursor 4, 9
	colorz 96, 7
	mov ah, 09h
	mov dx, offset txt_4_R4_C9
	int 21h

	setcursor 4, 16
	colorz 0, 1
	mov ah, 09h
	mov dx, offset txt_5_R4_C16
	int 21h

	setcursor 4, 17
	colorz 96, 2
	mov ah, 09h
	mov dx, offset txt_6_R4_C17
	int 21h

	setcursor 5, 6
	colorz 96, 2
	mov ah, 09h
	mov dx, offset txt_7_R5_C6
	int 21h

	setcursor 5, 8
	colorz 0, 1
	mov ah, 09h
	mov dx, offset txt_8_R5_C8
	int 21h

	setcursor 5, 9
	colorz 96, 7
	mov ah, 09h
	mov dx, offset txt_9_R5_C9
	int 21h

	setcursor 5, 16
	colorz 0, 1
	mov ah, 09h
	mov dx, offset txt_10_R5_C16
	int 21h

	setcursor 5, 17
	colorz 96, 2
	mov ah, 09h
	mov dx, offset txt_11_R5_C17
	int 21h

	setcursor 6, 6
	colorz 96, 2
	mov ah, 09h
	mov dx, offset txt_12_R6_C6
	int 21h

	setcursor 6, 8
	colorz 0, 1
	mov ah, 09h
	mov dx, offset txt_13_R6_C8
	int 21h

	setcursor 6, 9
	colorz 96, 7
	mov ah, 09h
	mov dx, offset txt_14_R6_C9
	int 21h

	setcursor 6, 16
	colorz 0, 1
	mov ah, 09h
	mov dx, offset txt_15_R6_C16
	int 21h

	setcursor 6, 17
	colorz 96, 2
	mov ah, 09h
	mov dx, offset txt_16_R6_C17
	int 21h

	setcursor 7, 6
	colorz 96, 13
	mov ah, 09h
	mov dx, offset txt_17_R7_C6
	int 21h

	setcursor 8, 6
	colorz 96, 13
	mov ah, 09h
	mov dx, offset txt_18_R8_C6
	int 21h

	setcursor 9, 6
	colorz 96, 3
	mov ah, 09h
	mov dx, offset txt_19_R9_C6
	int 21h

	setcursor 9, 9
	colorz 64, 7
	mov ah, 09h
	mov dx, offset txt_20_R9_C9
	int 21h

	setcursor 9, 16
	colorz 96, 3
	mov ah, 09h
	mov dx, offset txt_21_R9_C16
	int 21h

	setcursor 10, 6
	colorz 96, 13
	mov ah, 09h
	mov dx, offset txt_22_R10_C6
	int 21h

	setcursor 11, 6
	colorz 96, 13
	mov ah, 09h
	mov dx, offset txt_23_R11_C6
	int 21h

    mov ah, 4Ch      ; DOS exit function
    mov al, 0        ; Return code 0
    int 21h          ; Call DOS interrupt
end start ; end program
