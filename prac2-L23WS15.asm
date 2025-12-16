; Filename: EXER26.ASM
; Programmer Name: Alleah Dela Pena
; Date: September 12, 2025
; Description: an Assembly Language program based on the sample output. Before the form displays, ask the user to input all the needed data as shown on the summary form. Afterwards, display the form with all the data entered by the user.

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

.MODEL SMALL
.STACK 100H

.DATA
    
	txt_0_R1_C22 db "Cebu Institute of Technology - University",'$'
	txt_1_R3_C26 db "VEHICLE STICKER APPLICATION FORM",'$'
	txt_2_R5_C26 db "  Please fill out form below.",'$'
	txt_3_R7_C4 db "Personnel Type:                      Vehicle Sticker Type:",'$'
	txt_4_R9_C4 db "Name of Applicant:                   ID Number:",'$'
	txt_5_R11_C4 db "Mobile Number:                       Address:",'$'
	txt_6_R13_C4 db "Vehicle Brand:                       Plate Number:",'$'
	txt_7_R15_C4 db "Vehicle Color:                       Vehicle Type:",'$'
	txt_8_R18_C36 db "SUBMIT",'$'
	txt_9_R21_C20 db "Copyright 2024 ALLEAH DELA PENA",'$'
	txt_10_R23_C31 db "Thank you!",'$'
	arrow       db "V",'$'

    CIT         DB 'Cebu Institute of Technology - University',13,10,'$'
    TITLESR     DB 'STUDENT ENROLLMENT FORM',13,10,'$'
    promptPer   DB 13,10,'Personnel type: $'
    promptAppl  DB 13,10,'Name of Applicant/Driver: $'
    promptNum   DB 13,10,'Mobile Number: $'
    promptBrand DB 13,10,'Vehicle Make(s)/Brand: $'
    promptColor DB 13,10,'Vehicle Color: $'
    promptStkr  DB 13,10,'Vehicle Sticker Type: $'
    promptID    DB 13,10,'ID Number: $'
    promptAddr  DB 13,10,'Address: $'
    promptPlate DB 13,10,'Plate Number: $'
    promptVehicle DB 13,10,'Vehicle Type: $'


    summary     DB 13,10,'SUMMARY $'
    labelCIT    DB 'Cebu Institute of Technology - University','$'
    labelVeh    DB 'VEHICLE STICKER APPLICATION FORM','$'
    labelForm   DB 'Please fill out the form below','$'
    checking    DB 13,10,'Please check if all information are correct',13,10,'$'
    labelID     DB 13,10,'ID Number: $'
    labelPer    DB 'Personnel Type: $'
    labelAddr   DB 13,10,'Address: $'
    labelCourse DB 13,10,'Course & Year: $'
    labelBday   DB 13,10,'Birthday: $'
    labelEmail  DB 13,10,'Email Address: $'
    comma       DB ', ', '$'
    newlineStr  DB 13,10,'$'

    ThankU      DB 13,10,'Thank you for enrolling at CIT-U.$'
    copyRight   DB 13,10,'Copyright 2024$'
    MyName      DB 13,10,'Programmer: ALLEAH DELA PENA$'

    Personnel   DB 21, 0, 20 DUP(0)
    Applicant   DB 31, 0, 30 DUP(0)
    MobileNum   DB 16, 0, 15 DUP(0)
    Brand       DB 21, 0, 20 DUP(0)
    Color       DB 16, 0, 15 DUP(0)
    Sticker     DB 16, 0, 15 DUP(0)
    idnum       DB 16, 0, 15 DUP(0)
    plate       DB 16, 0, 15 DUP(0)
    vehicle     DB 16, 0, 15 DUP(0)
    address     DB 31, 0, 30 DUP(0)
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

.CODE
Start:

    MOV AX, @DATA
    MOV DS, AX

    mov ah, 00h
    mov al, 03h
    int 10h

    ; Display form title
    InputStr CIT
    InputStr TITLESR
    

    ; Get Personnel Type
    InputStr promptPer
    GetInput Personnel
    

    ; Get Applicant/Driver Name
    InputStr promptAppl
    GetInput Applicant

    ; Get Mobile Number
    InputStr promptNum
    GetInput MobileNum

    ; Get Vehicle Brand
    InputStr promptBrand
    GetInput Brand

    ; Get Vehicle Color
    InputStr promptColor
    GetInput Color

    ; Get Vehicle Sticker Type
    InputStr promptStkr
    GetInput Sticker

   ; Get Student ID Number
    InputStr promptID
    GetInput idnum

   
    ; Get Address
   InputStr promptAddr
    GetInput address

    ; Get Plate Number
    InputStr promptPlate
    GetInput plate

    ; Get Vehicle Type
    InputStr promptVehicle
    GetInput vehicle

    ; Wait for user to press a key before displaying summary
	NEWLINE
	InputStr summary
    
    NEWLINE


    mov ah, 1
    int 21h

    ; Display summary
    
    

    mov ax, @data
    mov ds, ax

    ; Set to video mode 
    mov ah, 00h
    mov al, 03h ; 80x25 color text mode
    int 10h
 ;outer   

	setcursor 0, 0
	renderc 20h, 0, 7fh, 4

	setcursor 0, 4
	renderc 20h, 0, 44h, 72

	setcursor 0, 76
	renderc 20h, 0, 7fh, 4

; first row
	setcursor 1, 0
	renderc 20h, 0, 7fh, 4

	setcursor 1, 4
	renderc 20h, 0, 44h, 17

	setcursor 1, 21
	renderc 20h, 0, 4fh, 1

	setcursor 1, 22
	colorz 4fh, 41
	mov ah, 09h
	mov dx, offset txt_0_R1_C22
	int 21h

    

	setcursor 1, 63
	renderc 20h, 0, 4eh, 4

	setcursor 1, 67
	renderc 20h, 0, 44h, 9

	setcursor 1, 76
	renderc 20h, 0, 7fh, 4

; second row
	setcursor 2, 0
	renderc 20h, 0, 7fh, 4

	setcursor 2, 4
	renderc 20h, 0, 44h, 72

	setcursor 2, 76
	renderc 20h, 0, 7fh, 4

	setcursor 3, 0
	renderc 20h, 0, 7fh, 4

	setcursor 3, 4
	renderc 20h, 0, 44h, 5

	setcursor 3, 9
	renderc 20h, 0, 4eh, 8

	setcursor 3, 17
	renderc 20h, 0, 4fh, 9
; third row
	setcursor 3, 26
	colorz 4fh, 32
	mov ah, 09h
	mov dx, offset txt_1_R3_C26
	int 21h

	setcursor 3, 58
	renderc 20h, 0, 4eh, 10

	setcursor 3, 68
	renderc 20h, 0, 44h, 8

	setcursor 3, 76
	renderc 20h, 0, 7fh, 4

; fourth row
	setcursor 4, 0
	renderc 20h, 0, 7fh, 4

	setcursor 4, 4
	renderc 20h, 0, 44h, 5

	setcursor 4, 9
	renderc 20h, 0, 4eh, 8

	setcursor 4, 17
	renderc 20h, 0, 4fh, 36

	setcursor 4, 53
	renderc 20h, 0, 4eh, 15

	setcursor 4, 68
	renderc 20h, 0, 44h, 8

	setcursor 4, 76
	renderc 20h, 0, 7fh, 4

; fifth row
	setcursor 5, 0
	renderc 20h, 0, 7fh, 4

	setcursor 5, 4
	renderc 20h, 0, 44h, 5

	setcursor 5, 9
	renderc 20h, 0, 4eh, 8

	setcursor 5, 17
	renderc 20h, 0, 4fh, 9

	setcursor 5, 26
	colorz 4eh, 29
	mov ah, 09h
	mov dx, offset txt_2_R5_C26
	int 21h


	setcursor 5, 55
	renderc 20h, 0, 4eh, 12

	setcursor 5, 67
	renderc 20h, 0, 44h, 9

	setcursor 5, 76
	renderc 20h, 0, 7fh, 4

; sixth row
	setcursor 6, 0
	renderc 20h, 0, 7fh, 80

; seventh row
	setcursor 7, 0
	renderc 20h, 0, 7fh, 4

	setcursor 7, 4
	colorz 70h, 59
	mov ah, 09h
	mov dx, offset txt_3_R7_C4
	int 21h


	setcursor 7, 23
	renderc 20h, 0, 4eh, 17
    PrintInput Personnel, 7, 24, 4eh

	setcursor 7, 39
	colorz 6Fh, 1
	mov ah, 09h
	mov dx, offset arrow
	int 21h

    setcursor 7, 62
	renderc 20h, 0, 7fh, 18
    
	setcursor 7, 63
	renderc 20h, 0, 4eh, 18
	PrintInput Sticker, 7, 64, 4eh

	setcursor 7, 75
	colorz 6Fh, 1
	mov ah, 09h
	mov dx, offset arrow
	int 21h

	setcursor 7, 76
	renderc 20h, 0, 7fh, 18
	
; eighth row
	setcursor 8, 0
	renderc 20h, 0, 7fh, 80
; ninth row
	setcursor 9, 0
	renderc 20h, 0, 7fh, 4

	setcursor 9, 4
	colorz 70h, 47
    

	mov ah, 09h
	mov dx, offset txt_4_R9_C4
	int 21h

	setcursor 9, 23
	renderc 20h, 0, 4eh, 17
    PrintInput Applicant, 9, 24, 4eh
	
    setcursor 9, 51
	renderc 20h, 0, 7fh, 18

	setcursor 9, 63
	renderc 20h, 0, 4eh, 18
	PrintInput idnum, 9, 64, 4eh

	setcursor 9, 76
	renderc 20h, 0, 7fh, 18
; tenth row	
	setcursor 10, 0
	renderc 20h, 0, 7fh, 80

    
; eleventh row
	setcursor 11, 0
	renderc 20h, 0, 7fh, 4

	setcursor 11, 4
	colorz 70h, 45
	mov ah, 09h
	mov dx, offset txt_5_R11_C4
	int 21h

	setcursor 11, 23
	renderc 20h, 0, 4eh, 17
	PrintInput MobileNum, 11, 24, 4eh

	setcursor 11, 49
	renderc 20h, 0, 7fh, 18

	setcursor 11, 63
	renderc 20h, 0, 4eh, 31
	PrintInput address, 11, 64, 4eh

	setcursor 11, 76
	renderc 20h, 0, 7fh, 18
; twelfth row	
	setcursor 12, 0
	renderc 20h, 0, 7fh, 80

; thirteenth row
	setcursor 13, 0
	renderc 20h, 0, 7fh, 4

	setcursor 13, 4
	colorz 70h, 50
	mov ah, 09h
	mov dx, offset txt_6_R13_C4
	int 21h
	
	setcursor 13, 23
	renderc 20h, 0, 4eh, 17
	PrintInput Brand, 13, 24, 4eh

	setcursor 13, 54
	renderc 20h, 0, 7fh, 18

	setcursor 13, 63
	renderc 20h, 0, 4eh, 31
	PrintInput plate, 13, 64, 4eh

	setcursor 13, 76
	renderc 20h, 0, 7fh, 18
; fourteenth row
	setcursor 14, 0
	renderc 20h, 0, 7fh, 80
; fifteenth row
	setcursor 15, 0
	renderc 20h, 0, 7fh, 4

	setcursor 15, 4
	colorz 70h, 50
	mov ah, 09h
	mov dx, offset txt_7_R15_C4
	int 21h
	
	setcursor 15, 23
	renderc 20h, 0, 4eh, 17
    PrintInput Color, 15, 24, 4eh

	setcursor 15, 39
	colorz 6Fh, 1
	mov ah, 09h
	mov dx, offset arrow
	int 21h

    setcursor 15, 54
	renderc 20h, 0, 7fh, 18

	setcursor 15, 63
	renderc 20h, 0, 4eh, 18
	PrintInput Vehicle, 15, 64, 4eh

	setcursor 15, 75
	colorz 6Fh, 1
	mov ah, 09h
	mov dx, offset arrow
	int 21h

	setcursor 15, 76
	renderc 20h, 0, 7fh, 18
; sixteenth row

	setcursor 16, 0
	renderc 20h, 0, 7fh, 80
; seventeenth row
	setcursor 17, 0
	renderc 20h, 0, 7fh, 31

	setcursor 17, 31
	renderc 20h, 0, 7eh, 2

	setcursor 17, 33
	renderc 20h, 0, 44h, 11

	setcursor 17, 44
	renderc 20h, 0, 7eh, 6

	setcursor 17, 50
	renderc 20h, 0, 7fh, 30
; eighteenth row
	setcursor 18, 0
	renderc 20h, 0, 7fh, 31

	setcursor 18, 31
	renderc 20h, 0, 7eh, 2

	setcursor 18, 33
	renderc 20h, 0, 44h, 2

	setcursor 18, 35
	renderc 20h, 0, 4eh, 1

	setcursor 18, 36
	colorz 4eh, 6
	mov ah, 09h
	mov dx, offset txt_8_R18_C36
	int 21h

	setcursor 18, 42
	renderc 20h, 0, 4eh, 1

	setcursor 18, 43
	renderc 20h, 0, 44h, 1

	setcursor 18, 44
	renderc 20h, 0, 7eh, 6

	setcursor 18, 50
	renderc 20h, 0, 7fh, 30
; nineteenth row
	setcursor 19, 0
	renderc 20h, 0, 7fh, 31

	setcursor 19, 31
	renderc 20h, 0, 7eh, 2

	setcursor 19, 33
	renderc 20h, 0, 44h, 11

	setcursor 19, 44
	renderc 20h, 0, 7eh, 5

	setcursor 19, 49
	renderc 20h, 0, 7fh, 31
; twentieth row
	setcursor 20, 0
	renderc 20h, 0, 7fh, 31

	setcursor 20, 31
	renderc 20h, 0, 7eh, 1

	setcursor 20, 32
	renderc 20h, 0, 74h, 17

	setcursor 20, 49
	renderc 20h, 0, 7fh, 31
; twenty-first row
	setcursor 21, 0
	renderc 20h, 0, 7fh, 19

	setcursor 21, 19
	renderc 20h, 0, 70h, 1

	setcursor 21, 20
	colorz 70h, 31
	mov ah, 09h
	mov dx, offset txt_9_R21_C20
	int 21h

	setcursor 21, 51
	renderc 20h, 0, 7fh, 29
; twenty-second row
	setcursor 22, 0
	renderc 20h, 0, 7fh, 38

	setcursor 22, 38
	renderc 20h, 0, 74h, 11

	setcursor 22, 49
	renderc 20h, 0, 7fh, 31
; twenty-third row
	setcursor 23, 0
	renderc 20h, 0, 0eh, 31

	setcursor 23, 34
	colorz 0eh, 10
	mov ah, 09h
	mov dx, offset txt_10_R23_C31
	int 21h

	setcursor 23, 51
	renderc 20h, 0, 0eh, 40

    mov ah, 4Ch      ; DOS exit function
    mov al, 0        ; Return code 0
    int 21h            ; Call DOS interrupt
