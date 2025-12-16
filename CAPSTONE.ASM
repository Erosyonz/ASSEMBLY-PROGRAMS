; ================================================================
; LIBRARY MANAGEMENT SYSTEM - FIXED VERSION
; ================================================================
; System Name: Library Book Management System
; Description: A comprehensive library system with user registration,
;              login functionality, and full CRUD operations for
;              managing book records. Users can add, view, update,
;              and delete book records during runtime. The system
;              supports multiple user accounts with authentication.
; Programmer: [Your Name Here]
; Date Written: November 22, 2025
; ================================================================

.MODEL SMALL
.STACK 100H

.DATA
    ; ============ SYSTEM INFORMATION ============
    SYSTEM_NAME     DB 13, 10, '    ========================================', 13, 10
                    DB '    LIBRARY BOOK MANAGEMENT SYSTEM', 13, 10
                    DB '    ========================================', 13, 10, '$'
    
    PROGRAMMER      DB '    Programmer: [Your Name]', 13, 10, '$'
    DATE_WRITTEN    DB '    Date: November 22, 2025', 13, 10, '$'
    PRESS_KEY       DB 13, 10, '    Press any key to continue...', '$'
    
    ; ============ MENU STRINGS ============
    MAIN_MENU       DB 13, 10, '    ========== MAIN MENU ==========', 13, 10
                    DB '    1. Add New Book', 13, 10
                    DB '    2. View All Books', 13, 10
                    DB '    3. Update Book', 13, 10
                    DB '    4. Delete Book', 13, 10
                    DB '    5. Logout', 13, 10
                    DB '    Enter choice: $'
    
    LOGIN_MENU      DB 13, 10, '    ========== WELCOME ==========', 13, 10
                    DB '    1. Register New Customer', 13, 10
                    DB '    2. Login', 13, 10
                    DB '    3. Exit', 13, 10
                    DB '    Enter choice: $'
    
    ; ============ PROMPT STRINGS ============
    REG_HEADER      DB 13, 10, '    ===== CUSTOMER REGISTRATION =====', 13, 10, '$'
    LOGIN_HEADER    DB 13, 10, '    ========== LOGIN ==========', 13, 10, '$'
    ADD_HEADER      DB 13, 10, '    ===== ADD NEW BOOK =====', 13, 10, '$'
    VIEW_HEADER     DB 13, 10, '    ===== BOOK RECORDS =====', 13, 10, '$'
    UPDATE_HEADER   DB 13, 10, '    ===== UPDATE BOOK =====', 13, 10, '$'
    DELETE_HEADER   DB 13, 10, '    ===== DELETE BOOK =====', 13, 10, '$'
    
    PROMPT_USER     DB 13, 10, '    Enter Username: $'
    PROMPT_PASS     DB 13, 10, '    Enter Password: $'
    PROMPT_TITLE    DB 13, 10, '    Book Title: $'
    PROMPT_AUTHOR   DB 13, 10, '    Author: $'
    PROMPT_ISBN     DB 13, 10, '    ISBN: $'
    PROMPT_ID       DB 13, 10, '    Enter Book ID: $'
    
    ; ============ MESSAGE STRINGS ============
    MSG_SUCCESS     DB 13, 10, '    Success! ', '$'
    MSG_FAIL        DB 13, 10, '    Failed! ', '$'
    MSG_INVALID     DB 13, 10, '    Invalid choice!', '$'
    MSG_NOTFOUND    DB 13, 10, '    Record not found!', '$'
    MSG_REGISTERED  DB 'Customer registered successfully!', '$'
    MSG_LOGIN_OK    DB 'Login successful!', '$'
    MSG_LOGIN_FAIL  DB 'Invalid credentials!', '$'
    MSG_BOOK_ADDED  DB 'Book added successfully!', '$'
    MSG_BOOK_UPD    DB 'Book updated successfully!', '$'
    MSG_BOOK_DEL    DB 'Book deleted successfully!', '$'
    MSG_NO_BOOKS    DB 13, 10, '    No books in library!', 13, 10, '$'
    MSG_FULL        DB 13, 10, '    Database full!', '$'
    MSG_EMPTY_INPUT DB 13, 10, '    Input cannot be empty!', '$'
    CONFIRM_MSG     DB 13, 10, '    Are you sure? (Y/N): $'
    
    BOOK_DISPLAY    DB 13, 10, '    ID: $'
    BOOK_TITLE_D    DB ' | Title: $'
    BOOK_AUTHOR_D   DB ' | Author: $'
    BOOK_ISBN_D     DB ' | ISBN: $'
    DIVIDER         DB 13, 10, '    -------------------------------', 13, 10, '$'
    
    ; ============ DATA STORAGE ============
    MAX_USERS       EQU 10
    MAX_BOOKS       EQU 20
    USER_COUNT      DB 0
    BOOK_COUNT      DB 0
    CURRENT_USER    DB 0FFH     ; 0FFH = not logged in
    
    ; User structure: [Username 15B][Password 15B]
    USERS           DB MAX_USERS DUP(30 DUP(0))
    
    ; Book structure: [ID 1B][Title 30B][Author 20B][ISBN 15B]
    BOOKS           DB MAX_BOOKS DUP(66 DUP(0))
    
    ; Input buffers
    INPUT_BUFFER    DB 50 DUP(0)
    TEMP_USER       DB 15 DUP(0)
    TEMP_PASS       DB 15 DUP(0)
    TEMP_TITLE      DB 30 DUP(0)
    TEMP_AUTHOR     DB 20 DUP(0)
    TEMP_ISBN       DB 15 DUP(0)
    TEMP_ID         DB 0
    CHOICE          DB 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ; Display opening screen
    CALL CLEAR_SCREEN
    CALL SHOW_OPENING_SCREEN
    
    ; Main login loop
LOGIN_LOOP:
    CALL CLEAR_SCREEN
    CALL SHOW_LOGIN_MENU
    
    CMP CHOICE, '1'
    JE DO_REGISTER
    CMP CHOICE, '2'
    JE DO_LOGIN
    CMP CHOICE, '3'
    JE EXIT_PROGRAM
    
    LEA DX, MSG_INVALID
    CALL PRINT_STRING
    CALL WAIT_KEY
    JMP LOGIN_LOOP
    
DO_REGISTER:
    CALL REGISTER_CUSTOMER
    JMP LOGIN_LOOP
    
DO_LOGIN:
    CALL LOGIN_CUSTOMER
    CMP CURRENT_USER, 0FFH
    JE LOGIN_LOOP
    
    CALL WAIT_KEY
    
MAIN_LOOP:
    CALL CLEAR_SCREEN
    CALL SHOW_MAIN_MENU
    
    CMP CHOICE, '1'
    JE DO_ADD
    CMP CHOICE, '2'
    JE DO_VIEW
    CMP CHOICE, '3'
    JE DO_UPDATE
    CMP CHOICE, '4'
    JE DO_DELETE
    CMP CHOICE, '5'
    JE DO_LOGOUT
    
    LEA DX, MSG_INVALID
    CALL PRINT_STRING
    CALL WAIT_KEY
    JMP MAIN_LOOP
    
DO_ADD:
    CALL ADD_BOOK
    JMP MAIN_LOOP
    
DO_VIEW:
    CALL VIEW_BOOKS
    JMP MAIN_LOOP
    
DO_UPDATE:
    CALL UPDATE_BOOK
    JMP MAIN_LOOP
    
DO_DELETE:
    CALL DELETE_BOOK
    JMP MAIN_LOOP
    
DO_LOGOUT:
    MOV CURRENT_USER, 0FFH
    JMP LOGIN_LOOP
    
EXIT_PROGRAM:
    MOV AH, 4CH
    INT 21H
MAIN ENDP

; ============================================================
; SCREEN DISPLAY PROCEDURES
; ============================================================

SHOW_OPENING_SCREEN PROC
    LEA DX, SYSTEM_NAME
    CALL PRINT_STRING
    LEA DX, PROGRAMMER
    CALL PRINT_STRING
    LEA DX, DATE_WRITTEN
    CALL PRINT_STRING
    LEA DX, PRESS_KEY
    CALL PRINT_STRING
    CALL WAIT_KEY
    RET
SHOW_OPENING_SCREEN ENDP

SHOW_LOGIN_MENU PROC
    LEA DX, LOGIN_MENU
    CALL PRINT_STRING
    CALL GET_CHOICE
    RET
SHOW_LOGIN_MENU ENDP

SHOW_MAIN_MENU PROC
    LEA DX, MAIN_MENU
    CALL PRINT_STRING
    CALL GET_CHOICE
    RET
SHOW_MAIN_MENU ENDP

; ============================================================
; USER MANAGEMENT PROCEDURES
; ============================================================

REGISTER_CUSTOMER PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    
    CALL CLEAR_SCREEN
    LEA DX, REG_HEADER
    CALL PRINT_STRING
    
    ; Check if database is full
    MOV AL, USER_COUNT
    CMP AL, MAX_USERS
    JB REG_NOT_FULL
    JMP REG_FULL
    
REG_NOT_FULL:
    ; Clear temp buffer
    CALL CLEAR_TEMP_USER
    
    ; Get username
    LEA DX, PROMPT_USER
    CALL PRINT_STRING
    LEA DX, TEMP_USER
    MOV CX, 15
    CALL GET_STRING
    
    ; Check if username is empty
    LEA DX, TEMP_USER
    CALL CHECK_EMPTY_INPUT
    JC REG_INVALID_INPUT
    
    ; Get password
    LEA DX, PROMPT_PASS
    CALL PRINT_STRING
    LEA DX, TEMP_PASS
    MOV CX, 15
    CALL GET_STRING
    
    ; Check if password is empty
    LEA DX, TEMP_PASS
    CALL CHECK_EMPTY_INPUT
    JC REG_INVALID_INPUT
    
    ; Check if username already exists
    CALL CHECK_USER_EXISTS
    JC REG_USER_EXISTS
    
    ; Calculate offset for new user
    MOV AL, USER_COUNT
    MOV BL, 30
    MUL BL
    LEA SI, USERS
    ADD SI, AX
    
    ; Copy username
    LEA DI, TEMP_USER
    MOV CX, 15
    CALL COPY_MEMORY
    
    ; Copy password
    ADD SI, 15
    LEA DI, TEMP_PASS
    MOV CX, 15
    CALL COPY_MEMORY
    
    ; Increment user count
    INC USER_COUNT
    
    LEA DX, MSG_SUCCESS
    CALL PRINT_STRING
    LEA DX, MSG_REGISTERED
    CALL PRINT_STRING
    CALL WAIT_KEY
    JMP REG_END
    
REG_FULL:
    LEA DX, MSG_FULL
    CALL PRINT_STRING
    CALL WAIT_KEY
    JMP REG_END
    
REG_USER_EXISTS:
    LEA DX, MSG_FAIL
    CALL PRINT_STRING
    LEA DX, MSG_LOGIN_FAIL
    CALL PRINT_STRING
    CALL WAIT_KEY
    JMP REG_END
    
REG_INVALID_INPUT:
    LEA DX, MSG_EMPTY_INPUT
    CALL PRINT_STRING
    CALL WAIT_KEY
    
REG_END:
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
REGISTER_CUSTOMER ENDP

LOGIN_CUSTOMER PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    
    CALL CLEAR_SCREEN
    LEA DX, LOGIN_HEADER
    CALL PRINT_STRING
    
    ; Clear temp buffers
    CALL CLEAR_TEMP_USER
    
    ; Get username
    LEA DX, PROMPT_USER
    CALL PRINT_STRING
    LEA DX, TEMP_USER
    MOV CX, 15
    CALL GET_STRING
    
    ; Get password
    LEA DX, PROMPT_PASS
    CALL PRINT_STRING
    LEA DX, TEMP_PASS
    MOV CX, 15
    CALL GET_STRING
    
    ; Search for user
    MOV CL, USER_COUNT
    CMP CL, 0
    JE LOGIN_FAIL
    
    XOR CH, CH
    MOV BL, 0
    LEA SI, USERS
    
LOGIN_CHECK:
    ; Compare username
    PUSH SI
    LEA DI, TEMP_USER
    MOV CX, 15
    CALL COMPARE_MEMORY
    POP SI
    JNE LOGIN_NEXT
    
    ; Compare password
    PUSH SI
    ADD SI, 15
    LEA DI, TEMP_PASS
    MOV CX, 15
    CALL COMPARE_MEMORY
    POP SI
    JNE LOGIN_NEXT
    
    ; Login successful
    MOV CURRENT_USER, BL
    
    MOV AH, 02H
    MOV DL, 13
    INT 21H
    MOV DL, 10
    INT 21H
    
    LEA DX, MSG_SUCCESS
    CALL PRINT_STRING
    LEA DX, MSG_LOGIN_OK
    CALL PRINT_STRING
    
    MOV AH, 02H
    MOV DL, 13
    INT 21H
    MOV DL, 10
    INT 21H
    
    LEA DX, PRESS_KEY
    CALL PRINT_STRING
    JMP LOGIN_END
    
LOGIN_NEXT:
    ADD SI, 30
    INC BL
    DEC CL
    JNZ LOGIN_CHECK
    
LOGIN_FAIL:
    MOV AH, 02H
    MOV DL, 13
    INT 21H
    MOV DL, 10
    INT 21H
    
    LEA DX, MSG_FAIL
    CALL PRINT_STRING
    LEA DX, MSG_LOGIN_FAIL
    CALL PRINT_STRING
    MOV CURRENT_USER, 0FFH
    
    MOV AH, 02H
    MOV DL, 13
    INT 21H
    MOV DL, 10
    INT 21H
    
    LEA DX, PRESS_KEY
    CALL PRINT_STRING
    CALL WAIT_KEY
    
LOGIN_END:
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
LOGIN_CUSTOMER ENDP

; ============================================================
; BOOK MANAGEMENT PROCEDURES (CRUD)
; ============================================================

ADD_BOOK PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    
    CALL CLEAR_SCREEN
    LEA DX, ADD_HEADER
    CALL PRINT_STRING
    
    ; Check if database is full
    MOV AL, BOOK_COUNT
    CMP AL, MAX_BOOKS
    JB ADD_NOT_FULL
    JMP ADD_FULL
    
ADD_NOT_FULL:
    ; Clear temp buffers
    CALL CLEAR_TEMP_BOOK
    
    ; Get book title
    LEA DX, PROMPT_TITLE
    CALL PRINT_STRING
    LEA DX, TEMP_TITLE
    MOV CX, 30
    CALL GET_STRING
    
    ; Check if title is empty
    LEA DX, TEMP_TITLE
    CALL CHECK_EMPTY_INPUT
    JC ADD_INVALID_INPUT
    
    ; Get book author
    LEA DX, PROMPT_AUTHOR
    CALL PRINT_STRING
    LEA DX, TEMP_AUTHOR
    MOV CX, 20
    CALL GET_STRING
    
    ; Check if author is empty
    LEA DX, TEMP_AUTHOR
    CALL CHECK_EMPTY_INPUT
    JC ADD_INVALID_INPUT
    
    ; Get book ISBN
    LEA DX, PROMPT_ISBN
    CALL PRINT_STRING
    LEA DX, TEMP_ISBN
    MOV CX, 15
    CALL GET_STRING
    
    ; Check if ISBN is empty
    LEA DX, TEMP_ISBN
    CALL CHECK_EMPTY_INPUT
    JC ADD_INVALID_INPUT
    
    ; Calculate offset for new book
    MOV AL, BOOK_COUNT
    MOV BL, 66
    MUL BL
    LEA SI, BOOKS
    ADD SI, AX
    
    ; Store book ID (1-based)
    MOV AL, BOOK_COUNT
    INC AL
    MOV [SI], AL
    
    ; Copy data to book record
    INC SI ; Move past ID
    
    ; Copy title (30 bytes)
    LEA DI, TEMP_TITLE
    MOV CX, 30
    CALL COPY_MEMORY
    
    ; Copy author (20 bytes)  
    LEA DI, TEMP_AUTHOR
    MOV CX, 20
    CALL COPY_MEMORY
    
    ; Copy ISBN (15 bytes)
    LEA DI, TEMP_ISBN
    MOV CX, 15
    CALL COPY_MEMORY
    
    ; Increment book count
    INC BOOK_COUNT
    
    LEA DX, MSG_SUCCESS
    CALL PRINT_STRING
    LEA DX, MSG_BOOK_ADDED
    CALL PRINT_STRING
    CALL WAIT_KEY
    JMP ADD_END
    
ADD_FULL:
    LEA DX, MSG_FULL
    CALL PRINT_STRING
    CALL WAIT_KEY
    JMP ADD_END
    
ADD_INVALID_INPUT:
    LEA DX, MSG_EMPTY_INPUT
    CALL PRINT_STRING
    CALL WAIT_KEY
    
ADD_END:
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
ADD_BOOK ENDP

VIEW_BOOKS PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    
    CALL CLEAR_SCREEN
    LEA DX, VIEW_HEADER
    CALL PRINT_STRING
    
    MOV CL, BOOK_COUNT
    CMP CL, 0
    JE VIEW_EMPTY
    
    XOR CH, CH
    LEA SI, BOOKS
    
VIEW_LOOP:
    PUSH CX
    PUSH SI
    
    LEA DX, DIVIDER
    CALL PRINT_STRING
    
    ; Display ID
    LEA DX, BOOK_DISPLAY
    CALL PRINT_STRING
    MOV AL, [SI]
    CALL PRINT_NUMBER
    
    ; Display Title (starts at SI+1)
    LEA DX, BOOK_TITLE_D
    CALL PRINT_STRING
    MOV DI, SI
    INC DI       ; Move to title
    MOV CX, 30
    CALL PRINT_FIELD
    
    ; Display Author (starts at SI+31)
    LEA DX, BOOK_AUTHOR_D
    CALL PRINT_STRING
    MOV DI, SI
    ADD DI, 31   ; Move to author (1 + 30)
    MOV CX, 20
    CALL PRINT_FIELD
    
    ; Display ISBN (starts at SI+51)
    LEA DX, BOOK_ISBN_D
    CALL PRINT_STRING
    MOV DI, SI
    ADD DI, 51   ; Move to ISBN (1 + 30 + 20)
    MOV CX, 15
    CALL PRINT_FIELD
    
    POP SI
    POP CX
    
    ; Move to next record
    ADD SI, 66
    DEC CX
    JNZ VIEW_LOOP
    
    LEA DX, DIVIDER
    CALL PRINT_STRING
    CALL WAIT_KEY
    JMP VIEW_END
    
VIEW_EMPTY:
    LEA DX, MSG_NO_BOOKS
    CALL PRINT_STRING
    CALL WAIT_KEY
    
VIEW_END:
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
VIEW_BOOKS ENDP

UPDATE_BOOK PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    
    CALL CLEAR_SCREEN
    LEA DX, UPDATE_HEADER
    CALL PRINT_STRING
    
    ; Get book ID
    LEA DX, PROMPT_ID
    CALL PRINT_STRING
    CALL GET_NUMBER
    MOV TEMP_ID, AL
    
    ; Find book
    CALL FIND_BOOK
    CMP SI, 0FFFFH
    JE UPDATE_NOTFOUND
    
    ; Clear temp buffers
    CALL CLEAR_TEMP_BOOK
    
    ; Get new details
    LEA DX, PROMPT_TITLE
    CALL PRINT_STRING
    LEA DX, TEMP_TITLE
    MOV CX, 30
    CALL GET_STRING
    
    ; Check if title is empty
    LEA DX, TEMP_TITLE
    CALL CHECK_EMPTY_INPUT
    JC UPDATE_INVALID_INPUT
    
    LEA DX, PROMPT_AUTHOR
    CALL PRINT_STRING
    LEA DX, TEMP_AUTHOR
    MOV CX, 20
    CALL GET_STRING
    
    ; Check if author is empty
    LEA DX, TEMP_AUTHOR
    CALL CHECK_EMPTY_INPUT
    JC UPDATE_INVALID_INPUT
    
    LEA DX, PROMPT_ISBN
    CALL PRINT_STRING
    LEA DX, TEMP_ISBN
    MOV CX, 15
    CALL GET_STRING
    
    ; Check if ISBN is empty
    LEA DX, TEMP_ISBN
    CALL CHECK_EMPTY_INPUT
    JC UPDATE_INVALID_INPUT
    
    ; Update book (skip ID)
    INC SI
    
    ; Copy title
    LEA DI, TEMP_TITLE
    MOV CX, 30
    CALL COPY_MEMORY
    
    ; Copy author
    LEA DI, TEMP_AUTHOR
    MOV CX, 20
    CALL COPY_MEMORY
    
    ; Copy ISBN
    LEA DI, TEMP_ISBN
    MOV CX, 15
    CALL COPY_MEMORY
    
    LEA DX, MSG_SUCCESS
    CALL PRINT_STRING
    LEA DX, MSG_BOOK_UPD
    CALL PRINT_STRING
    CALL WAIT_KEY
    JMP UPDATE_END
    
UPDATE_NOTFOUND:
    LEA DX, MSG_NOTFOUND
    CALL PRINT_STRING
    CALL WAIT_KEY
    JMP UPDATE_END
    
UPDATE_INVALID_INPUT:
    LEA DX, MSG_EMPTY_INPUT
    CALL PRINT_STRING
    CALL WAIT_KEY
    
UPDATE_END:
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
UPDATE_BOOK ENDP

DELETE_BOOK PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    
    CALL CLEAR_SCREEN
    LEA DX, DELETE_HEADER
    CALL PRINT_STRING
    
    ; Get book ID
    LEA DX, PROMPT_ID
    CALL PRINT_STRING
    CALL GET_NUMBER
    MOV TEMP_ID, AL
    
    ; Find book
    CALL FIND_BOOK
    CMP SI, 0FFFFH
    JE DELETE_NOTFOUND
    
    ; Confirm deletion
    CALL CONFIRM_DELETE
    JNC DELETE_CANCELLED
    
DELETE_CONFIRMED:
    ; SI points to the start of the found book record
    ; Compute record index = (SI - offset BOOKS) / 66
    LEA BX, BOOKS
    MOV AX, SI
    SUB AX, BX
    MOV BL, 66
    DIV BL
    MOV CL, AL
    
    ; Calculate number of records AFTER this one to shift left
    MOV AL, BOOK_COUNT
    SUB AL, CL
    DEC AL
    CMP AL, 0
    JLE DELETE_LAST
    
    ; Compute byte count to move = shiftCount * 66
    MOV AH, 0
    MOV BL, 66
    MUL BL
    MOV CX, AX
    
    ; Set up pointers for shifting
    MOV DI, SI
    MOV BX, SI
    ADD BX, 66
    
SHIFT_LOOP:
    CMP CX, 0
    JE SHIFT_DONE
    MOV AL, [BX]
    MOV [DI], AL
    INC DI
    INC BX
    DEC CX
    JMP SHIFT_LOOP
    
SHIFT_DONE:
    ; Decrease book count
    DEC BOOK_COUNT
    
    ; Reassign book IDs to maintain sequential order
    CALL REASSIGN_BOOK_IDS
    
    LEA DX, MSG_SUCCESS
    CALL PRINT_STRING
    LEA DX, MSG_BOOK_DEL
    CALL PRINT_STRING
    CALL WAIT_KEY
    JMP DELETE_END
    
DELETE_LAST:
    DEC BOOK_COUNT
    LEA DX, MSG_SUCCESS
    CALL PRINT_STRING
    LEA DX, MSG_BOOK_DEL
    CALL PRINT_STRING
    CALL WAIT_KEY
    JMP DELETE_END
    
DELETE_NOTFOUND:
    LEA DX, MSG_NOTFOUND
    CALL PRINT_STRING
    CALL WAIT_KEY
    JMP DELETE_END
    
DELETE_CANCELLED:
    ; User cancelled, do nothing
    
DELETE_END:
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DELETE_BOOK ENDP

; ============================================================
; UTILITY PROCEDURES
; ============================================================

FIND_BOOK PROC
    PUSH AX
    PUSH BX
    PUSH CX
    
    MOV CL, BOOK_COUNT
    CMP CL, 0
    JE FIND_NOTFOUND
    
    XOR CH, CH
    LEA SI, BOOKS
    MOV BL, 0
    
FIND_LOOP:
    MOV AL, [SI]
    CMP AL, TEMP_ID
    JE FIND_FOUND
    
    ADD SI, 66
    INC BL
    CMP BL, BOOK_COUNT
    JB FIND_LOOP
    
FIND_NOTFOUND:
    MOV SI, 0FFFFH
    JMP FIND_EXIT
    
FIND_FOUND:
    ; SI now points to the found book
    
FIND_EXIT:
    POP CX
    POP BX
    POP AX
    RET
FIND_BOOK ENDP

CHECK_USER_EXISTS PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    
    MOV CL, USER_COUNT
    CMP CL, 0
    JE CHECK_USER_NOT_EXISTS
    
    XOR CH, CH
    LEA SI, USERS
    
CHECK_USER_LOOP:
    PUSH SI
    LEA DI, TEMP_USER
    MOV CX, 15
    CALL COMPARE_MEMORY
    POP SI
    JE CHECK_USER_EXISTS_FOUND
    
    ADD SI, 30
    DEC CL
    JNZ CHECK_USER_LOOP
    
CHECK_USER_NOT_EXISTS:
    CLC
    JMP CHECK_USER_END
    
CHECK_USER_EXISTS_FOUND:
    STC
    
CHECK_USER_END:
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
CHECK_USER_EXISTS ENDP

CHECK_EMPTY_INPUT PROC
    PUSH SI
    LEA SI, TEMP_USER
    CMP BYTE PTR [SI], 0
    JE CHECK_EMPTY
    CLC
    JMP CHECK_EMPTY_END
    
CHECK_EMPTY:
    STC
    
CHECK_EMPTY_END:
    POP SI
    RET
CHECK_EMPTY_INPUT ENDP

CONFIRM_DELETE PROC
    PUSH AX
    PUSH DX
    
    MOV AH, 02H
    MOV DL, 13
    INT 21H
    MOV DL, 10
    INT 21H
    
    LEA DX, CONFIRM_MSG
    CALL PRINT_STRING
    
CONFIRM_LOOP:
    MOV AH, 01H
    INT 21H
    
    CMP AL, 'Y'
    JE CONFIRM_YES
    CMP AL, 'y'
    JE CONFIRM_YES
    CMP AL, 'N'
    JE CONFIRM_NO
    CMP AL, 'n'
    JE CONFIRM_NO
    JMP CONFIRM_LOOP
    
CONFIRM_YES:
    STC
    JMP CONFIRM_END
    
CONFIRM_NO:
    CLC
    
CONFIRM_END:
    POP DX
    POP AX
    RET
CONFIRM_DELETE ENDP

REASSIGN_BOOK_IDS PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH SI
    
    MOV CL, BOOK_COUNT
    CMP CL, 0
    JE REASSIGN_END
    
    XOR CH, CH
    LEA SI, BOOKS
    MOV BL, 1
    
REASSIGN_LOOP:
    MOV [SI], BL
    ADD SI, 66
    INC BL
    LOOP REASSIGN_LOOP
    
REASSIGN_END:
    POP SI
    POP CX
    POP BX
    POP AX
    RET
REASSIGN_BOOK_IDS ENDP

CLEAR_SCREEN PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV AH, 06H
    MOV AL, 0
    MOV BH, 07H
    MOV CX, 0
    MOV DH, 24
    MOV DL, 79
    INT 10H
    
    MOV AH, 02H
    MOV BH, 0
    MOV DX, 0
    INT 10H
    
    POP DX
    POP CX
    POP BX
    POP AX
    RET
CLEAR_SCREEN ENDP

CLEAR_TEMP_USER PROC
    PUSH CX
    PUSH DI
    
    LEA DI, TEMP_USER
    MOV CX, 15
    CALL FILL_ZERO
    
    LEA DI, TEMP_PASS
    MOV CX, 15
    CALL FILL_ZERO
    
    POP DI
    POP CX
    RET
CLEAR_TEMP_USER ENDP

CLEAR_TEMP_BOOK PROC
    PUSH CX
    PUSH DI
    
    LEA DI, TEMP_TITLE
    MOV CX, 30
    CALL FILL_ZERO
    
    LEA DI, TEMP_AUTHOR
    MOV CX, 20
    CALL FILL_ZERO
    
    LEA DI, TEMP_ISBN
    MOV CX, 15
    CALL FILL_ZERO
    
    POP DI
    POP CX
    RET
CLEAR_TEMP_BOOK ENDP

FILL_ZERO PROC
    PUSH AX
    PUSH CX
    PUSH DI
    
    MOV AL, 0
FILL_LOOP:
    MOV [DI], AL
    INC DI
    LOOP FILL_LOOP
    
    POP DI
    POP CX
    POP AX
    RET
FILL_ZERO ENDP

PRINT_STRING PROC
    PUSH AX
    MOV AH, 09H
    INT 21H
    POP AX
    RET
PRINT_STRING ENDP

PRINT_FIELD PROC
    ; Input: DI = offset, CX = length
    PUSH AX
    PUSH DX
    PUSH CX
    PUSH DI
    
PRINT_FIELD_LOOP:
    MOV DL, [DI]
    CMP DL, 0
    JE PRINT_FIELD_SKIP
    
    MOV AH, 02H
    INT 21H
    
PRINT_FIELD_SKIP:
    INC DI
    LOOP PRINT_FIELD_LOOP
    
    POP DI
    POP CX
    POP DX
    POP AX
    RET
PRINT_FIELD ENDP

PRINT_NUMBER PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    XOR AH, AH
    MOV BL, 10
    XOR CX, CX
    
    CMP AL, 0
    JNE PRINT_NUM_LOOP
    MOV DL, '0'
    MOV AH, 02H
    INT 21H
    JMP PRINT_NUM_END
    
PRINT_NUM_LOOP:
    XOR AH, AH
    DIV BL
    PUSH AX
    INC CX
    CMP AL, 0
    JNE PRINT_NUM_LOOP
    
PRINT_NUM_DISPLAY:
    POP AX
    MOV DL, AH
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    LOOP PRINT_NUM_DISPLAY
    
PRINT_NUM_END:
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUMBER ENDP

GET_STRING PROC
    ; Input: DX = buffer offset, CX = max length
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH SI
    PUSH DI
    
    MOV SI, DX
    MOV DI, DX
    XOR BX, BX
    
    PUSH CX
    
GET_STR_LOOP:
    MOV AH, 01H
    INT 21H
    
    CMP AL, 13
    JE GET_STR_END
    
    CMP AL, 8
    JE GET_STR_BACK
    
    CMP BX, CX
    JAE GET_STR_LOOP
    
    MOV [SI], AL
    INC SI
    INC BX
    JMP GET_STR_LOOP
    
GET_STR_BACK:
    CMP BX, 0
    JE GET_STR_LOOP
    DEC SI
    DEC BX
    
    MOV AH, 02H
    MOV DL, 8
    INT 21H
    MOV DL, ' '
    INT 21H
    MOV DL, 8
    INT 21H
    
    JMP GET_STR_LOOP
    
GET_STR_END:
    MOV BYTE PTR [SI], 0
    
    POP CX
    
    SUB CX, BX
    DEC CX         ; Subtract 1 because we already wrote null terminator
    JCXZ NO_FILL
    
FILL_REMAINING:
    INC SI
    MOV BYTE PTR [SI], 0
    LOOP FILL_REMAINING
    
NO_FILL:
    POP DI
    POP SI
    POP CX
    POP BX
    POP AX
    RET
GET_STRING ENDP

GET_NUMBER PROC
    PUSH BX
    PUSH CX
    PUSH DX
    
    XOR BX, BX
    XOR CX, CX
    
GET_NUM_LOOP:
    MOV AH, 01H
    INT 21H
    
    CMP AL, 13
    JE GET_NUM_END
    
    CMP AL, '0'
    JB GET_NUM_LOOP
    CMP AL, '9'
    JA GET_NUM_LOOP
    
    SUB AL, '0'
    MOV CL, AL
    
    MOV AX, BX
    MOV BL, 10
    MUL BL
    MOV BX, AX
    ADD BL, CL
    ADC BH, 0
    JMP GET_NUM_LOOP
    
GET_NUM_END:
    MOV AL, BL
    POP DX
    POP CX
    POP BX
    RET
GET_NUMBER ENDP

GET_CHOICE PROC
    PUSH AX
    MOV AH, 01H
    INT 21H
    MOV CHOICE, AL
    POP AX
    RET
GET_CHOICE ENDP

WAIT_KEY PROC
    PUSH AX
    MOV AH, 00H
    INT 16H
    POP AX
    RET
WAIT_KEY ENDP

COPY_MEMORY PROC
    ; Input: SI = destination, DI = source, CX = count
    PUSH AX
    PUSH CX
    PUSH SI
    PUSH DI
    
COPY_LOOP:
    MOV AL, [DI]
    MOV [SI], AL
    INC SI
    INC DI
    LOOP COPY_LOOP
    
    POP DI
    POP SI
    POP CX
    POP AX
    RET
COPY_MEMORY ENDP

COMPARE_MEMORY PROC
    PUSH AX
    PUSH CX
    PUSH SI
    PUSH DI
    
COMPARE_LOOP:
    MOV AL, [SI]
    CMP AL, [DI]
    JNE COMPARE_NOT_EQUAL
    INC SI
    INC DI
    LOOP COMPARE_LOOP
    
    CMP AL, AL
    JMP COMPARE_END
    
COMPARE_NOT_EQUAL:
    CMP AL, AL
    INC AL
    
COMPARE_END:
    POP DI
    POP SI
    POP CX
    POP AX
    RET
COMPARE_MEMORY ENDP

END MAIN
