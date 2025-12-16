
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
	txt_0_R23_C31 db "Thank you",'$'
.code

.stack 100h
start :
    mov ax, @data
    mov ds, ax

    ; Set to video mode 
    mov ah, 00h
    mov al, 03h ; 80x25 color text mode
    int 10h


	setcursor 23, 0
	renderc 20h, 0, 0eh, 31

	setcursor 23, 31
	colorz 0eh, 9
	mov ah, 09h
	mov dx, offset txt_0_R23_C31
	int 21h

	setcursor 23, 40
	renderc 20h, 0, 0eh, 40

    mov ah, 4Ch      ; DOS exit function
    mov al, 0        ; Return code 0
    int 21h          ; Call DOS interrupt
end start ; end program
