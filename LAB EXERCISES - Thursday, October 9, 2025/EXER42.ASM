;=====================================================================
; Program Title : EXER42.ASM
; Description   : This program asks the user to input a 5-digit number
;                 and then displays the same number back to the screen.
; Author        : ALLEAH DELA PENA
; Assembler     : Turbo Assembler (TASM)
; Environment   : DOSBox (16-bit real mode)
;=====================================================================

.MODEL SMALL             ; Small memory model (code < 64K, data < 64K)
.STACK 100h              ; Reserve 256 bytes for stack
.DATA                    ; Begin data segment

    ;---------------------------------------------------------------
    ; Define the messages and data storage
    ;---------------------------------------------------------------
    msg1 db 'Enter a 5-digit number: $'          ; Input prompt
    msg2 db 0Dh,0Ah, 'You entered: $'            ; Output message
    num  db 5 dup(?)                             ; Reserve 5 bytes to store digits

.CODE                    ; Begin code segment

MAIN PROC
    ;---------------------------------------------------------------
    ; Step 1: Initialize the data segment register DS
    ;---------------------------------------------------------------
    mov ax, @data         ; Load the address of the data segment
    mov ds, ax            ; Copy it into DS so we can access data variables

    ;---------------------------------------------------------------
    ; Step 2: Display the prompt message
    ;---------------------------------------------------------------
    mov ah, 09h           ; DOS function 09h = display string
    lea dx, msg1          ; Load effective address of msg1 into DX
    int 21h               ; Call DOS interrupt to print message

    ;---------------------------------------------------------------
    ; Step 3: Read 5 characters (digits) from the keyboard
    ;---------------------------------------------------------------
    mov si, 0             ; SI = index = 0 (points to first element of array)

ReadLoop:
    mov ah, 01h           ; DOS function 01h = read a character from keyboard
    int 21h               ; Wait for user to press a key
                          ; The ASCII value of the key is returned in AL

    cmp al, 0Dh           ; Check if the key pressed is ENTER (ASCII 13)
    je DoneInput          ; If yes, jump to DoneInput (allow early exit)

    mov num[si], al       ; Store the character (digit) in array num[]
    inc si                ; Move to next position in the array
    cmp si, 5             ; Have we read 5 digits?
    jl ReadLoop           ; If not yet, continue reading
DoneInput:

    ;---------------------------------------------------------------
    ; Step 4: Print a newline and display header text
    ;---------------------------------------------------------------
    mov ah, 09h           ; DOS print string function
    lea dx, msg2          ; Load address of msg2 ("You entered:")
    int 21h               ; Display it

    ;---------------------------------------------------------------
    ; Step 5: Display the entered digits one by one
    ;---------------------------------------------------------------
    mov cx, 5             ; CX = counter (5 digits to display)
    mov si, 0             ; Reset SI = 0 (point back to start of num[])

DisplayLoop:
    mov dl, num[si]       ; Load current digit (ASCII) into DL
    mov ah, 02h           ; DOS function 02h = display one character
    int 21h               ; Print DL to the screen
    inc si                ; Move to next character in the array
    loop DisplayLoop      ; Decrement CX and repeat until CX = 0

    ;---------------------------------------------------------------
    ; Step 6: Exit the program and return to DOS
    ;---------------------------------------------------------------
    mov ah, 4Ch           ; DOS terminate program function
    int 21h               ; Return control to DOS

MAIN ENDP
END MAIN
