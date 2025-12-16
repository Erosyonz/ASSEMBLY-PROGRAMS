.model small
.stack 100h
.code
main proc
    ; set text mode
    mov ax, 3
    int 10h

    ; set cursor at row=5, col=10
    mov ah, 2
    mov bh, 0
    mov dh, 5
    mov dl, 10
    int 10h

    ; print colored character
    mov ah, 9
    mov al, 'X'     ; character
    mov bh, 0       ; page
    mov bl, 4Eh     ; attribute (yellow on blue)
    mov cx, 1
    int 10h

    ; wait key
    mov ah, 0
    int 16h

    mov ax, 4C00h
    int 21h
main endp
end main
