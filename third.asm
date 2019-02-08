.MODEL SMALL
.STACK 100h
.DATA
    str1 BYTE "enter a character: $"
    str2 BYTE 10,13,"you enter $"
    str3 BYTE 10,13,"Enter a character or E to exit: $"
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
L4:
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
    MOV AH,9
    MOV DX,OFFSET str3    ;string output
    INT 21h
    MOV AH,1              ;character input
    INT 21h
    MOV BL,AL             ;copying input
    CMP BL,'E'
    JNE L4
    MOV AH,4Ch
    INT 21h
  MAIN ENDP
END MAIN