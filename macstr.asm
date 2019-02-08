.MODEL SMALL
.STACK 100h
.DATA
	count=50
	new_line MACRO
		MOV AH,2
		MOV DL,10
		INT 21h
		MOV DL,13
		INT 21h
	ENDM
	keyboard STRUCT
		maxInput BYTE count
		inputCount BYTE ?
		buffer BYTE count DUP(?)
	keyboard ENDS
	kb keyboard <>
.CODE
  	MAIN PROC
		MOV AX, @DATA
		MOV DS, AX 
		MOV AH,0AH
		MOV DX,OFFSET kb
		INT 21h
		MOV AL,kb.inputCount
		MOV AH,0
		MOV SI,AX
		INC SI
		MOV kb.buffer[SI],'$'
		new_line
		new_line
		MOV AH,9
		MOV DX,OFFSET kb.buffer
		INT 21h
		MOV AH,4Ch
    	INT 21h
  	MAIN ENDP
END MAIN