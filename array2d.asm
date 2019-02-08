.MODEL SMALL
.STACK 100h
.DATA
	arr BYTE 1,2,3,4,5,6,7,8,9,10,11,12
	noc=4
	nor=3
	a BYTE 0
.CODE
  	MAIN PROC
		MOV AX, @DATA
		MOV DS, AX 
		MOV BX,0
		PUSH BX
		loop1:
			CMP a,nor
			JE exit
			MOV AL,0
			MOV SI,0
			MOV CX,noc
		loop2:
			ADD AL,BYTE PTR arr[BX+SI]
			INC SI
			LOOP loop2
			MOV AH,0
			CALL OUTDEC
			MOV AH,2
			MOV DL,10
			INT 21h
			MOV AX,noc
			POP BX
			INC BX
			PUSH BX
			MUL BX
			MOV BX,AX
			INC a
			JMP loop1
		exit:
		MOV AH,4Ch
    	INT 21h
  	MAIN ENDP
	
	OUTDEC PROC
		PUSH AX
		PUSH BX
		PUSH CX     
		PUSH DX
		MOV CX,0
		CMP AX,0
		JGE else_label
		PUSH AX
		MOV AH,2
		MOV DL,'-'
		INT 21h
		POP AX
		NEG AX
		else_label:
			MOV BX,10
			MOV DX,0
			DIV BX
			PUSH DX
			INC CX
			CMP AX,0
			JNE else_label
			MOV AH,2
		print_label:
			POP DX
			ADD DL,30h
			INT 21h
			LOOP print_label
		POP DX
		POP CX
		POP BX
		POP AX
		RET
	OUTDEC ENDP
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

END MAIN