masm
CODE_SEG segment
assume cs: CODE_SEG
org 100h

start:
mov bx,0
mov dx,0
call rd_num
call wr_plus
push dx
call rd_num
mov bl,dl
pop dx
call wr_ravno
add dl,bl
cmp dl,0ah
jl simple
sub dl,0ah
push dx
mov dl,31h
call wr_num
pop dx

simple: call wr_num
ret

rd_num proc near
push ax
mov ah,01h
int 21h
sub al,30h
mov dl,al
pop ax
ret
rd_num endp

wr_num proc near
push ax
push cx
and dl,0fh
add dl,30h
mov ah,02
int 21h
pop cx
pop ax
ret
wr_num endp

wr_plus proc near
push ax
push dx
mov dl,2Bh
mov ah,02
int 21h
pop ax
pop dx
ret
wr_plus endp

wr_ravno proc near
push ax
push dx
mov dl,3Dh
mov ah,02
int 21h
pop ax
pop dx
ret
wr_ravno endp

CODE_SEG ends
end start