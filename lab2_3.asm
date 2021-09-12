org 100h

start:
mov si,0
mov al,'>'
mov ah,0eh
int 10h

jmp lookagain

lookagain:
mov ah,1
int 16h
jz lookagain
jmp get

get:
mov ah,0
int 16h

cmp al,0dh
je entered
cmp al,'*'
je halting

mov ah,0eh
int 10h

mov [command+si],al
inc si
jmp lookagain

halting:
mov ah,4ch
int 21h

entered:
mov ah,3
mov bh,0
int 10h

mov dl,0
add dh,1
mov ah,2
int 10h

mov al,0dh
mov ah,0eh
int 10h

jmp control

control:
mov al,0
mov [command+si],al

mov al,[command]
cmp al,'l'
je step1
cmp al,'e'
je halting
jne exit

step1:
mov al,[command+1]
cmp al,'p'
je command_lpwd
cmp al,'c'
je command_lcd
cmp al,'d'
je command_ldir
jne exit

command_lpwd:
mov ah,19h
int 21h
add al,41h

mov ah,0eh
int 10h

mov al,':'
mov ah,0eh
int 10h

mov al,'\'
mov ah,0eh
int 10h

lea si,[directory]

mov dl,0
mov ah,47h
int 21h
jmp print

print:
mov al,[si]
cmp al,0
je exit
mov ah,0eh
int 10h
inc si
jmp print

command_lcd: 
mov dx,command+4
mov ah,3bh
int 21h

jmp exit

command_ldir:
mov ah,1ah
lea dx,[file]
int 21h

mov ah,4Eh
mov cx,0
lea dx,[spec]
int 21h

loop1:
mov dx,file+30
mov ah,9
int 21h
mov ah,4fh
int 21h
jc exit
jmp loop1 

exit:
mov ah,3
mov bh,0
int 10h

mov dl,0
add dh,1
mov ah,2
int 10h

mov al,0dh
mov ah,0eh
int 10h

jmp start

segment data
directory: db 0
command: db 0
file: times 128 db '$'
spec: db '*.*',0
