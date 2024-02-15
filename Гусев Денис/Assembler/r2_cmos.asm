MASM
CODE_SEG segment
 assume cs:CODE_SEG
 org 100h
start:
 mov BL, 07
 mov CX, 1 
@@1: 
 mov AL, 0
 mov DX, 70h
 out DX, al
 mov DX, 71h
 in AL, DX 
 cmp AL, BL
 jz @@1 
 mov BL, AL
 mov DL, AL
 call write_BCD
 loop @@1
ret
write_BCD proc near
push ax
push cx 
push dx 
and dl, 0f0h
 mov cl, 4
 shr dl, cl
call wr_cifra
 pop dx
 and dl, 0fh
 call wr_cifra
pop cx 
pop ax
ret
write_BCD endp
wr_cifra proc near
push ax
add dl, 30h
mov ah, 02
int 21h
pop ax
ret
wr_cifra endp
CODE_SEG ends
end start
 
 mov ah,2
 mov dl,"/"
 int 21h