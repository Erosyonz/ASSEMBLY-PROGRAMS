; Name: Alleah Dela Pena
; prelim

.model small
.stack 100
.data
    msg1 db 'Please enter your details$'
    msg2 db 'Welcome back$'
    msg3 db '|Email Address          |$'
    msg4 db '|Password               |$'
    msg5 db 'Remember for 30 days   forgot password$'
    msg6 db 'Sign up'
    msg7 db 'Sign in with Google'
    msg8 db 'Sign up'
    msg9 db 'Alleah Dela Pena'
    msg10 db '-------------------------$'
    msg11 db '|                       |$'
.code
.startup
 
start:
    mov ax, 1003h
    mov bl, 00h
    int 10h
;outer
    mov ah,09h
    mov bl,04h
    mov cx,79
    int 10h
 
    mov ah,02h
    mov dl,219d
    mov cx,79
    draw_line:
        int 21h
        loop draw_line
 
    mov ah,02h
    mov cl,0Ah
    mov dl,cl
    int 21h
 
;first row
    mov ah,09h
    mov bl,04h
    mov cx,1
    int 10h
 
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,0Fh
    mov cx,77
    int 10h
 
    mov ah,02h
    mov dl,219d
    mov cx,77
    draw_line1:
        int 21h
        loop draw_line1
 
    mov ah,09h
    mov bl,04h
    mov cx,1
    int 10h
 
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,00h
    mov cx,79
    int 10h
 
    mov ah,02h
    mov cl,0Ah
    mov dl,cl
    int 21h
 
;second row
   
    mov ah,09h
    mov bl,04h
    mov cx,1
    int 10h
 ; reset
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,0Fh
    mov cx,5
    int 10h
 
    mov ah,02h
    mov dl,219d
    mov cx,5
    draw_line2:
        int 21h
        loop draw_line2
 
    mov ah,09h
    mov bl,0F8h
    mov cx,25
    int 10h
 
    mov ah,9
    mov dx,offset msg1
    int 21h
 
    mov ah,09h
    mov bl,0FFh
    mov cx,47
    int 10h
    
    mov ah,02h
    mov dl,219d
    mov cx,47
    draw_line3:
        int 21h
        loop draw_line3
 
    mov ah,09h
    mov bl,04h
    mov cx,1
    int 10h
 
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,00h
    mov cx,50
    int 10h
 
    mov ah,02h
    mov cl,0Ah
    mov dl,cl
    int 21h
; Third row
  mov ah,09h
    mov bl,04h
    mov cx,1
    int 10h
 
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,0Fh
    mov cx,77
    int 10h
 
    mov ah,02h
    mov dl,219d
    mov cx,77
    draw_line4:
        int 21h
        loop draw_line4
 
    mov ah,09h
    mov bl,04h
    mov cx,1
    int 10h
 
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,00h
    mov cx,50
    int 10h
 
    mov ah,02h
    mov cl,0Ah
    mov dl,cl
    int 21h
;fourth row
   
    mov ah,09h
    mov bl,04h
    mov cx,1
    int 10h
 ; reset
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,0Fh
    mov cx,5
    int 10h
 
    mov ah,02h
    mov dl,219d
    mov cx,5
    draw_line5:
        int 21h
        loop draw_line5
 
    mov ah,09h
    mov bl,0F8h
    mov cx,25
    int 10h
 
    mov ah,9
    mov dx,offset msg2
    int 21h
 
    mov ah,09h
    mov bl,0FFh
    mov cx,60
    int 10h
    
    mov ah,02h
    mov dl,219d
    mov cx,60
    draw_line6:
        int 21h
        loop draw_line6
 
    mov ah,09h
    mov bl,04h
    mov cx,1
    int 10h
 
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,00h
    mov cx,50
    int 10h
 
    mov ah,02h
    mov cl,0Ah
    mov dl,cl
    int 21h
; Fifth row 
    mov ah,09h
    mov bl,04h
    mov cx,1
    int 10h
 
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,0Fh
    mov cx,77
    int 10h
 
    mov ah,02h
    mov dl,219d
    mov cx,77
    draw_line7:
        int 21h
        loop draw_line7
 
    mov ah,09h
    mov bl,04h
    mov cx,1
    int 10h
 
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,00h
    mov cx,79
    int 10h
 
    mov ah,02h
    mov cl,0Ah
    mov dl,cl
    int 21h
 
;sixth row 
 mov ah,09h
    mov bl,04h
    mov cx,1
    int 10h
 
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,0Fh
    mov cx,77
    int 10h
 
    mov ah,02h
    mov dl,219d
    mov cx,77
    draw_line8:
        int 21h
        loop draw_line8
 
    mov ah,09h
    mov bl,04h
    mov cx,1
    int 10h
 
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,00h
    mov cx,50
    int 10h
 
    mov ah,02h
    mov cl,0Ah
    mov dl,cl
    int 21h 
; seventh
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,0Fh
    mov cx,5
    int 10h
 
    mov ah,02h
    mov dl,219d
    mov cx,5
    draw_line9:
        int 21h
        loop draw_line9
 
    mov ah,09h
    mov bl,0F8h
    mov cx,25
    int 10h
 
    mov ah,9
    mov dx,offset msg10
    int 21h
 
    mov ah,09h
    mov bl,0FFh
    mov cx,47
    int 10h
    
    mov ah,02h
    mov dl,219d
    mov cx,47
    draw_line10:
        int 21h
        loop draw_line10
 
    mov ah,09h
    mov bl,04h
    mov cx,1
    int 10h
 
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,00h
    mov cx,50
    int 10h
 
    mov ah,02h
    mov cl,0Ah
    mov dl,cl
    int 21h
; Eight row
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,0Fh
    mov cx,5
    int 10h
 
    mov ah,02h
    mov dl,219d
    mov cx,5
    draw_line11:
        int 21h
        loop draw_line11
 
    mov ah,09h
    mov bl,0F8h
    mov cx,25
    int 10h
 
    mov ah,9
    mov dx,offset msg3
    int 21h
 
    mov ah,09h
    mov bl,0FFh
    mov cx,47
    int 10h
    
    mov ah,02h
    mov dl,219d
    mov cx,47
    draw_line12:
        int 21h
        loop draw_line12
 
    mov ah,09h
    mov bl,04h
    mov cx,1
    int 10h
 
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,00h
    mov cx,50
    int 10h
 
    mov ah,02h
    mov cl,0Ah
    mov dl,cl
    int 21h
; ninegth row
        mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,0Fh
    mov cx,5
    int 10h
 
    mov ah,02h
    mov dl,219d
    mov cx,5
    draw_line13:
        int 21h
        loop draw_line13
 
    mov ah,09h
    mov bl,0F8h
    mov cx,25
    int 10h
 
    mov ah,9
    mov dx,offset msg10
    int 21h
 
   mov ah,09h
    mov bl,0FFh
    mov cx,47
    int 10h
    
    mov ah,02h
    mov dl,219d
    mov cx,47
    draw_line14:
        int 21h
        loop draw_line14
 
    mov ah,09h
    mov bl,04h
    mov cx,1
    int 10h
 
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,00h
    mov cx,50
    int 10h
 
    mov ah,02h
    mov cl,0Ah
    mov dl,cl
    int 21h
;tenth row
    mov ah,09h
    mov bl,04h
    mov cx,1
    int 10h
 
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,0Fh
    mov cx,77
    int 10h
 
    mov ah,02h
    mov dl,219d
    mov cx,77
    draw_line15:
        int 21h
        loop draw_line15
 
    mov ah,09h
    mov bl,04h
    mov cx,1
    int 10h
 
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,00h
    mov cx,50
    int 10h
 
    mov ah,02h
    mov cl,0Ah
    mov dl,cl
    int 21h
;eleventh row
 ; seventh
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,0Fh
    mov cx,5
    int 10h
 
    mov ah,02h
    mov dl,219d
    mov cx,5
    draw_line16:
        int 21h
        loop draw_line16
 
    mov ah,09h
    mov bl,0F8h
    mov cx,25
    int 10h
 
    mov ah,9
    mov dx,offset msg10
    int 21h
 
    mov ah,09h
    mov bl,0FFh
    mov cx,47
    int 10h
    
    mov ah,02h
    mov dl,219d
    mov cx,47
    draw_line17:
        int 21h
        loop draw_line17
 
    mov ah,09h
    mov bl,04h
    mov cx,1
    int 10h
 
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,00h
    mov cx,50
    int 10h
 
    mov ah,02h
    mov cl,0Ah
    mov dl,cl
    int 21h
; Twelveth row
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,0Fh
    mov cx,5
    int 10h
 
    mov ah,02h
    mov dl,219d
    mov cx,5
    draw_line18:
        int 21h
        loop draw_line18
 
    mov ah,09h
    mov bl,0F8h
    mov cx,25
    int 10h
 
    mov ah,9
    mov dx,offset msg4
    int 21h
 
    mov ah,09h
    mov bl,0FFh
    mov cx,47
    int 10h
    
    mov ah,02h
    mov dl,219d
    mov cx,47
    draw_line19:
        int 21h
        loop draw_line19
 
    mov ah,09h
    mov bl,04h
    mov cx,1
    int 10h
 
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,00h
    mov cx,50
    int 10h
 
    mov ah,02h
    mov cl,0Ah
    mov dl,cl
    int 21h
; Thirteenth row
        mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,0Fh
    mov cx,5
    int 10h
 
    mov ah,02h
    mov dl,219d
    mov cx,5
    draw_line20:
        int 21h
        loop draw_line20
 
    mov ah,09h
    mov bl,0F8h
    mov cx,25
    int 10h
 
    mov ah,9
    mov dx,offset msg10
    int 21h
 
   mov ah,09h
    mov bl,0FFh
    mov cx,47
    int 10h
    
    mov ah,02h
    mov dl,219d
    mov cx,47
    draw_line21:
        int 21h
        loop draw_line21
 
    mov ah,09h
    mov bl,04h
    mov cx,1
    int 10h
 
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,00h
    mov cx,50
    int 10h
 
    mov ah,02h
    mov cl,0Ah
    mov dl,cl
    int 21h   
;Fourteenth
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,0Fh
    mov cx,5
    int 10h
 
    mov ah,02h
    mov dl,219d
    mov cx,5
    draw_line22:
        int 21h
        loop draw_line22
 
    mov ah,09h
    mov bl,0F8h
    mov cx,50
    int 10h

    mov ah, 02h
    mov dl, 218
    int 21h
    
    mov ah, 02h
    mov dl, 191
    int 21h
    

    mov ah,9
    mov dx,offset msg5
    int 21h
 
 
    mov ah,09h
    mov bl,0FFh
    mov cx,32
    int 10h
    
    mov ah,02h
    mov dl,219d
    mov cx,32
    draw_line23:
        int 21h
        loop draw_line23
 
    mov ah,09h
    mov bl,04h
    mov cx,1
    int 10h
 
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,00h
    mov cx,50
    int 10h
 
    mov ah,02h
    mov cl,0Ah
    mov dl,cl
    int 21h
;fifteen
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,0Fh
    mov cx,5
    int 10h
 
    mov ah,02h
    mov dl,219d
    mov cx,5
    draw_line24:
        int 21h
        loop draw_line24
 
    mov ah,09h
    mov bl,0F8h
    mov cx,50
    int 10h

    mov ah, 02h
    mov dl, 192
    int 21h
    
    mov ah, 02h
    mov dl, 217
    int 21h

 
    mov ah,09h
    mov bl,0FFh
    mov cx,70
    int 10h
    
    mov ah,02h
    mov dl,219d
    mov cx,70
    draw_line25:
        int 21h
        loop draw_line25
 
    mov ah,09h
    mov bl,04h
    mov cx,1
    int 10h
 
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,00h
    mov cx,50
    int 10h
 
    mov ah,02h
    mov cl,0Ah
    mov dl,cl
    int 21h
;sixteen
    mov ah,09h
    mov bl,04h
    mov cx,1
    int 10h
 
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,0Fh
    mov cx,77
    int 10h
 
    mov ah,02h
    mov dl,219d
    mov cx,77
    draw_line26:
        int 21h
        loop draw_line26
 
    mov ah,09h
    mov bl,04h
    mov cx,1
    int 10h
 
    mov ah,02h
    mov dl,219d
    int 21h
 
    mov ah,09h
    mov bl,00h
    mov cx,79
    int 10h
 
    mov ah,02h
    mov cl,0Ah
    mov dl,cl
    int 21h
;eighteen
    mov ah,09h
    mov bl,04h
    mov cx,79
    int 10h
 
    mov ah,02h
    mov dl,219d
    mov cx,79
    draw_line27:
        int 21h
        loop draw_line27
 
    mov ah,02h
    mov cl,0Ah
    mov dl,cl
    int 21h
 
.exit
end
 