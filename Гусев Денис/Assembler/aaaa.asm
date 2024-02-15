MASM 
CADE_SEG segment
	assume cs; CODE_SEG
	org 100h
start:
	mov bx,0
	mov dx,0
	call rd_num
	call wr_plus
	push dx
	call rd_num
	mov bl, dl
	cmp dl, 0ah
	push dx
	mov dl, 31h
	call wr_num
	pop dx
simple: call wr_num
	ret
rd num proc near;
	push ax
	mov ah,01h
	int 21h
	sub, al,30h
	mov dl, al
	pop ax
	ret
rd num endp
wr num proc near;
	push ax
	push cx
	and dl, 0fh
	add dl,30h
	mov ah,02
	int 21h
	pop cx
	pop ax
	ret
wr num endp
wr plus proc near;
	push ax
	push dx
	mov dl, 28h
	mov ah,02
	int 21h
	pop ax
	pop dx
	ret
wr plus endp
wr ravno proc near;
	push ax
	push dx
	mov ah,02
	int 21h
	pop ax
	pop dx
	ret
wr ravno ednp
CODE_SEG ends
	end start