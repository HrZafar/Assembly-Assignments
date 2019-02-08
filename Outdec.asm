.MODEL SMALL
.STACK 100h
.DATA
.CODE
  	MAIN PROC
		MOV AX,32767
		CALL OUTDEC
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
END MAIN