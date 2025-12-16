; Filename: EXER24.ASM
; Programmer Name: Alleah Dela Pena
; Date: September 12, 2025
; Description: College Enrollment Form. Gets user input for student details and displays a summary.

.MODEL SMALL
.STACK 100H

.DATA
    CIT         DB 'Cebu Institute of Technology - University',13,10,'$'
    TITLESR     DB 'STUDENT ENROLLMENT FORM',13,10,'$'
    promptID    DB 13,10,'Student ID Number: $'
    promptFN    DB 13,10,'First Name: $'
    promptMN    DB 13,10,'Middle Name: $'
    promptLN    DB 13,10,'Last Name: $'
    promptAddr  DB 13,10,'Address: $'
    promptCourse DB 13,10,'Course: $'
    promptYear  DB 13,10,'Year: $'
    promptBMonth DB 13,10,'Birthday Month: $'
    promptBDay  DB 13,10,'Birthday Day: $'
    promptBYear DB 13,10,'Birthday Year: $'
    promptEmail DB 13,10,'Email Address: $'

    summary     DB 13,10,'SUMMARY $'
    checking    DB 13,10,'Please check if all information are correct',13,10,'$'
    labelID     DB 13,10,'ID Number: $'
    labelFN     DB 13,10,'Full Name: $'
    labelAddr   DB 13,10,'Address: $'
    labelCourse DB 13,10,'Course & Year: $'
    labelBday   DB 13,10,'Birthday: $'
    labelEmail  DB 13,10,'Email Address: $'
    comma       DB ', ', '$'
    newlineStr  DB 13,10,'$'

    ThankU      DB 13,10,'Thank you for enrolling at CIT-U.$'
    copyRight   DB 13,10,'Copyright 2024$'
    MyName      DB 13,10,'Programmer: ALLEAH DELA PENA$'

    idnum       DB 16,?,15 DUP('$')
    fname       DB 21,?,20 DUP('$')
    mname       DB 21,?,20 DUP('$')
    lname       DB 21,?,20 DUP('$')
    address     DB 31,?,30 DUP('$')
    course      DB 11,?,10 DUP('$')
    year        DB 6,?,5 DUP('$')
    bmonth      DB 11,?,10 DUP('$')
    bday        DB 4,?,3 DUP('$')
    byear       DB 6,?,5 DUP('$')
    email       DB 51,?,50 DUP('$')

SPACE MACRO
    mov ah, 2
    mov dl, ' '
    int 21h
ENDM  
GetInput MACRO address
    mov ah, 0Ah
    lea dx, address
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
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Display form title
    InputStr CIT
    InputStr TITLESR
    

    ; Get Student ID Number
    InputStr promptID
    GetInput idnum

    ; Get First Name
    InputStr promptFN
    GetInput fname

    ; Get Middle Name
    InputStr promptMN
    GetInput mname
    

    ; Get Last Name
    InputStr promptLN
    GetInput lname
   
    ; Get Address
   InputStr promptAddr
    GetInput address

    ; Get Course
    InputStr promptCourse
    GetInput course
   
    ; Get Year
    InputStr promptYear
    GetInput year
   
    ; Get Birthday Month
    InputStr promptBMonth
    GetInput bmonth
    
    ; Get Birthday Day
    InputStr promptBDay
    GetInput bday

    ; Get Birthday Year
    InputStr promptBYear
    GetInput byear

    ; Get Email Address
    InputStr promptEmail
    GetInput email


    mov ah, 1
    int 21h

    ; Display summary
    
    InputStr summary
    InputStr checking
    ; Student ID Number
    InputStr labelID
    lea si, idnum
    mov cl, [si+1]
    mov ch, 0
    add si, 2
PRINT_ID:
    cmp cl, 0
    je PRINT_LN
    mov dl, [si]
    mov ah, 2
    int 21h
    inc si
    dec cl
    jmp PRINT_ID
    
PRINT_LN:
    InputStr labelFN
    lea si, lname
    mov cl, [si+1]
    mov ch, 0
    add si, 2


PRINT_LN_LOOP:
    cmp cl, 0
    je PRINT_FN
    mov dl, [si]
    mov ah, 2
    int 21h
    inc si
    dec cl
    jmp PRINT_LN_LOOP

PRINT_FN:
    InputStr comma
    
    lea si, fname
    mov cl, [si+1]
    mov ch, 0
    add si, 2
PRINT_FN_LOOP:
    cmp cl, 0
    je PRINT_MN
    mov dl, [si]
    mov ah, 2
    int 21h
    inc si
    dec cl
    jmp PRINT_FN_LOOP

PRINT_MN:
    
    SPACE
    lea si, mname
    mov cl, [si+1]
    mov ch, 0
    add si, 2
PRINT_MN_LOOP:
    cmp cl, 0
    je PRINT_ADDR
    mov dl, [si]
    mov ah, 2
    int 21h
    inc si
    dec cl
    jmp PRINT_MN_LOOP


PRINT_ADDR:
    mov ah, 9
    mov dx, offset labelAddr
    int 21h
    lea si, address
    mov cl, [si+1]
    mov ch, 0
    add si, 2
PRINT_ADDR_LOOP:
    cmp cl, 0
    je PRINT_COURSE
    mov dl, [si]
    mov ah, 2
    int 21h
    inc si
    dec cl
    jmp PRINT_ADDR_LOOP

PRINT_COURSE:
    InputStr labelCourse
    lea si, course
    mov cl, [si+1]
    mov ch, 0
    add si, 2
PRINT_COURSE_LOOP:
    cmp cl, 0
    je PRINT_YEAR
    mov dl, [si]
    mov ah, 2
    int 21h
    inc si
    dec cl
    jmp PRINT_COURSE_LOOP

PRINT_YEAR:
    SPACE
    lea si, year
    mov cl, [si+1]
    mov ch, 0
    add si, 2
PRINT_YEAR_LOOP:
    cmp cl, 0
    je PRINT_BDAY
    mov dl, [si]
    mov ah, 2
    int 21h
    inc si
    dec cl
    jmp PRINT_YEAR_LOOP

PRINT_BDAY:
    InputStr labelBday
    ; Print Birthday Month
    lea si, bmonth
    mov cl, [si+1]
    mov ch, 0
    add si, 2
PRINT_BMONTH_LOOP:
    
    cmp cl, 0
    je PRINT_BDAY_DAY
    mov dl, [si]
    mov ah, 2
    int 21h
    inc si
    dec cl
    jmp PRINT_BMONTH_LOOP

PRINT_BDAY_DAY:
    SPACE
    ; Print Birthday Day
    lea si, bday
    mov cl, [si+1]
    mov ch, 0
    add si, 2
PRINT_BDAY_LOOP:
    cmp cl, 0
    je PRINT_BDAY_YEAR
    mov dl, [si]
    mov ah, 2
    int 21h
    inc si
    dec cl
    jmp PRINT_BDAY_LOOP

PRINT_BDAY_YEAR:
    InputStr comma
    ; Print Birthday Year
    lea si, byear
    mov cl, [si+1]
    mov ch, 0
    add si, 2
PRINT_BYEAR_LOOP:
    cmp cl, 0
    je PRINT_EMAIL
    mov dl, [si]
    mov ah, 2
    int 21h
    inc si
    dec cl
    jmp PRINT_BYEAR_LOOP

PRINT_EMAIL:
    InputStr labelEmail
    lea si, email
    mov cl, [si+1]
    mov ch, 0
    add si, 2
PRINT_EMAIL_LOOP:
    cmp cl, 0
    je PRINT_THANKS
    mov dl, [si]
    mov ah, 2
    int 21h
    inc si
    dec cl
    jmp PRINT_EMAIL_LOOP

PRINT_THANKS:
    NEWLINE
    ; Display thank you message
    InputStr ThankU
    InputStr copyRight
    InputStr MyName
EXIT:
    mov ah, 4Ch
    int 21h
MAIN ENDP
END MAIN