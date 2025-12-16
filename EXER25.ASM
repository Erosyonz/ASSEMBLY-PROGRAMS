; Filename: EXER25.ASM
; Programmer Name: Alleah Dela Pena
; Date: September 12, 2025
; Description: an Automated Teller Machine (ATM) main menu screen. Ask the user to input a number corresponding to an item in the main menu. Print back the number input by user and the corresponding transaction.

.model small
.stack 100h
.data

title1      db 'Cebu Institute of Technology - University$'
title2      db 0Dh,0Ah,'Automated Teller Machine$'

menu        db 0Dh,0Ah,0Dh,0Ah,'Main Menu$'
opt1        db 0Dh,0Ah,'1 Balance Inquiry$'
opt2        db 0Dh,0Ah,'2 Withdrawal$'
opt3        db 0Dh,0Ah,'3 Deposit$'
opt4        db 0Dh,0Ah,'4 Transfer$'
opt5        db 0Dh,0Ah,'5 Bills Payment$'
opt6        db 0Dh,0Ah,'6 Change Pin$'
opt7        db 0Dh,0Ah,'7 Exit$'

prompt      db 0Dh,0Ah,'Enter number of your choice: $'

chosen1     db 0Dh,0Ah,0Dh,0Ah,'You have chosen 1 Balance Inquiry.$'
chosen2     db 0Dh,0Ah,0Dh,0Ah,'You have chosen 2 Withdrawal.$'
chosen3     db 0Dh,0Ah,0Dh,0Ah,'You have chosen 3 Deposit.$'
chosen4     db 0Dh,0Ah,0Dh,0Ah,'You have chosen 4 Transfer.$'
chosen5     db 0Dh,0Ah,0Dh,0Ah,'You have chosen 5 Bills Payment.$'
chosen6     db 0Dh,0Ah,0Dh,0Ah,'You have chosen 6 Change Pin.$'
chosen7     db 0Dh,0Ah,0Dh,0Ah,'You have chosen 7 Exit.$'

thankyou    db 0Dh,0Ah,0Dh,0Ah,'Thank you for banking with us!$'
copyrt      db 0Dh,0Ah,'Copyright 2024$'
programmer  db 0Dh,0Ah,'Programmer: ALLEAH DELA PENA$'

.code
main proc
    mov ax, @data
    mov ds, ax

    ; --- Print Titles ---
    mov ah, 9
    mov dx, offset title1
    int 21h
    mov dx, offset title2
    int 21h

    ; --- Print Menu ---
    mov dx, offset menu
    int 21h
    mov dx, offset opt1
    int 21h
    mov dx, offset opt2
    int 21h
    mov dx, offset opt3
    int 21h
    mov dx, offset opt4
    int 21h
    mov dx, offset opt5
    int 21h
    mov dx, offset opt6
    int 21h
    mov dx, offset opt7
    int 21h

    ; --- Prompt User ---
    mov dx, offset prompt
    int 21h

    ; Get single key (choice)
    mov ah, 1
    int 21h
    mov bl, al         ; store choice

   

    ; --- Display chosen option ---
    cmp bl, '1'
    je opt_choice1
    cmp bl, '2'
    je opt_choice2
    cmp bl, '3'
    je opt_choice3
    cmp bl, '4'
    je opt_choice4
    cmp bl, '5'
    je opt_choice5
    cmp bl, '6'
    je opt_choice6
    cmp bl, '7'
    je opt_choice7
    jmp done

opt_choice1:
    mov dx, offset chosen1
    jmp print_choice
opt_choice2:
    mov dx, offset chosen2
    jmp print_choice
opt_choice3:
    mov dx, offset chosen3
    jmp print_choice
opt_choice4:
    mov dx, offset chosen4
    jmp print_choice
opt_choice5:
    mov dx, offset chosen5
    jmp print_choice
opt_choice6:
    mov dx, offset chosen6
    jmp print_choice
opt_choice7:
    mov dx, offset chosen7

print_choice:
    mov ah, 9
    int 21h

done:
    ; --- Footer ---
    mov dx, offset thankyou
    mov ah, 9
    int 21h
    mov dx, offset copyrt
    int 21h
    mov dx, offset programmer
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h
main endp
end main
