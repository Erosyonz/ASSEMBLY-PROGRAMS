; Filename: FINALEXAM_DELAPENA.ASM
; CS243 Lab Hands-on Final Exam
; First Semester SY 2025-2026
; Student Name: Alleah Dela Pena
; Date Finished: December 12, 2025

.model small
.stack 100h
.data
    ; Header strings
    header1 db 'Cebu Institute of Technology - University$'
    header2 db 'College of Computer Studies$'
    header3 db 'FAVORITE CLASSMATE VOTING SYSTEM$'
    header4 db 'Programmer: ALLEAH DELA PENA$'
    
    ; Menu strings
    menu1 db 'MAIN MENU$'
    menu2 db '1. Vote$'
    menu3 db '2. View$'
    menu4 db '3. Update$'
    menu5 db '4. Delete$'
    menu6 db '5. Exit$'
    menuPrompt db 'Enter choice: $'
    
    ; Operation titles
    voteTitle db 'Vote$'
    viewTitle db 'View$'
    updateTitle db 'Update$'
    deleteTitle db 'Delete$'
    
    ; Prompts
    namePrompt db 'Enter candidate name: $'
    ratingPrompt db 'Enter vote rating (0-100): $'
    recordPrompt db 'Enter record number to update: $'
    deleteRecordPrompt db 'Enter record number to delete: $'
    newNamePrompt db 'Enter new candidate name: $'
    newRatingPrompt db 'Enter new vote rating (0-100): $'
    
    ; Messages
    noRecord db 'No record found.$'
    recordDeleted db 'Record deleted.$'
    pressKey db 'Press any key to go back to Main Menu...$'
    exitMsg1 db 'Exiting...$'
    exitMsg2 db 'Thank you for using Favorite Classmate Voting System.$'
    invalidChoice db 'Invalid choice! Press any key to continue...$'
    
    ; Data storage (max 50 candidates)
    maxCandidates equ 50
    candidateCount dw 0
    candidateNames db 1500 dup('$')  ; 50 candidates * 30 chars each
    candidateRatings dw 50 dup(0)
    
    ; Temporary storage
    tempName db 31 dup('$')
    tempRating dw 0
    tempNumber dw 0
    choice db ?
    
.code
main proc
    mov ax, @data
    mov ds, ax
    
    ; Set background color (blue background, white text)
    mov ah, 06h
    mov al, 0
    mov bh, 17h  ; 1 = blue background, 7 = white text
    mov cx, 0
    mov dx, 184Fh
    int 10h
    
mainLoop:
    call clearScreen
    call newLine
    call displayHeader
    call displayMenu
    
    ; Get user choice
    mov ah, 01h
    int 21h
    mov choice, al
    
    ; Check choice
    cmp choice, '1'
    je voteOption
    cmp choice, '2'
    je viewOption
    cmp choice, '3'
    je updateOption
    cmp choice, '4'
    je deleteOption
    cmp choice, '5'
    je exitOption
    
    ; Invalid choice
    call clearScreen
    call displayHeader
    call newLine
    lea dx, invalidChoice
    call printString
    call waitKey
    jmp mainLoop
    
voteOption:
    call voteProc
    jmp mainLoop
    
viewOption:
    call viewProc
    jmp mainLoop
    
updateOption:
    call updateProc
    jmp mainLoop
    
deleteOption:
    call deleteProc
    jmp mainLoop
    
exitOption:
    

    call newLine
    call newLine
    lea dx, exitMsg1
    call printString
    call newLine
    lea dx, exitMsg2
    call printString
    call newLine
    
    mov ah, 4Ch
    int 21h
    
main endp

; Clear screen procedure
clearScreen proc
    mov ah, 06h
    mov al, 0
    mov bh, 17h
    mov cx, 0
    mov dx, 184Fh
    int 10h
    
    ; Set cursor to top
    mov ah, 02h
    mov bh, 0
    mov dx, 0
    int 10h
    ret
clearScreen endp

; Display header procedure
displayHeader proc
    lea dx, header1
    call printString
    call newLine
    lea dx, header2
    call printString
    call newLine
    lea dx, header3
    call printString
    call newLine
    lea dx, header4
    call printString
    call newLine
    call newLine
    ret
displayHeader endp

; Display menu procedure
displayMenu proc
    lea dx, menu1
    call printString
    call newLine
    
    ; Menu 2 - Red background
    mov ah, 09h
    mov bl, 4Fh  ; 4=Red background, F=White text (bright)
    mov cx, 7    ; Length of "2. Vote$"
    int 10h
    lea dx, menu2
    call printString
    call newLine
    
    ; Menu 3 - Green background
    mov ah, 09h
    mov bl, 2Fh  ; 2=Green background, F=White text (bright)
    mov cx, 7    ; Length of "3. View$"
    int 10h
    lea dx, menu3
    call printString
    call newLine
    
    ; Menu 4 - Cyan background
    mov ah, 09h
    mov bl, 3Fh  ; 3=Cyan background, F=White text (bright)
    mov cx, 9   ; Length of "4. Update$"
    int 10h
    lea dx, menu4
    call printString
    call newLine
    
    ; Menu 5 - Magenta background
    mov ah, 09h
    mov bl, 5Fh  ; 5=Magenta background, F=White text (bright)
    mov cx, 9   ; Length of "5. Delete$"
    int 10h
    lea dx, menu5
    call printString
    call newLine
    
    ; Menu 6 - Exit (keep default blue)
    lea dx, menu6
    call printString
    call newLine
    
    lea dx, menuPrompt
    call printString
    ret
displayMenu endp

; Vote procedure
voteProc proc
    call clearScreen
    call displayHeader

    mov ah, 09h
    mov bl, 4Fh  ; 4=Red background, F=White text (bright)
    mov cx, 4    ; Length of "Vote$"
    int 10h
    lea dx, voteTitle
    call printString
    call newLine
    
    ; Check if max candidates reached
    mov ax, candidateCount
    cmp ax, maxCandidates
    jge voteFull
    
    ; Get candidate name
    lea dx, namePrompt
    call printString
    lea dx, tempName
    call getString
    
    ; Get rating
    lea dx, ratingPrompt
    call printString
    call getNumber
    mov tempRating, ax
    
    ; Add to array
    mov si, candidateCount
    mov ax, 30
    mul si
    mov di, ax
    
    ; Copy name
    lea si, tempName
    lea di, candidateNames
    add di, ax
    call copyString
    
    ; Copy rating
    mov si, candidateCount
    shl si, 1
    mov ax, tempRating
    mov candidateRatings[si], ax
    
    ; Increment count
    inc candidateCount
    
voteFull:
    call newLine
    lea dx, pressKey
    call printString
    call waitKey
    ret
voteProc endp

; View procedure
viewProc proc
    call clearScreen
    call displayHeader

    mov ah, 09h
    mov bl, 2Fh  ; 2=Green background, F=White text (bright)
    mov cx, 4    ; Length of "View$"
    int 10h
    lea dx, viewTitle
    call printString
    call newLine
    
    ; Check if empty
    mov ax, candidateCount
    cmp ax, 0
    je viewEmpty
    
    ; Display all candidates
    mov cx, candidateCount
    mov bx, 0
    
viewLoop:
    push cx
    push bx
    
    ; Display number
    mov ax, bx
    inc ax
    call printNumber
    mov dl, '.'
    mov ah, 02h
    int 21h
    mov dl, ' '
    mov ah, 02h
    int 21h
    
    ; Display name
    mov ax, 30
    mul bx
    lea si, candidateNames
    add si, ax
    mov dx, si
    call printString
    
    ; Display rating
    mov dl, ' '
    mov ah, 02h
    int 21h
    mov dl, '-'
    mov ah, 02h
    int 21h
    mov dl, ' '
    mov ah, 02h
    int 21h
    
    pop bx
    push bx
    shl bx, 1
    mov ax, candidateRatings[bx]
    call printNumber
    
    call newLine
    
    pop bx
    inc bx
    pop cx
    loop viewLoop
    
    jmp viewEnd
    
viewEmpty:
    lea dx, noRecord
    call printString
    call newLine
    
viewEnd:
    lea dx, pressKey
    call printString
    call waitKey
    ret
viewProc endp

; Update procedure
updateProc proc
    call clearScreen
    call displayHeader

    mov ah, 09h
    mov bl, 3Fh  ; 3=Cyan background, F=White text (bright)
    mov cx, 6   ; Length of "Update$"
    int 10h
    lea dx, updateTitle
    call printString
    call newLine
    
    ; Check if empty
    mov ax, candidateCount
    cmp ax, 0
    je updateEmpty
    
    ; Display all candidates
    call displayAllCandidates
    
    ; Get record number
    lea dx, recordPrompt
    call printString
    call getNumber
    dec ax
    mov tempNumber, ax
    
    ; Validate
    mov ax, tempNumber
    cmp ax, 0
    jl updateEnd
    cmp ax, candidateCount
    jge updateEnd
    
    ; Get new name
    lea dx, newNamePrompt
    call printString
    lea dx, tempName
    call getString
    
    ; Get new rating
    lea dx, newRatingPrompt
    call printString
    call getNumber
    mov tempRating, ax
    
    ; Update name
    mov ax, tempNumber
    mov bx, 30
    mul bx
    lea di, candidateNames
    add di, ax
    lea si, tempName
    call copyString
    
    ; Update rating
    mov ax, tempNumber
    shl ax, 1
    mov bx, ax
    mov ax, tempRating
    mov candidateRatings[bx], ax
    
    jmp updateEnd
    
updateEmpty:
    lea dx, noRecord
    call printString
    call newLine
    
updateEnd:
    call newLine
    lea dx, pressKey
    call printString
    call waitKey
    ret
updateProc endp

; Delete procedure
deleteProc proc
    call clearScreen
    call displayHeader

    ; Menu 5 - Magenta background
    mov ah, 09h
    mov bl, 5Fh  ; 5=Magenta background, F=White text (bright)
    mov cx, 6   ; Length of "5. Delete$"
    int 10h
    lea dx, deleteTitle
    call printString
    call newLine
    
    ; Check if empty
    mov ax, candidateCount
    cmp ax, 0
    je deleteEmpty
    
    ; Display all candidates
    call displayAllCandidates
    
    ; Get record number
    lea dx, deleteRecordPrompt
    call printString
    call getNumber
    dec ax
    mov tempNumber, ax
    
    ; Validate
    mov ax, tempNumber
    cmp ax, 0
    jl deleteEnd
    cmp ax, candidateCount
    jge deleteEnd
    
    ; Shift candidates up
    mov cx, candidateCount
    sub cx, tempNumber
    dec cx
    cmp cx, 0
    jle deleteLast
    
    mov si, tempNumber
    
deleteShift:
    push cx
    push si
    
    ; Shift name
    mov ax, si
    mov bx, 30
    mul bx
    lea di, candidateNames
    add di, ax
    add ax, 30
    lea si, candidateNames
    add si, ax
    call copyString
    
    ; Shift rating
    pop si
    push si
    mov ax, si
    inc ax
    shl ax, 1
    mov bx, ax
    mov ax, candidateRatings[bx]
    pop si
    push si
    mov bx, si
    shl bx, 1
    mov candidateRatings[bx], ax
    
    pop si
    inc si
    pop cx
    loop deleteShift
    
deleteLast:
    dec candidateCount
    lea dx, recordDeleted
    call printString
    call newLine
    jmp deleteEnd
    
deleteEmpty:
    lea dx, noRecord
    call printString
    call newLine
    
deleteEnd:
    lea dx, pressKey
    call printString
    call waitKey
    ret
deleteProc endp

; Helper procedures
printString proc
    mov ah, 09h
    int 21h
    ret
printString endp

newLine proc
    mov dl, 0Dh
    mov ah, 02h
    int 21h
    mov dl, 0Ah
    mov ah, 02h
    int 21h
    ret
newLine endp

waitKey proc
    mov ah, 00h
    int 16h
    ret
waitKey endp

getString proc
    push bx
    push cx
    push di
    mov di, dx          ; DI points to buffer
    mov cx, 0           ; Character count
    
getStrLoop:
    mov ah, 00h         ; Wait for key press
    int 16h
    
    cmp al, 0Dh         ; Enter key
    je getStrEnd
    
    cmp al, 08h         ; Backspace key
    je handleBackspace
    
    cmp al, 20h         ; Check if printable character (space or above)
    jl getStrLoop       ; Ignore control characters
    
    cmp cx, 30          ; Max 30 characters
    jge getStrLoop      ; Buffer full
    
    ; Display the character
    mov ah, 02h
    mov dl, al
    int 21h
    
    ; Store in buffer
    mov [di], al
    inc di
    inc cx
    jmp getStrLoop

handleBackspace:
    cmp cx, 0           ; Nothing to delete
    je getStrLoop
    
    ; Move cursor back
    mov ah, 02h
    mov dl, 08h         ; Backspace
    int 21h
    mov dl, 20h         ; Space
    int 21h
    mov dl, 08h         ; Backspace again
    int 21h
    
    ; Remove from buffer
    dec di
    dec cx
    mov byte ptr [di], '$'  ; Clear the position
    jmp getStrLoop

getStrEnd:
    mov byte ptr [di], '$'  ; Terminate string
    call newLine            ; Move to next line after enter
    pop di
    pop cx
    pop bx
    ret
getString endp

getNumber proc
    push bx
    push cx
    push dx
    push si
    
    xor bx, bx          ; Clear BX for result
    xor cx, cx          ; Digit count
    
getNumLoop:
    mov ah, 00h         ; Wait for key press
    int 16h
    
    cmp al, 0Dh         ; Enter key
    je getNumEnd
    
    cmp al, 08h         ; Backspace key
    je handleNumBackspace
    
    ; Check if digit (0-9)
    cmp al, '0'
    jl getNumLoop
    cmp al, '9'
    jg getNumLoop
    
    ; Check if we have 3 digits (for 0-100)
    cmp cx, 3
    jge getNumLoop
    
    ; Display the digit
    mov ah, 02h
    mov dl, al
    int 21h
    
    ; Convert ASCII to number and add to result
    sub al, '0'
    mov ah, 0
    push ax
    
    ; BX = BX * 10 + new digit
    mov ax, bx
    mov si, 10
    mul si
    mov bx, ax
    pop ax
    add bx, ax
    
    inc cx              ; Increment digit count
    jmp getNumLoop

handleNumBackspace:
    cmp cx, 0           ; Nothing to delete
    je getNumLoop
    
    ; Move cursor back
    mov ah, 02h
    mov dl, 08h         ; Backspace
    int 21h
    mov dl, 20h         ; Space
    int 21h
    mov dl, 08h         ; Backspace again
    int 21h
    
    ; Remove last digit from result
    ; BX = BX / 10
    mov ax, bx
    mov si, 10
    xor dx, dx
    div si
    mov bx, ax
    
    dec cx              ; Decrement digit count
    jmp getNumLoop

getNumEnd:
    call newLine        ; Move to next line after enter
    mov ax, bx          ; Return result in AX
    
    ; Validate range (0-100)
    cmp ax, 100
    jle numValid
    mov ax, 100         ; Cap at 100 if user entered more
    
numValid:
    pop si
    pop dx
    pop cx
    pop bx
    ret
getNumber endp

printNumber proc
    push ax
    push bx
    push cx
    push dx
    mov cx, 0
    mov bx, 10
printNumLoop:
    mov dx, 0
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne printNumLoop
printNumDigit:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop printNumDigit
    pop dx
    pop cx
    pop bx
    pop ax
    ret
printNumber endp

copyString proc
    push si
    push di
copyLoop:
    mov al, [si]
    mov [di], al
    cmp al, '$'
    je copyEnd
    inc si
    inc di
    jmp copyLoop
copyEnd:
    pop di
    pop si
    ret
copyString endp

displayAllCandidates proc
    mov cx, candidateCount
    mov bx, 0
dispLoop:
    push cx
    push bx
    mov ax, bx
    inc ax
    call printNumber
    mov dl, '.'
    mov ah, 02h
    int 21h
    mov dl, ' '
    mov ah, 02h
    int 21h
    mov ax, 30
    mul bx
    lea si, candidateNames
    add si, ax
    mov dx, si
    call printString
    mov dl, ' '
    mov ah, 02h
    int 21h
    mov dl, '-'
    mov ah, 02h
    int 21h
    mov dl, ' '
    mov ah, 02h
    int 21h
    pop bx
    push bx
    shl bx, 1
    mov ax, candidateRatings[bx]
    call printNumber
    call newLine
    pop bx
    inc bx
    pop cx
    loop dispLoop
    ret
displayAllCandidates endp

end main