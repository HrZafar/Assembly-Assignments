.MODEL SMALL
.STACK 100h
.DATA
  src BYTE "HAHAH HAHAH"
  trg BYTE SIZEOF src DUP(0)
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
        MOV SI,0
        for_loop_2:
		MOV AH,2
		MOV DL,BYTE PTR trg[SI]
		INT 21h
		INC SI
        LOOP for_loop_2
    MOV AH,4Ch
    INT 21h
  MAIN ENDP
END MAIN