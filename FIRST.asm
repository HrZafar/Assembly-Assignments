.MODEL SMALL
.STACK 100h
.DATA
    str1 BYTE "enter a charcter(small case):$"
    str2 BYTE "you enter $"
.CODE
  MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV AH,9              ;string output
    MOV DX,OFFSET str1     
    INT 21h
    MOV AH,1              ;charcter input
    INT 21h
    MOV BL,AL             ;copying input
    MOV AH,2
    SUB BL,32             ;converting to upper case
    INT 21h
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