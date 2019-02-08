.MODEL SMALL
.STACK 100h
.DATA
  B WORD 0
  A WORD 0
.CODE
  MAIN PROC
	MOV AX, 5
	MOV A, AX
	MOV AX, 6
	MOV B, AX
    MOV CX,5
    for_loop_2:
       MOV BX,CX
       MOV CX,A
    for_loop_1:
       MOV AH,2
       MOV DL,'*'
       INT 21h
    LOOP for_loop_1
       SUB A,1
       DEC B
	MOV CX, B
	MOV AH,2
       MOV DL,10
       INT 21h
    LOOP for_loop_2
    MOV AH,4Ch
    INT 21h
  MAIN ENDP
END MAIN