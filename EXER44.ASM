; Filename: EXER44.ASM
; Programmer: DELA PENA, ALLEAH I.
; Date: October 26, 2025
; Description: Create an Assembly Language program to display a main menu that
; lets users choose which 2025 calender.

.MODEL SMALL
.STACK 100H

.DATA
    ; Menu display
    menu_title      DB "2025 Calendar                      $"
    programmer      DB "Programmer: ALLEAH DELA PENA       $"
    date_finished   DB "Date Finished: October 26, 2025    $"
    main_menu_text  DB "Main Menu                          $"
    separator       DB "___________________________________$"
    menu_line1      DB "|1 January |5 May    |9 September |$"
    menu_line2      DB "|2 February|6 June   |10 October  |$"
    menu_line3      DB "|3 March   |7 July   |11 November |$"
    menu_line4      DB "|4 April   |8 August |12 December |$"
    enter_choice    DB "Enter Choice: $"
    
    ; Messages
    invalid_msg     DB "INVALID ENTRY!$"
    again_msg       DB "Again? Y/N: $"
    thanks_msg      DB "Thank you. Come back soon.$"
   
    
    ; Month names (each exactly 9 characters)
    month_names DB "January  February March    April    May      June     July     August   SeptemberOctober  November December $"
    
    ; Calendar data for 2025 (first day: 0=Sunday, 1=Monday, etc.)
    ; January 1, 2025 is Wednesday (3)
    first_days DB 3, 6, 6, 2, 4, 0, 2, 5, 1, 3, 6, 1
    month_days DB 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
    
    ; Colors for each month (attribute bytes)
    ; 1Fh = Blue background, White text (like your image)
    month_colors DB 1Fh, 2Eh, 3Eh, 4Eh, 5Eh, 6Eh, 7Eh, 1Fh, 2Fh, 3Fh, 4Fh, 5Fh
    
    ; Calendar grid
    grid_top    DB "+-----------------------------------------+$"
    grid_header DB "| S   | M   | T   | W   | T   | F   | S   |$"
    grid_middle DB "|-----+-----+-----+-----+-----+-----+-----|$"
    grid_bottom DB "+-----------------------------------------+$"
    
    ; Input buffer
    input_buffer DB 5, 0, 5 DUP('$')
    
    ; Output buffers
    num_buffer DB '    $'  ; 4 characters for proper spacing
    empty_cell DB '    $'  ; 4 spaces for empty cells
    newline_db DB 13, 10, '$'

    ; Variables
    current_month DB 0
    days_in_month DB 0
    start_day DB 0
    current_date DB 1
    row_pos DB 0
    day_of_week DB 0
    current_color DB 0

.CODE

; -----------------------
; Main Program
; -----------------------
START:
    MOV AX, @DATA
    MOV DS, AX
    
MAIN_LOOP:
    CALL DISPLAY_MAIN_MENU
    CALL GET_USER_CHOICE
    CMP AL, 0
    JE INVALID_CHOICE
    
    ; Valid month selected
    MOV current_month, AL
    DEC current_month    ; convert to 0-based
    
    ; Display calendar below the menu (no clear screen)
    CALL DISPLAY_CALENDAR
    
    JMP ASK_AGAIN

INVALID_CHOICE:
    ; Show invalid message below the menu (no clear screen)
    CALL SHOW_INVALID_MESSAGE
    JMP ASK_AGAIN
    
ASK_AGAIN:
    ; Move to next line after calendar or invalid message
    
    
    CALL NEW_LINE
    MOV DX, OFFSET again_msg
    MOV AH, 09H
    INT 21H
    
    ; Get Y/N input
    MOV AH, 01H
    INT 21H
    
    ; Convert to uppercase and check
    CMP AL, 'y'
    JE YES_PRESSED
    CMP AL, 'Y'
    JE YES_PRESSED
    CMP AL, 'n'
    JE NO_PRESSED
    CMP AL, 'N'
    JE NO_PRESSED
    
    ; Invalid input for Y/N - show error and ask again
    
    CALL SHOW_INVALID_MESSAGE
    
    JMP ASK_AGAIN

YES_PRESSED:
    CALL CLEAR_SCREEN
    JMP MAIN_LOOP

NO_PRESSED:
    CALL NEW_LINE
    
    MOV DX, OFFSET thanks_msg
    MOV AH, 09H
    INT 21H
    
    ; Wait for key press before exiting
    MOV AH, 01H
    INT 21H
    
    ; Exit to DOS
    MOV AH, 4CH
    INT 21H

; -----------------------
; Display Main Menu
; -----------------------
DISPLAY_MAIN_MENU PROC
    CALL CLEAR_SCREEN
    
    ; Display all menu items
    MOV DH, 0
    MOV DL, 0
    CALL SET_CURSOR
    MOV DX, OFFSET menu_title
    CALL PRINT_STRING
    
    MOV DH, 1
    MOV DL, 0
    CALL SET_CURSOR
    MOV DX, OFFSET programmer
    CALL PRINT_STRING
    
    MOV DH, 2
    MOV DL, 0
    CALL SET_CURSOR
    MOV DX, OFFSET date_finished
    CALL PRINT_STRING
    
    MOV DH, 3
    MOV DL, 0
    CALL SET_CURSOR
    MOV DX, OFFSET main_menu_text
    CALL PRINT_STRING
    
    MOV DH, 4
    MOV DL, 0
    CALL SET_CURSOR
    MOV DX, OFFSET separator
    CALL PRINT_STRING
    
    MOV DH, 5
    MOV DL, 0
    CALL SET_CURSOR
    MOV DX, OFFSET menu_line1
    CALL PRINT_STRING
    
    MOV DH, 6
    MOV DL, 0
    CALL SET_CURSOR
    MOV DX, OFFSET menu_line2
    CALL PRINT_STRING
    
    MOV DH, 7
    MOV DL, 0
    CALL SET_CURSOR
    MOV DX, OFFSET menu_line3
    CALL PRINT_STRING
    
    MOV DH, 8
    MOV DL, 0
    CALL SET_CURSOR
    MOV DX, OFFSET menu_line4
    CALL PRINT_STRING
    
    MOV DH, 9
    MOV DL, 0
    CALL SET_CURSOR
    MOV DX, OFFSET separator
    CALL PRINT_STRING
    
    MOV DH, 10
    MOV DL, 0
    CALL SET_CURSOR
    MOV DX, OFFSET enter_choice
    CALL PRINT_STRING
    
    RET
DISPLAY_MAIN_MENU ENDP

; -----------------------
; Get User Choice
; -----------------------
GET_USER_CHOICE PROC
    ; Use DOS buffered input
    MOV DX, OFFSET input_buffer
    MOV AH, 0AH
    INT 21H
    
    ; Check if input is empty
    MOV CL, input_buffer + 1
    CMP CL, 0
    JE INVALID_INPUT
    
    ; Convert ASCII to number
    MOV SI, OFFSET input_buffer + 2
    MOV AX, 0
    
CONVERT_DIGITS:
    MOV BL, [SI]
    CMP BL, 0DH        ; Check for carriage return
    JE CHECK_VALID_RANGE
    CMP BL, '0'
    JB INVALID_INPUT
    CMP BL, '9'
    JA INVALID_INPUT
    
    ; Convert digit and add to total
    SUB BL, '0'
    MOV BH, 0
    
    ; AX = AX * 10 + BX
    MOV CX, 10
    MUL CX
    ADD AX, BX
    
    INC SI
    JMP CONVERT_DIGITS

CHECK_VALID_RANGE:
    ; Check if number is 1-12
    CMP AX, 1
    JB INVALID_INPUT
    CMP AX, 12
    JA INVALID_INPUT
    
    ; Valid number (low byte already in AL)
    RET

INVALID_INPUT:
    MOV AL, 0
    RET
GET_USER_CHOICE ENDP

; -----------------------
; Show Invalid Message with Blinking Red Background and Yellow Text
; -----------------------
SHOW_INVALID_MESSAGE PROC
    
    ; Set cursor for invalid message
    MOV AH, 03H
    INT 10H
    INC DH
    MOV DL, 0
    CALL SET_CURSOR
    
    ; Print "INVALID ENTRY!" with blinking red background and yellow text
    MOV SI, OFFSET invalid_msg
    MOV BL, 0CEh   ; Attribute: blinking red background, yellow text
    
PRINT_BLINKING_LOOP:
    MOV AL, [SI]
    CMP AL, '$'
    JE END_BLINKING
    
    ; Print character with blinking red background and yellow text
    MOV AH, 09H
    MOV BH, 0
    MOV CX, 1
    INT 10H
    
    ; Move cursor forward
    MOV AH, 03H
    INT 10H
    INC DL
    MOV AH, 02H
    INT 10H
    
    INC SI
    JMP PRINT_BLINKING_LOOP

END_BLINKING:
    RET
SHOW_INVALID_MESSAGE ENDP

; -----------------------
; Display Calendar with Colors - MODIFIED TO DISPLAY BELOW ENTER CHOICE
; -----------------------
DISPLAY_CALENDAR PROC
    ; Get month index
    MOV BL, current_month
    MOV BH, 0
    
    ; Get month color (1Fh = Blue background, White foreground)
    MOV SI, OFFSET month_colors
    ADD SI, BX
    MOV BL, [SI]  ; BL now has color attribute
    MOV current_color, BL
    
    ; Move cursor to next line after "Enter Choice:" input
    CALL NEW_LINE
    
    
    ; Display month name and year WITHOUT color
    CALL DISPLAY_MONTH_NAME
    
    ; Display " 2025" after month name
    MOV DL, ' '
    CALL PRINT_CHAR
    MOV DL, '2'
    CALL PRINT_CHAR
    MOV DL, '0'
    CALL PRINT_CHAR
    MOV DL, '2'
    CALL PRINT_CHAR
    MOV DL, '5'
    CALL PRINT_CHAR
    
    CALL NEW_LINE
    
    
    ; Display calendar grid using loops WITH color
    CALL DISPLAY_GRID_BORDERS
    
    ; Display dates using loops WITH color
    CALL DISPLAY_MONTH_DATES
    
    RET
DISPLAY_CALENDAR ENDP

; -----------------------
; Display Month Name (without color)
; -----------------------
DISPLAY_MONTH_NAME PROC
    MOV AL, current_month
    MOV BL, 9
    MUL BL
    MOV SI, OFFSET month_names
    ADD SI, AX
    
    ; Print month name character by character using loop WITHOUT color
    MOV CX, 9
PRINT_NAME_LOOP:
    MOV DL, [SI]
    CALL PRINT_CHAR
    INC SI
    LOOP PRINT_NAME_LOOP
    
    RET
DISPLAY_MONTH_NAME ENDP

; -----------------------
; Display Grid Borders using Loops WITH COLOR
; -----------------------
DISPLAY_GRID_BORDERS PROC
    ; Display top border with color
    MOV DX, OFFSET grid_top
    CALL PRINT_STRING_WITH_COLOR
    CALL NEW_LINE
    
    ; Display header with color
    MOV DX, OFFSET grid_header
    CALL PRINT_STRING_WITH_COLOR
    CALL NEW_LINE
    
    ; Display middle border with color
    MOV DX, OFFSET grid_middle
    CALL PRINT_STRING_WITH_COLOR
    CALL NEW_LINE
    
    RET
DISPLAY_GRID_BORDERS ENDP

; -----------------------
; Display Month Dates using Nested Loops WITH COLOR - FIXED EMPTY CELLS
; -----------------------
DISPLAY_MONTH_DATES PROC
    ; Get month data
    MOV BL, current_month
    MOV BH, 0
    
    MOV SI, OFFSET first_days
    ADD SI, BX
    MOV AL, [SI]
    MOV start_day, AL      ; Starting day (0=Sun, 1=Mon, ..., 6=Sat)
    
    MOV SI, OFFSET month_days
    ADD SI, BX
    MOV AL, [SI]
    MOV days_in_month, AL
    
    MOV current_date, 1
    ; row_pos will be set dynamically based on current cursor position
    MOV day_of_week, 0     ; Start with Sunday (0)
    
    ; Get current cursor position to continue from there
    MOV AH, 03H
    INT 10H
    MOV row_pos, DH
    
    ; 6 weeks maximum - outer loop
    MOV CX, 6
    
WEEK_LOOP:
    PUSH CX
    
    ; Position cursor at start of week row
    MOV DH, row_pos
    MOV DL, 0
    CALL SET_CURSOR
    
    ; Left border with color
    MOV DL, '|'
    CALL PRINT_CHAR_WITH_COLOR
    
    ; 7 days per week - inner loop
    MOV CX, 7
    
DAY_LOOP:
    PUSH CX
    
    ; Check if we're before the start day or after the end of month
    MOV AL, day_of_week
    CMP AL, start_day
    JB BEFORE_START_DAY
    
    MOV AL, current_date
    CMP AL, days_in_month
    JA AFTER_END_MONTH
    
    ; Display the current date with color
    MOV AL, current_date
    CALL FORMAT_NUMBER
    MOV DX, OFFSET num_buffer
    CALL PRINT_STRING_WITH_COLOR
    INC current_date
    JMP NEXT_CELL

BEFORE_START_DAY:
    ; Show empty cell before the month starts with color - USE EMPTY_CELL BUFFER
    MOV DX, OFFSET empty_cell
    CALL PRINT_STRING_WITH_COLOR
    JMP NEXT_CELL

AFTER_END_MONTH:
    ; Show empty cell after the month ends with color - USE EMPTY_CELL BUFFER
    MOV DX, OFFSET empty_cell
    CALL PRINT_STRING_WITH_COLOR
    JMP NEXT_CELL

NEXT_CELL:
    ; Cell separator with color
    MOV DL, ' '
    CALL PRINT_CHAR_WITH_COLOR
    MOV DL, '|'
    CALL PRINT_CHAR_WITH_COLOR
    
    ; Move to next day of week
    INC day_of_week
    
    POP CX
    LOOP DAY_LOOP
    
    CALL NEW_LINE
    
    ; Next row - increment row position
    INC row_pos
    POP CX
    LOOP WEEK_LOOP
    
    ; Display bottom border with color
    MOV DX, OFFSET grid_bottom
    CALL PRINT_STRING_WITH_COLOR
    CALL NEW_LINE
    
    RET
DISPLAY_MONTH_DATES ENDP

; -----------------------
; Format Number (1-31 with CORRECT spacing)
; -----------------------
FORMAT_NUMBER PROC
    ; Input: AL = number (1-31)
    PUSH AX
    PUSH BX
    
    ; Clear the buffer first to avoid garbage values
    MOV num_buffer[0], ' '
    MOV num_buffer[1], ' '
    MOV num_buffer[2], ' '
    MOV num_buffer[3], ' '
    
    CMP AL, 10
    JB SINGLE_DIGIT
    
    ; Two-digit number - ONE space before (matching lab samples)
    MOV AH, 0
    MOV BL, 10
    DIV BL      ; AL = tens, AH = ones
    
    ADD AL, '0'
    ADD AH, '0'
    MOV num_buffer[0], ' '  ; One space for two-digit numbers
    MOV num_buffer[1], AL
    MOV num_buffer[2], AH
    MOV num_buffer[3], ' '  ; Space after
    JMP DONE_FORMAT

SINGLE_DIGIT:
    ; Single digit - TWO spaces before (matching lab samples)
    MOV num_buffer[0], ' '  ; First space
    MOV num_buffer[1], ' '  ; Second space for single-digit numbers
    ADD AL, '0'
    MOV num_buffer[2], AL
    MOV num_buffer[3], ' '  ; Space after

DONE_FORMAT:
    POP BX
    POP AX
    RET
FORMAT_NUMBER ENDP

; -----------------------
; Color Printing Functions (SIMPLIFIED)
; -----------------------
PRINT_STRING_WITH_COLOR PROC
    PUSH SI
    PUSH AX
    PUSH BX
    PUSH CX
    
    MOV SI, DX
    
PRINT_LOOP:
    MOV AL, [SI]
    CMP AL, '$'
    JE END_PRINT
    
    ; Print character with color
    MOV AH, 09H
    MOV BH, 0
    MOV BL, current_color
    MOV CX, 1
    INT 10H
    
    ; Move cursor forward
    MOV AH, 03H
    INT 10H
    INC DL
    MOV AH, 02H
    INT 10H
    
    INC SI
    JMP PRINT_LOOP

END_PRINT:
    POP CX
    POP BX
    POP AX
    POP SI
    RET
PRINT_STRING_WITH_COLOR ENDP

PRINT_CHAR_WITH_COLOR PROC
    PUSH AX
    PUSH BX
    PUSH CX
    
    ; Print character with color
    MOV AH, 09H
    MOV AL, DL
    MOV BH, 0
    MOV BL, current_color
    MOV CX, 1
    INT 10H
    
    ; Move cursor forward
    MOV AH, 03H
    INT 10H
    INC DL
    MOV AH, 02H
    INT 10H
    
    POP CX
    POP BX
    POP AX
    RET
PRINT_CHAR_WITH_COLOR ENDP

; -----------------------
; Utility Functions
; -----------------------
CLEAR_SCREEN PROC
    MOV AX, 0003H
    INT 10H
    RET
CLEAR_SCREEN ENDP

SET_CURSOR PROC
    MOV BH, 0
    MOV AH, 02H
    INT 10H
    RET
SET_CURSOR ENDP

PRINT_STRING PROC
    MOV AH, 09H
    INT 21H
    RET
PRINT_STRING ENDP

PRINT_CHAR PROC
    MOV AH, 02H
    INT 21H
    RET
PRINT_CHAR ENDP

NEW_LINE PROC
    MOV DX, OFFSET newline_db
    CALL PRINT_STRING
    RET
NEW_LINE ENDP

END START