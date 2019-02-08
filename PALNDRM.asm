.MODEL SMALL
.STACK 100h
.DATA
  src BYTE "HAHAHAHAH"
  trg BYTE SIZEOF src DUP(0)
  A BYTE "PALINDROME.....$"
  B BYTE "NOT A PALINDROME.....$"
.CODE
	MAIN PROC
	MOV AX,@DATA
	MOV DS,AX
	MOV SI,LENGTHOF src
        DEC SI
	MOV DI,0
	MOV CX,LENGTHOF src
	for_loop_1:
		MOV BL,src[SI]
		MOV trg[DI],BL
		DEC SI
                INC DI
    	LOOP for_loop_1
	MOV CX,LENGTHOF trg
        MOV DI,0
        for_loop_2:
		MOV BL,src[DI]
		CMP trg[DI],BL
		JNE L3
		INC DI
        LOOP for_loop_2
	JMP L4
	L3:
		MOV AH,9
		MOV DX,OFFSET B
		INT 21h
		JMP L5
	L4:
		MOV AH,9
		MOV DX,OFFSET A
		INT 21h
L5:
	MOV DI,LENGTHOF trg
	MOV trg[DI],'$'
        MOV AH,9
	MOV DX,OFFSET TRG
	INT 21h
    MOV AH,4Ch
    INT 21h
  MAIN ENDP
END MAIN