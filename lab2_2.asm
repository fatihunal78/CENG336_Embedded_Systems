org 100h

;clear the screen
mov ax,3
int 10h

;initializing com1
mov ah,0
mov al,11111110b
mov dx,0
int 14h

start:
;see whether any character is ready at keyboard
mov ah,1
int 16h
jz lookport

;if character is ready,reading from keyboard
mov ah,0
int 16h

;check the keyboard input for conditions
cmp al,'q'
je exit1
cmp al,'Q'
je exit1

cmp al,0dh
je enter1

;printing character to screen
mov dl,al
mov ah,2
int 21h
jmp continue1

continue1:
;send the character to serial port
mov dx,0
mov ah,1
int 14h
jmp lookport

lookport:
;control the serial port whether data is ready
mov dx,0
mov ah,3
int 14h

;checking whether data is ready
bt ax,8
jnc start

;receive character from serial port
mov dx,0
mov ah,2
int 14h

;check the incoming character for conditions
cmp al,'q'
je exit
cmp al,'Q'
je exit

cmp al,0dh
je enter2

;print data to the screen
mov dl,al
mov ah,2
int 21h
jmp lookport

;go to next line in the receive screen
enter1:
mov ah,3
mov bh,0
int 10h

mov dl,0
add dh,1
mov ah,2
int 10h
mov dl,al
mov ah,2
int 21h
jmp continue1

;go to next line in the send screen
enter2:
mov ah,3
mov bh,0
int 10h

mov dl,0
add dh,1
mov ah,2
int 10h
mov dl,al
mov ah,2
int 21h
jmp lookport

;exits but sends the character
exit1:
mov dx,0
mov ah,1
int 14h
jmp exit

;only exits
exit:
mov ah,4ch
int 21h

