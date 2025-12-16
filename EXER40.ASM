; Filename: EXER40.ASM
; Programmer Name: Alleah Dela Pena
; Date: October 10, 2025
; Description: Repeatedly display an ATM main menu until the user
; presses "e" for Exit. Pressing a valid letter from
; the main menu will display the name of the ATM
; operation. Display INVALID INPUT! if wrong choice.

.MODEL SMALL
.STACK 100h
.DATA
    menu DB 0Dh,0Ah,'CIT-U ATM',0Dh,0Ah
         DB 'a. Balance Inquiry',0Dh,0Ah
         DB 'b. Deposit',0Dh,0Ah
         DB 'c. Withdrawal',0Dh,0Ah
         DB 'd. Bills Payment',0Dh,0Ah
         DB 'e. Exit',0Dh,0Ah
         DB 0Dh,0Ah,'Enter choice: $',0Dh,0Ah
    
    balance_msg DB 0Dh,0Ah,'Balance Inquiry',0Dh,0Ah,'$'
    deposit_msg DB 0Dh,0Ah,'Deposit',0Dh,0Ah,'$'
    withdrawal_msg DB 0Dh,0Ah,'Withdrawal',0Dh,0Ah,'$'
    bills_msg DB 0Dh,0Ah,'Bills Payment',0Dh,0Ah,'$'
    exit_msg DB 0Dh,0Ah,'Exit. Thank you!',0Dh,0Ah,'$'
    invalid_msg DB 0Dh,0Ah,'INVALID INPUT!',0Dh,0Ah,'$'
    newline DB 0Dh,0Ah,'$'
    
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
MENU_LOOP:
    ; Display menu
    MOV AH, 09h
    LEA DX, menu
    INT 21h
    
    ; Get choice
    MOV AH, 01h
    INT 21h
    
    ; Process choice
    CMP AL, 'a'
    JE BALANCE
    CMP AL, 'b'
    JE DEPOSIT
    CMP AL, 'c'
    JE WITHDRAWAL
    CMP AL, 'd'
    JE BILLS
    CMP AL, 'e'
    JE EXIT
    JMP INVALID
    
BALANCE:
    MOV AH, 09h
    LEA DX, newline
    INT 21h  

    MOV AH, 09h
    LEA DX, balance_msg
    INT 21h
    JMP MENU_LOOP
    
DEPOSIT:
    MOV AH, 09h
    LEA DX, newline
    INT 21h 

    MOV AH, 09h
    LEA DX, deposit_msg
    INT 21h
    JMP MENU_LOOP
    
WITHDRAWAL:
    MOV AH, 09h
    LEA DX, newline
    INT 21h 

    MOV AH, 09h
    LEA DX, withdrawal_msg
    INT 21h
    JMP MENU_LOOP
    
BILLS:
    MOV AH, 09h
    LEA DX, newline
    INT 21h  

    MOV AH, 09h
    LEA DX, bills_msg
    INT 21h
    JMP MENU_LOOP
    
INVALID:
    MOV AH, 09h
    LEA DX, newline
    INT 21h 

    MOV AH, 09h
    LEA DX, invalid_msg
    INT 21h
    JMP MENU_LOOP
    
EXIT:
    MOV AH, 09h
    LEA DX, newline
    INT 21h 

    MOV AH, 09h
    LEA DX, exit_msg
    INT 21h
    
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN