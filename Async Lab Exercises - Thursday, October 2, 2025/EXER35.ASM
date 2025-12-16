.model small
.stack 100h

; Macros
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

.data
    ; Header texts
    txt_0_R0_C0 db "THE CALCULATOR",'$'
    txt_1_R1_C0 db "Created by: ALLEA DELA PENA",'$'
    txt_2_R2_C0 db "Date: October 6, 2025",'$'
    txt_3_R4_C0 db "Main Menu",'$'
    txt_4_R5_C0 db "a-addition",'$'
    txt_5_R6_C0 db "s-subtraction",'$'
    txt_6_R7_C0 db "m-multiplication",'$'
    txt_7_R8_C0 db "d-division",'$'
    txt_8_R9_C0 db "e-exit",'$'
    txt_9_R10_C0 db "Enter your choice:",'$'
    
    ; Operation titles
    addTitle db "Addition",'$'
    subTitle db "Subtraction",'$'
    mulTitle db "Multiplication",'$'
    divTitle db "Division",'$'
    exitTitle db "Exit Program",'$'
    
    ; Prompts
    promptAdd1 db "Enter first addend: $"
    promptAdd2 db "Enter second addend: $"
    promptSub1 db "Enter minuend: $"
    promptSub2 db "Enter subtrahend: $"
    promptMul1 db "Enter multiplicand: $"
    promptMul2 db "Enter multiplier: $"
    promptDiv1 db "Enter dividend: $"
    promptDiv2 db "Enter divisor: $"
    
    ; Result messages
    resultAdd db "Sum: $"
    resultSub db "Difference: $"
    resultMul db "Product: $"
    resultDiv db "Quotient: $"
    
    ; Display messages
    addition1 db "First addend is: $"
    addition2 db "Second addend is: $"
    subtract1 db "Minuend is: $"
    subtract2 db "Subtrahend is: $"
    Multiply1 db "Multiplicand is: $"
    Multiply2 db "Multiplier is: $"
    Divide1 db "Dividend is: $"
    Divide2 db "Divisor is: $"
    
    ; Continue prompt
    continueMsg db "Press Enter to continue.",'$'
    
    ; Error messages
    invalidChoice db "Invalid choice! Please enter a, s, m, d, or e.",'$'
    invalidNumber db "Invalid number! Please enter 0-9.",'$'
    
    ; Variables
    num1 db ?
    num2 db ?
    result db ?
    choice db ?

.code
start:
    mov ax, @data
    mov ds, ax
    
main_loop:
    ; Set to video mode 
    mov ah, 00h
    mov al, 03h ; 80x25 color text mode
    int 10h

    ; Display colored header and menu
    call display_colored_header
    
    ; Get and validate user choice
    call get_valid_choice
    
    ; Process choice
    cmp choice, 'a'
    je addition
    cmp choice, 's'
    je subtraction
    cmp choice, 'm'
    je multiplication
    cmp choice, 'd'
    je division
    cmp choice, 'e'
    je exit_program
    
    jmp main_loop

addition:
    call display_colored_add_title
    call get_two_valid_numbers_add
    call perform_addition
    call display_results_add
    jmp wait_continue

subtraction:
    call display_colored_sub_title
    call get_two_valid_numbers_sub
    call perform_subtraction
    call display_results_sub
    jmp wait_continue

multiplication:
    call display_colored_mul_title
    call get_two_valid_numbers_mul
    call perform_multiplication
    call display_results_mul
    jmp wait_continue

division:
    call display_colored_div_title
    call get_div_valid_numbers
    call perform_division
    call display_results_div
    jmp wait_continue

exit_program:
    call display_colored_exit_title
    jmp wait_continue_exit

wait_continue:
    setcursor 23, 0
    colorz 15, 24
    mov ah, 09h
    mov dx, offset continueMsg
    int 21h
    
    ; Wait for Enter key
    mov ah, 01h
    int 21h
    
    jmp main_loop

wait_continue_exit:
    setcursor 23, 0
    colorz 15, 24
    mov ah, 09h
    mov dx, offset continueMsg
    int 21h
    mov ah, 01h
    int 21h
    jmp end_program

end_program:
    mov ax, 4c00h
    int 21h

; === COLORED HEADER DISPLAY ===
display_colored_header proc
    setcursor 0, 0
    colorz 14, 14
    mov ah, 09h
    mov dx, offset txt_0_R0_C0
    int 21h

    setcursor 1, 0
    colorz 14, 27
    mov ah, 09h
    mov dx, offset txt_1_R1_C0
    int 21h

    setcursor 2, 0
    colorz 14, 21
    mov ah, 09h
    mov dx, offset txt_2_R2_C0
    int 21h

    setcursor 4, 0
    colorz 14, 9
    mov ah, 09h
    mov dx, offset txt_3_R4_C0
    int 21h

    setcursor 5, 0
    colorz 111, 10
    mov ah, 09h
    mov dx, offset txt_4_R5_C0
    int 21h

    setcursor 6, 0
    colorz 47, 13
    mov ah, 09h
    mov dx, offset txt_5_R6_C0
    int 21h

    setcursor 7, 0
    colorz 63, 16
    mov ah, 09h
    mov dx, offset txt_6_R7_C0
    int 21h

    setcursor 8, 0
    colorz 95, 10
    mov ah, 09h
    mov dx, offset txt_7_R8_C0
    int 21h

    setcursor 9, 0
    colorz 127, 6
    mov ah, 09h
    mov dx, offset txt_8_R9_C0
    int 21h

    setcursor 10, 0
    colorz 15, 18
    mov ah, 09h
    mov dx, offset txt_9_R10_C0
    int 21h

    setcursor 23, 79
    renderc 32, 0, 0fh, 1
    ret
display_colored_header endp

; === COLORED OPERATION TITLES ===
display_colored_add_title proc
    setcursor 12, 0
    colorz 111, 8
    mov ah, 09h
    mov dx, offset addTitle
    int 21h
    call new_line
    ret
display_colored_add_title endp

display_colored_sub_title proc
    setcursor 12, 0
    colorz 47, 11
    mov ah, 09h
    mov dx, offset subTitle
    int 21h
    call new_line
    ret
display_colored_sub_title endp

display_colored_mul_title proc
    setcursor 12, 0
    colorz 63, 14
    mov ah, 09h
    mov dx, offset mulTitle
    int 21h
    call new_line
    ret
display_colored_mul_title endp

display_colored_div_title proc
    setcursor 12, 0
    colorz 95, 8
    mov ah, 09h
    mov dx, offset divTitle
    int 21h
    call new_line
    ret
display_colored_div_title endp

display_colored_exit_title proc
    setcursor 12, 0
    colorz 127, 12
    mov ah, 09h
    mov dx, offset exitTitle
    int 21h
    call new_line
    ret
display_colored_exit_title endp

; === INPUT/OUTPUT PROCEDURES ===
get_two_valid_numbers_add proc
    setcursor 13, 0
    colorz 15, 19
    mov ah, 09h
    mov dx, offset promptAdd1
    int 21h
    call get_valid_digit
    mov num1, al
    
    setcursor 14, 0
    colorz 15, 20
    mov ah, 09h
    mov dx, offset promptAdd2
    int 21h
    call get_valid_digit
    mov num2, al
    ret
get_two_valid_numbers_add endp

get_two_valid_numbers_sub proc
    setcursor 13, 0
    colorz 15, 16
    mov ah, 09h
    mov dx, offset promptSub1
    int 21h
    call get_valid_digit
    mov num1, al
    
    setcursor 14, 0
    colorz 15, 18
    mov ah, 09h
    mov dx, offset promptSub2
    int 21h
    call get_valid_digit
    mov num2, al
    ret
get_two_valid_numbers_sub endp

get_two_valid_numbers_mul proc
    setcursor 13, 0
    colorz 15, 20
    mov ah, 09h
    mov dx, offset promptMul1
    int 21h
    call get_valid_digit
    mov num1, al
    
    setcursor 14, 0
    colorz 15, 16
    mov ah, 09h
    mov dx, offset promptMul2
    int 21h
    call get_valid_digit
    mov num2, al
    ret
get_two_valid_numbers_mul endp

get_div_valid_numbers proc
    setcursor 13, 0
    colorz 15, 18
    mov ah, 09h
    mov dx, offset promptDiv1
    int 21h
    call get_valid_digit
    mov num1, al
    
get_divisor:
    setcursor 14, 0
    colorz 15, 17
    mov ah, 09h
    mov dx, offset promptDiv2
    int 21h
    call get_valid_digit
    mov num2, al
    
    cmp num2, 0
    jne divisor_ok
    
    setcursor 15, 0
    colorz 79, 28
    mov ah, 09h
    mov dx, offset invalidNumber
    int 21h
    jmp get_divisor
    
divisor_ok:
    ret
get_div_valid_numbers endp

; === VALIDATION PROCEDURES ===
get_valid_choice proc
get_choice:
    setcursor 10, 18
    mov ah, 01h
    int 21h
    mov choice, al
    cmp al, 'a'
    je valid_choice
    cmp al, 's'
    je valid_choice
    cmp al, 'm'
    je valid_choice
    cmp al, 'd'
    je valid_choice
    cmp al, 'e'
    je valid_choice
    
    setcursor 11, 0
    colorz 79, 45
    mov ah, 09h
    mov dx, offset invalidChoice
    int 21h
    jmp get_choice
    
valid_choice:
    ret
get_valid_choice endp

get_valid_digit proc
get_digit:
    mov ah, 01h
    int 21h
    cmp al, '0'
    jb invalid_digit
    cmp al, '9'
    ja invalid_digit
    sub al, '0'
    ret
    
invalid_digit:
    putc 0Dh
    putc 0Ah
    colorz 79, 28
    mov ah, 09h
    mov dx, offset invalidNumber
    int 21h
    jmp get_digit
get_valid_digit endp

; === MATH OPERATIONS ===
perform_addition proc
    mov al, num1
    add al, num2
    mov result, al
    ret
perform_addition endp

perform_subtraction proc
    mov al, num1
    sub al, num2
    mov result, al
    ret
perform_subtraction endp

perform_multiplication proc
    mov al, num1
    mov bl, num2
    mul bl
    mov result, al
    ret
perform_multiplication endp

perform_division proc
    mov al, num1
    xor ah, ah
    mov bl, num2
    div bl
    mov result, al
    ret
perform_division endp

; === DISPLAY PROCEDURES ===
display_results_add proc
    call display_input_numbers_add
    setcursor 17, 0
    colorz 15, 5
    mov ah, 09h
    mov dx, offset resultAdd
    int 21h
    call display_result_number
    ret
display_results_add endp

display_results_sub proc
    call display_input_numbers_sub
    setcursor 17, 0
    colorz 15, 11
    mov ah, 09h
    mov dx, offset resultSub
    int 21h
    call display_result_number
    ret
display_results_sub endp

display_results_mul proc
    call display_input_numbers_mul
    setcursor 17, 0
    colorz 15, 8
    mov ah, 09h
    mov dx, offset resultMul
    int 21h
    call display_result_number
    ret
display_results_mul endp

display_results_div proc
    call display_input_numbers_div
    setcursor 17, 0
    colorz 15, 9
    mov ah, 09h
    mov dx, offset resultDiv
    int 21h
    call display_result_number
    ret
display_results_div endp

display_input_numbers_add proc
    setcursor 15, 0
    colorz 15, 18
    mov ah, 09h
    mov dx, offset addition1
    int 21h
    mov dl, num1
    add dl, '0'
    putc dl
    call new_line
    
    setcursor 16, 0
    colorz 15, 19
    mov ah, 09h
    mov dx, offset addition2
    int 21h
    mov dl, num2
    add dl, '0'
    putc dl
    call new_line
    ret
display_input_numbers_add endp

display_input_numbers_sub proc
    setcursor 15, 0
    colorz 15, 14
    mov ah, 09h
    mov dx, offset subtract1
    int 21h
    mov dl, num1
    add dl, '0'
    putc dl
    call new_line
    
    setcursor 16, 0
    colorz 15, 16
    mov ah, 09h
    mov dx, offset subtract2
    int 21h
    mov dl, num2
    add dl, '0'
    putc dl
    call new_line
    ret
display_input_numbers_sub endp

display_input_numbers_mul proc
    setcursor 15, 0
    colorz 15, 18
    mov ah, 09h
    mov dx, offset Multiply1
    int 21h
    mov dl, num1
    add dl, '0'
    putc dl
    call new_line
    
    setcursor 16, 0
    colorz 15, 15
    mov ah, 09h
    mov dx, offset Multiply2
    int 21h
    mov dl, num2
    add dl, '0'
    putc dl
    call new_line
    ret
display_input_numbers_mul endp

display_input_numbers_div proc
    setcursor 15, 0
    colorz 15, 16
    mov ah, 09h
    mov dx, offset Divide1
    int 21h
    mov dl, num1
    add dl, '0'
    putc dl
    call new_line
    
    setcursor 16, 0
    colorz 15, 14
    mov ah, 09h
    mov dx, offset Divide2
    int 21h
    mov dl, num2
    add dl, '0'
    putc dl
    call new_line
    ret
display_input_numbers_div endp

display_result_number proc
    mov dl, result
    add dl, '0'
    putc dl
    call new_line
    ret
display_result_number endp

new_line proc
    putc 0Dh
    putc 0Ah
    ret
new_line endp

end start