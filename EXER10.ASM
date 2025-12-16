; Display duck
; Filename: EXER10.ASM
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
	txt_0_R2_C4 db "     ",'$'
	txt_1_R3_C3 db "       ",'$'
	txt_2_R4_C2 db " ",'$'
	txt_3_R4_C3 db "  ",'$'
	txt_4_R4_C5 db " ",'$'
	txt_5_R4_C6 db "     ",'$'
	txt_6_R5_C0 db "   ",'$'
	txt_7_R5_C3 db "        ",'$'
	txt_8_R6_C1 db "   ",'$'
	txt_9_R6_C4 db "       ",'$'
	txt_10_R7_C4 db "      ",'$'
	txt_11_R7_C11 db "    ",'$'
	txt_12_R7_C16 db " ",'$'
	txt_13_R8_C3 db "      ",'$'
	txt_14_R8_C9 db "      ",'$'
	txt_15_R8_C15 db " ",'$'
	txt_16_R8_C16 db " ",'$'
	txt_17_R9_C2 db "       ",'$'
	txt_18_R9_C9 db " ",'$'
	txt_19_R9_C10 db "    ",'$'
	txt_20_R9_C14 db " ",'$'
	txt_21_R9_C15 db "  ",'$'
	txt_22_R10_C2 db "        ",'$'
	txt_23_R10_C10 db "    ",'$'
	txt_24_R10_C14 db "   ",'$'
	txt_25_R11_C3 db "             ",'$'
	txt_26_R12_C4 db "          ",'$'
	txt_27_R13_C5 db "        ",'$'
.code

.stack 100h
start :
    mov ax, @data
    mov ds, ax

    ; Set to video mode 
    mov ah, 00h
    mov al, 03h ; 80x25 color text mode
    int 10h


	setcursor 2, 4
	colorz 103, 5
	mov ah, 09h
	mov dx, offset txt_0_R2_C4
	int 21h

	setcursor 3, 3
	colorz 103, 7
	mov ah, 09h
	mov dx, offset txt_1_R3_C3
	int 21h

	setcursor 4, 2
	colorz 87, 1
	mov ah, 09h
	mov dx, offset txt_2_R4_C2
	int 21h

	setcursor 4, 3
	colorz 103, 2
	mov ah, 09h
	mov dx, offset txt_3_R4_C3
	int 21h

	setcursor 4, 5
	colorz 247, 1
	mov ah, 09h
	mov dx, offset txt_4_R4_C5
	int 21h

	setcursor 4, 6
	colorz 103, 5
	mov ah, 09h
	mov dx, offset txt_5_R4_C6
	int 21h

	setcursor 5, 0
	colorz 87, 3
	mov ah, 09h
	mov dx, offset txt_6_R5_C0
	int 21h

	setcursor 5, 3
	colorz 103, 8
	mov ah, 09h
	mov dx, offset txt_7_R5_C3
	int 21h

	setcursor 6, 1
	colorz 87, 3
	mov ah, 09h
	mov dx, offset txt_8_R6_C1
	int 21h

	setcursor 6, 4
	colorz 103, 7
	mov ah, 09h
	mov dx, offset txt_9_R6_C4
	int 21h

	setcursor 7, 4
	colorz 103, 6
	mov ah, 09h
	mov dx, offset txt_10_R7_C4
	int 21h

	setcursor 7, 11
	colorz 103, 4
	mov ah, 09h
	mov dx, offset txt_11_R7_C11
	int 21h

	setcursor 7, 16
	colorz 103, 1
	mov ah, 09h
	mov dx, offset txt_12_R7_C16
	int 21h

	setcursor 8, 3
	colorz 103, 6
	mov ah, 09h
	mov dx, offset txt_13_R8_C3
	int 21h

	setcursor 8, 9
	colorz 96, 6
	mov ah, 09h
	mov dx, offset txt_14_R8_C9
	int 21h

	setcursor 8, 15
	colorz 0, 1
	mov ah, 09h
	mov dx, offset txt_15_R8_C15
	int 21h

	setcursor 8, 16
	colorz 96, 1
	mov ah, 09h
	mov dx, offset txt_16_R8_C16
	int 21h

	setcursor 9, 2
	colorz 96, 7
	mov ah, 09h
	mov dx, offset txt_17_R9_C2
	int 21h

	setcursor 9, 9
	colorz 0, 1
	mov ah, 09h
	mov dx, offset txt_18_R9_C9
	int 21h

	setcursor 9, 10
	colorz 96, 4
	mov ah, 09h
	mov dx, offset txt_19_R9_C10
	int 21h

	setcursor 9, 14
	colorz 0, 1
	mov ah, 09h
	mov dx, offset txt_20_R9_C14
	int 21h

	setcursor 9, 15
	colorz 96, 2
	mov ah, 09h
	mov dx, offset txt_21_R9_C15
	int 21h

	setcursor 10, 2
	colorz 96, 8
	mov ah, 09h
	mov dx, offset txt_22_R10_C2
	int 21h

	setcursor 10, 10
	colorz 0, 4
	mov ah, 09h
	mov dx, offset txt_23_R10_C10
	int 21h

	setcursor 10, 14
	colorz 96, 3
	mov ah, 09h
	mov dx, offset txt_24_R10_C14
	int 21h

	setcursor 11, 3
	colorz 96, 13
	mov ah, 09h
	mov dx, offset txt_25_R11_C3
	int 21h

	setcursor 12, 4
	colorz 96, 10
	mov ah, 09h
	mov dx, offset txt_26_R12_C4
	int 21h

	setcursor 13, 5
	colorz 96, 8
	mov ah, 09h
	mov dx, offset txt_27_R13_C5
	int 21h

    mov ah, 4Ch      ; DOS exit function
    mov al, 0        ; Return code 0
    int 21h          ; Call DOS interrupt
end start ; end program
