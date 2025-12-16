.model small
.stack 100h
 
.data
    ; Header strings
    header1 db 'CIT-U BANK$'
    header2 db 'Automatic Teller Machine$'
    header3 db 'Copyright 2025$'
    header4 db 'Programmer: ALLEAH DELA PENA$'
    welcome_msg db 'Welcome!$'
   
    ; PIN related strings
    insert_card db 'Please insert your card.$'
    enter_pin db 'Enter your PIN: $'
    wrong_pin db 'WRONG PIN!$'
    correct_pin db '1234$'
   
    ; Main menu strings
    main_menu_title db 'MAIN MENU$'
    menu1 db '1 Balance Inquiry$'
    menu2 db '2 Deposit$'
    menu3 db '3 Withdraw$'
    menu4 db '4 Pay Bills$'
    menu5 db '5 Exit$'
    enter_choice db 'Please enter number of your choice: $'
    wrong_choice db 'WRONG CHOICE$'
   
    ; Option screens
    balance_inquiry db 'BALANCE INQUIRY$'
    deposit_msg db 'DEPOSIT$'
    withdraw_msg db 'WITHDRAW$'
    pay_bills db 'PAY BILLS$'
    exit_msg db 'EXIT$'
    continue_msg db 'Continue? Y/N: $'
    thank_you db 'Please get your card. Thank you.$'
   
    ; Input buffers
    pin_buffer db 5, 0, 5 dup(0)
    choice_buffer db 2, 0, 2 dup(0)
    continue_buffer db 2, 0, 2 dup(0)
 
.code
main proc
    mov ax, @data
    mov ds, ax
   
    ; Set video mode
    mov ax, 0003h
    int 10h
   
    ; Set color - red background, yellow text
    mov ax, 0600h
    mov bh, 4Eh
    mov cx, 0000h
    mov dx, 184Fh
    int 10h
   
    ; Position cursor
    mov ah, 02h
    mov bh, 00h
    mov dx, 0000h
    int 10h
   
    call show_welcome_screen
   
    ; PIN verification
    call get_and_verify_pin
    cmp ax, 1
    jne program_end
   
    ; Main program loop
    call main_menu_loop
   
program_end:
    mov ah, 08h
    int 21h
   
    mov ah, 4Ch
    int 21h
main endp
 
show_welcome_screen proc
    mov dx, offset header1
    call print_string
    call new_line
   
    mov dx, offset header2
    call print_string
    call new_line
   
    mov dx, offset header3
    call print_string
    call new_line
   
    mov dx, offset header4
    call print_string
    call new_line
    call new_line
   
    mov dx, offset welcome_msg
    call print_string
    call new_line
    call new_line
   
    mov dx, offset insert_card
    call print_string
    call new_line
    ret
show_welcome_screen endp
 
get_and_verify_pin proc
    mov dx, offset enter_pin
    call print_string
   
    ; Get PIN input
    mov dx, offset pin_buffer
    mov ah, 0Ah
    int 21h
   
    call new_line
    call new_line
   
    ; Verify PIN
    mov si, offset correct_pin
    mov di, offset pin_buffer + 2
    mov cx, 4
   
check_pin:
    mov al, [si]
    mov bl, [di]
    cmp al, bl
    jne pin_invalid
    inc si
    inc di
    loop check_pin
   
    ; Check length
    mov al, [pin_buffer + 1]
    cmp al, 4
    jne pin_invalid
   
    mov ax, 1
    ret
   
pin_invalid:
    ; Display blinking error message
    mov dx, offset wrong_pin
    call print_blinking_error
    call new_line
    mov ax, 0
    ret
get_and_verify_pin endp
 
main_menu_loop proc
menu_start:
    call clear_screen
    call show_header
    call show_menu
   
    ; Get choice
    mov dx, offset enter_choice
    call print_string
   
    mov dx, offset choice_buffer
    mov ah, 0Ah
    int 21h
   
    call new_line
    call new_line
   
    ; Process choice
    mov al, [choice_buffer + 2]
   
    cmp al, '1'
    je option1
    cmp al, '2'
    je option2
    cmp al, '3'
    je option3
    cmp al, '4'
    je option4
    cmp al, '5'
    je option5
   
    ; Invalid choice - show with blinking error
    mov dx, offset wrong_choice
    call print_blinking_error
    call new_line
    call wait_keypress
    jmp menu_start
 
option1:
    call show_option_screen_below
    mov dx, offset balance_inquiry
    call print_string
    call new_line
    call new_line
    call continue_prompt
    jmp menu_start
 
option2:
    call show_option_screen_below
    mov dx, offset deposit_msg
    call print_string
    call new_line
    call new_line
    call continue_prompt
    jmp menu_start
 
option3:
    call show_option_screen_below
    mov dx, offset withdraw_msg
    call print_string
    call new_line
    call new_line
    call continue_prompt
    jmp menu_start
 
option4:
    call show_option_screen_below
    mov dx, offset pay_bills
    call print_string
    call new_line
    call new_line
    call continue_prompt
    jmp menu_start
 
option5:
    call show_option_screen_below
    mov dx, offset exit_msg
    call print_string
    call new_line
    call new_line
    mov dx, offset thank_you
    call print_string
    call new_line
    call wait_keypress
    ret
main_menu_loop endp
 
show_header proc
    mov dx, offset header1
    call print_string
    call new_line
   
    mov dx, offset header2
    call print_string
    call new_line
   
    mov dx, offset header3
    call print_string
    call new_line
   
    mov dx, offset header4
    call print_string
    call new_line
    call new_line
   
    mov dx, offset welcome_msg
    call print_string
    call new_line
    ret
show_header endp
 
show_menu proc
    mov dx, offset main_menu_title
    call print_string
    call new_line
   
    mov dx, offset menu1
    call print_string
    call new_line
   
    mov dx, offset menu2
    call print_string
    call new_line
   
    mov dx, offset menu3
    call print_string
    call new_line
   
    mov dx, offset menu4
    call print_string
    call new_line
   
    mov dx, offset menu5
    call print_string
    call new_line
    call new_line
    ret
show_menu endp

; NEW PROCEDURE: Show option screen below main menu (no clear screen)
show_option_screen_below proc
    ; Move cursor below the menu (around row 15-16)
    mov ah, 02h
    mov bh, 00h
    mov dh, 15    ; Row 15
    mov dl, 00    ; Column 0
    int 10h
    
    ; Clear only the area below the menu for the option screen
    mov ax, 0600h
    mov bh, 4Eh    ; Red background, yellow text
    mov ch, 15     ; Start row
    mov cl, 0      ; Start column
    mov dh, 24     ; End row
    mov dl, 79     ; End column
    int 10h
    
    ; Reset cursor to the cleared area
    mov ah, 02h
    mov bh, 00h
    mov dh, 15     ; Row 15
    mov dl, 00     ; Column 0
    int 10h
    ret
show_option_screen_below endp
 
; OLD PROCEDURE (keep for reference but not used)
show_option_screen proc
    call clear_screen
    call show_header
    ret
show_option_screen endp
 
continue_prompt proc
    mov dx, offset continue_msg
    call print_string
   
    ; Get response
    mov dx, offset continue_buffer
    mov ah, 0Ah
    int 21h
   
    call new_line
   
    mov al, [continue_buffer + 2]
    and al, 0DFh  ; Convert to uppercase
    cmp al, 'Y'
    je cont_yes
    cmp al, 'N'
    je cont_no
    
    ; Invalid input - show error and ask again
    call new_line
    mov dx, offset wrong_choice
    call print_blinking_error
    call new_line
    call wait_keypress
    call show_option_screen_below  ; Clear the area and show prompt again
    mov dx, offset continue_msg
    call print_string
    jmp continue_prompt
   
cont_no:
    ; Show thank you message below without clearing screen
    call new_line
    mov dx, offset thank_you
    call print_string
    call new_line
    call wait_keypress
    mov ah, 4Ch
    int 21h
   
cont_yes:
    ret
continue_prompt endp
 
clear_screen proc
    mov ax, 0600h
    mov bh, 4Eh
    mov cx, 0000h
    mov dx, 184Fh
    int 10h
   
    mov ah, 02h
    mov bh, 00h
    mov dx, 0000h
    int 10h
    ret
clear_screen endp
 
; New procedure to print blinking error messages
print_blinking_error proc
    push ax
    push bx
    push cx
    push dx
    push si
   
    mov si, dx  ; SI points to the string
   
    ; Get current cursor position
    mov ah, 03h
    mov bh, 00h
    int 10h
    push dx     ; Save cursor position
   
    ; Print each character with blinking attribute
print_char:
    mov al, [si]
    cmp al, '$'
    je done_blinking
   
    ; Print character with blinking yellow background, red text (094h)
    mov ah, 09h
    mov bh, 00h
    mov bl, 0ECh  ; blinking red text on yellow background
 
    mov cx, 1     ; Print one character
    int 10h
   
    ; Move cursor forward
    mov ah, 03h
    mov bh, 00h
    int 10h
    inc dl
    mov ah, 02h
    int 10h
   
    inc si
    jmp print_char
 
done_blinking:
    ; Restore cursor to position after the message
    pop dx
    ; Calculate new position (move past the message)
    mov si, dx
find_length:
    mov al, [si]
    cmp al, '$'
    je found_end
    inc dl
    inc si
    jmp find_length
 
found_end:
    mov ah, 02h
    mov bh, 00h
    int 10h
   
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_blinking_error endp
 
print_string proc
    mov ah, 09h
    int 21h
    ret
print_string endp
 
new_line proc
    mov ah, 02h
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h
    ret
new_line endp
 
wait_keypress proc
    mov ah, 08h
    int 21h
    ret
wait_keypress endp
 
end main