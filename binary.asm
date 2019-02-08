.MODEL SMALL
.STACK 100h
.386
.DATA
	 a DW 0
.CODE
  	MAIN PROC
		MOV AX,@DATA
		MOV DS,AX
		CALL INDEC
		MOV a,AX
		MOV CX,16
		L1:
			ROL a,1
			JC CARRY_1
			JNC CARRY_0
		CARRY_1:
			MOV AH,2
			MOV DL,'1'
			INT 21h
		JMP L2
		CARRY_0:
			MOV AH,2
			MOV DL,'0'
			INT 21h
		L2:
			LOOP L1
		MOV AH,4Ch
    	INT 21h
  	MAIN ENDP
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