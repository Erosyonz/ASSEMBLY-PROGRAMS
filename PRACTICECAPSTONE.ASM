.MODEL SMALL
.STACK 100H

.DATA
    ; System Information
    system_name DB 'CITU Library Management System', 13, 10, '$'
    programmer DB 'Programmer: [Your Name Here]', 13, 10, '$'
    date_created DB 'Date: December 2025', 13, 10, 13, 10, '$'
    welcome_msg DB 'Welcome to Library Management System!', 13, 10, '$'
    press_key DB 13, 10, 'Press any key to continue...$'
    
    ; Menu Options
    main_menu DB 13, 10, 'MAIN MENU:', 13, 10
              DB '1. Register New User', 13, 10
              DB '2. Login', 13, 10
              DB '3. Exit', 13, 10
              DB 'Choose option: $'
    
    user_menu DB 13, 10, 'USER MENU:', 13, 10
              DB '1. Add Book', 13, 10
              DB '2. View Books', 13, 10
              DB '3. Update Book', 13, 10
              DB '4. Delete Book', 13, 10
              DB '5. Logout', 13, 10
              DB 'Choose option: $'
    
    ; Screen Headers
    register_msg DB 13, 10, '--- REGISTER NEW USER ---', 13, 10, '$'
    login_msg DB 13, 10, '--- USER LOGIN ---', 13, 10, '$'
    add_book_msg DB 13, 10, '--- ADD NEW BOOK ---', 13, 10, '$'
    view_books_msg DB 13, 10, '--- VIEW ALL BOOKS ---', 13, 10, '$'
    update_book_msg DB 13, 10, '--- UPDATE BOOK ---', 13, 10, '$'
    delete_book_msg DB 13, 10, '--- DELETE BOOK ---', 13, 10, '$'
    
    ; Input Prompts
    username_prompt DB 13, 10, 'Enter username: $'
    password_prompt DB 13, 10, 'Enter password: $'
    book_id_prompt DB 13, 10, 'Enter book ID: $'
    book_title_prompt DB 13, 10, 'Enter book title: $'
    book_author_prompt DB 13, 10, 'Enter book author: $'
    book_year_prompt DB 13, 10, 'Enter publication year: $'
    
    ; Success Messages
    reg_success DB 13, 10, 'User registered successfully!$'
    login_success DB 13, 10, 'Login successful!$'
    add_success DB 13, 10, 'Book added successfully!$'
    update_success DB 13, 10, 'Book updated successfully!$'
    delete_success DB 13, 10, 'Book deleted successfully!$'
    
    ; Error Messages
    invalid_choice DB 13, 10, 'Invalid choice! Please try again.$'
    login_failed DB 13, 10, 'Login failed! Invalid credentials.$'
    not_found DB 13, 10, 'Book not found!$'
    no_books DB 13, 10, 'No books available!$'
    logout_msg DB 13, 10, 'Logging out...$'
    exit_msg DB 13, 10, 'Thank you for using Library Management System!$'
    
    ; Data Storage
    username DB 20 DUP('$')
    password DB 20 DUP('$')
    book_id DB 5 DUP('$')
    book_title DB 30 DUP('$')
    book_author DB 30 DUP('$')
    book_year DB 5 DUP('$')
    
    ; Counters and Flags
    user_count DB 0
    book_count DB 0
    current_user DB 0
    input DB 2 DUP('$')

.CODE
.STARTUP

; =============================================
; MAIN PROGRAM START
; =============================================
MAIN PROC FAR
    CALL CLEAR_SCREEN
    CALL OPENING_SCREEN
    
MAIN_LOOP:
    CALL MAIN_MENU_SCREEN
    JMP MAIN_LOOP
MAIN ENDP

; =============================================
; OPENING SCREEN FUNCTION
; =============================================
OPENING_SCREEN PROC NEAR
    MOV AH, 09H
    LEA DX, system_name
    INT 21H
    
    LEA DX, programmer
    INT 21H
    
    LEA DX, date_created
    INT 21H
    
    LEA DX, welcome_msg
    INT 21H
    
    LEA DX, press_key
    INT 21H
    
    CALL WAIT_KEY
    RET
OPENING_SCREEN ENDP

; =============================================
; CLEAR SCREEN FUNCTION
; =============================================
CLEAR_SCREEN PROC NEAR
    MOV AX, 0600H    ; Scroll window up
    MOV BH, 07H      ; Normal attribute
    MOV CX, 0000H    ; Upper left corner
    MOV DX, 184FH    ; Lower right corner
    INT 10H
    
    ; Set cursor position to top
    MOV AH, 02H
    MOV BH, 00H
    MOV DX, 0000H
    INT 10H
    RET
CLEAR_SCREEN ENDP

; =============================================
; MAIN MENU SCREEN FUNCTION
; =============================================
MAIN_MENU_SCREEN PROC NEAR
    CALL CLEAR_SCREEN
    
    MOV AH, 09H
    LEA DX, main_menu
    INT 21H
    
    CALL READ_INPUT
    
    CMP input, '1'
    JE REGISTER_SCREEN
    CMP input, '2'
    JE LOGIN_SCREEN
    CMP input, '3'
    JE EXIT_PROGRAM
    
    ; Invalid choice
    MOV AH, 09H
    LEA DX, invalid_choice
    INT 21H
    CALL WAIT_KEY
    RET
    
REGISTER_SCREEN:
    CALL REGISTER_USER
    RET
    
LOGIN_SCREEN:
    CALL LOGIN_USER
    RET
MAIN_MENU_SCREEN ENDP

; =============================================
; REGISTER USER FUNCTION
; =============================================
REGISTER_USER PROC NEAR
    CALL CLEAR_SCREEN
    
    MOV AH, 09H
    LEA DX, register_msg
    INT 21H
    
    ; Get username
    LEA DX, username_prompt
    INT 21H
    CALL READ_STRING
    ; Store username (simplified - in real app, save to user array)
    
    ; Get password
    LEA DX, password_prompt
    INT 21H
    CALL READ_STRING
    ; Store password (simplified - in real app, save to user array)
    
    ; Increment user count
    INC user_count
    
    MOV AH, 09H
    LEA DX, reg_success
    INT 21H
    
    CALL WAIT_KEY
    RET
REGISTER_USER ENDP

; =============================================
; LOGIN USER FUNCTION
; =============================================
LOGIN_USER PROC NEAR
    CALL CLEAR_SCREEN
    
    MOV AH, 09H
    LEA DX, login_msg
    INT 21H
    
    ; Get username
    LEA DX, username_prompt
    INT 21H
    CALL READ_STRING
    
    ; Get password
    LEA DX, password_prompt
    INT 21H
    CALL READ_STRING
    
    ; Simple login validation (always successful for demo)
    MOV current_user, 1
    
    MOV AH, 09H
    LEA DX, login_success
    INT 21H
    CALL WAIT_KEY
    
    CALL USER_DASHBOARD
    RET
LOGIN_USER ENDP

; =============================================
; USER DASHBOARD FUNCTION
; =============================================
USER_DASHBOARD PROC NEAR
USER_LOOP:
    CALL CLEAR_SCREEN
    MOV AH, 09H
    LEA DX, user_menu
    INT 21H
    
    CALL READ_INPUT
    
    CMP input, '1'
    JE CREATE_BOOK
    CMP input, '2'
    JE READ_BOOKS
    CMP input, '3'
    JE UPDATE_BOOK
    CMP input, '4'
    JE DELETE_BOOK
    CMP input, '5'
    JE LOGOUT_USER
    
    ; Invalid choice
    MOV AH, 09H
    LEA DX, invalid_choice
    INT 21H
    CALL WAIT_KEY
    JMP USER_LOOP

CREATE_BOOK:
    CALL ADD_BOOK
    JMP USER_LOOP
    
READ_BOOKS:
    CALL VIEW_BOOKS
    JMP USER_LOOP
    
UPDATE_BOOK:
    CALL UPDATE_BOOK_RECORD
    JMP USER_LOOP
    
DELETE_BOOK:
    CALL DELETE_BOOK_RECORD
    JMP USER_LOOP
    
LOGOUT_USER:
    CALL LOGOUT
    RET
USER_DASHBOARD ENDP

; =============================================
; ADD BOOK FUNCTION (CREATE)
; =============================================
ADD_BOOK PROC NEAR
    CALL CLEAR_SCREEN
    
    MOV AH, 09H
    LEA DX, add_book_msg
    INT 21H
    
    ; Get book ID
    LEA DX, book_id_prompt
    INT 21H
    CALL READ_STRING
    
    ; Get book title
    LEA DX, book_title_prompt
    INT 21H
    CALL READ_STRING
    
    ; Get book author
    LEA DX, book_author_prompt
    INT 21H
    CALL READ_STRING
    
    ; Get publication year
    LEA DX, book_year_prompt
    INT 21H
    CALL READ_STRING
    
    ; Increment book count
    INC book_count
    
    MOV AH, 09H
    LEA DX, add_success
    INT 21H
    
    CALL WAIT_KEY
    RET
ADD_BOOK ENDP

; =============================================
; VIEW BOOKS FUNCTION (READ)
; =============================================
VIEW_BOOKS PROC NEAR
    CALL CLEAR_SCREEN
    
    MOV AH, 09H
    LEA DX, view_books_msg
    INT 21H
    
    ; Check if there are any books
    CMP book_count, 0
    JNE DISPLAY_BOOKS
    
    LEA DX, no_books
    INT 21H
    JMP END_VIEW

DISPLAY_BOOKS:
    ; Display sample book list (in real app, loop through book array)
    MOV AH, 02H
    MOV DL, 13
    INT 21H
    MOV DL, 10
    INT 21H
    
    MOV AH, 09H
    LEA DX, sample_book1
    INT 21H
    
    LEA DX, sample_book2
    INT 21H
    
    LEA DX, sample_book3
    INT 21H

END_VIEW:
    CALL WAIT_KEY
    RET
    
    sample_book1 DB '1. CS243 Textbook - Dr. Smith (2025)', 13, 10, '$'
    sample_book2 DB '2. Assembly Programming - Jane Doe (2024)', 13, 10, '$'
    sample_book3 DB '3. Data Structures - John Adams (2023)', 13, 10, '$'
VIEW_BOOKS ENDP

; =============================================
; UPDATE BOOK FUNCTION
; =============================================
UPDATE_BOOK_RECORD PROC NEAR
    CALL CLEAR_SCREEN
    
    MOV AH, 09H
    LEA DX, update_book_msg
    INT 21H
    
    ; Get book ID to update
    LEA DX, book_id_prompt
    INT 21H
    CALL READ_STRING
    
    ; Check if books exist
    CMP book_count, 0
    JE BOOK_NOT_FOUND
    
    ; Simulate update process
    MOV AH, 09H
    LEA DX, update_success
    INT 21H
    JMP END_UPDATE

BOOK_NOT_FOUND:
    LEA DX, not_found
    INT 21H

END_UPDATE:
    CALL WAIT_KEY
    RET
UPDATE_BOOK_RECORD ENDP

; =============================================
; DELETE BOOK FUNCTION
; =============================================
DELETE_BOOK_RECORD PROC NEAR
    CALL CLEAR_SCREEN
    
    MOV AH, 09H
    LEA DX, delete_book_msg
    INT 21H
    
    ; Get book ID to delete
    LEA DX, book_id_prompt
    INT 21H
    CALL READ_STRING
    
    ; Check if books exist
    CMP book_count, 0
    JE DELETE_NOT_FOUND
    
    ; Decrement book count
    DEC book_count
    
    MOV AH, 09H
    LEA DX, delete_success
    INT 21H
    JMP END_DELETE

DELETE_NOT_FOUND:
    LEA DX, not_found
    INT 21H

END_DELETE:
    CALL WAIT_KEY
    RET
DELETE_BOOK_RECORD ENDP

; =============================================
; LOGOUT FUNCTION
; =============================================
LOGOUT PROC NEAR
    MOV current_user, 0
    MOV AH, 09H
    LEA DX, logout_msg
    INT 21H
    CALL WAIT_KEY
    RET
LOGOUT ENDP

; =============================================
; EXIT PROGRAM FUNCTION
; =============================================
EXIT_PROGRAM PROC NEAR
    CALL CLEAR_SCREEN
    MOV AH, 09H
    LEA DX, exit_msg
    INT 21H
    
    ; Exit to DOS
    MOV AH, 4CH
    INT 21H
EXIT_PROGRAM ENDP

; =============================================
; HELPER FUNCTIONS
; =============================================

; Read single character input
READ_INPUT PROC NEAR
    MOV AH, 01H
    INT 21H
    MOV input, AL
    RET
READ_INPUT ENDP

; Read string input
READ_STRING PROC NEAR
    MOV AH, 0AH
    ; For simplicity, using predefined buffers
    ; In real implementation, you'd set up proper buffer structure
    INT 21H
    RET
READ_STRING ENDP

; Wait for key press
WAIT_KEY PROC NEAR
    MOV AH, 09H
    LEA DX, press_key
    INT 21H
    MOV AH, 07H
    INT 21H
    RET
WAIT_KEY ENDP

END