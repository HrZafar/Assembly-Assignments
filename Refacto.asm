.model small
.stack 100h
.data
.code
main proc
mov ax,@data
mov ds,ax

CALL INDEC
PUSH AX
call fact
call outdec

mov ah,4ch
int 21h
main endp
fact proc
mov bp,sp
mov ax,word ptr[bp+2]
cmp ax,1
je l2
dec ax
push ax
call fact
mov bp,sp
mov bx,word ptr[bp+2]
mul bx
ret 2
l2:
mov ax,1
ret 2
fact endp

outdec proc
 push ax
 push bx
 push cx
 push dx

 mov cx,0
 cmp ax,0
 jge else_label
 push ax
 mov ah,2
 mov dl,'-'
 int 21h
 pop ax
 neg ax

else_label:
 mov bx,10
 mov dx,0
 div bx
 push dx
 inc cx
 cmp ax,0
 jne else_label
 mov ah,2
 print_label:
 pop dx
 add dx,30h
 int 21h
 loop print_label
 pop dx
 pop cx
 pop bx
 pop ax
 ret

 outdec endp
INDEC PROC 
		PUSH BX
		PUSH CX
		PUSH DX
		begin:
			MOV CX,0
			MOV BX,0
			MOV AH,1
			INT 21h
			CMP AL,'-'
			JE minus
			CMP AL,'+'
			JE plus
			JMP rep_loop
		minus:
			MOV CX,1
		plus:
			INT 21h
		rep_loop:
			CMP AL,'0'
			JL invalid
			CMP AL,'9'
			JG invalid
			SUB AL,30h
			MOV AH,0
			PUSH AX
			MOV AX,10
			MUL BX
			POP BX
			ADD BX,AX
			MOV AH,1
			INT 21h
			CMP AL,13
			JNE rep_loop
			MOV AX,BX
			CMP CX,0
			JE exit
			NEG AX
		exit:
			POP DX
			POP CX
			POP BX
			RET
		invalid:
			MOV AH,2
			MOV DL,0Ah
			INT 21h
			MOV DL,0Dh
			INT 21h
			JMP begin
	INDEC ENDP


end main