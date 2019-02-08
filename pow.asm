.MODEL SMALL
.STACK 100h
.DATA
	pow WORD 0
	base WORD 0
.CODE
  	MAIN PROC
	MOV AX, @DATA
	MOV DS, AX 
		CALL INDEC
		MOV base,AX
		CALL INDEC
		MOV pow,AX
		PUSH base
		PUSH pow
		
		
		CALL POWER
		CALL OUTDEC
		MOV AH,4Ch
    	INT 21h
  	MAIN ENDP
	POWER PROC
		MOV BP,SP
		MOV BX,WORD PTR[BP+2]	;power
		MOV CX,WORD PTR[BP+4]
		CMP BX,0
		JLE exit_label
		DEC BX
		PUSH CX
		PUSH BX
		CALL POWER
		MUL CX
		RET 4
		exit_label:
			MOV AX, 1
			RET 4
			POWER ENDP
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