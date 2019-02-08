.MODEL SMALL
.STACK 100h
.DATA
    str1 BYTE "enter a charcter:$"
    str2 BYTE 10,13,"you enter $"
.CODE
  MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV AH,9              ;string output
    MOV DX,OFFSET str1     
    INT 21h
    MOV AH,1              ;character input
    INT 21h
    MOV BL,AL             ;copying input
    CMP BL,'a'
    JGE L2
L1:
    ADD BL,32             ;converting to lower case
    JMP L3
L2:
    SUB BL,32             ;converting to upper case
L3:
    MOV AH,9
    MOV DX,OFFSET str2    ;string output
    INT 21h
    MOV AH,2
    MOV DL,BL             ;printing result
    INT 21h
    MOV AH,4Ch
    INT 21h
  MAIN ENDP
END MAIN