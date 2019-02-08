.MODEL SMALL
.STACK 100h
.DATA
    str1 BYTE "enter a hexadecimal value:$"
    str2 BYTE 10,13,"decimal: $"
    a BYTE "10$"
    b BYTE "11$"
    CC BYTE "12$"
    d BYTE "13$"
    e BYTE "14$"
    f BYTE "15$"
    inv BYTE "invalid$"
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
    MOV AH,9
    MOV DX,OFFSET str2    ;string output
    INT 21h
    CMP BL,'A'
    JE L1
    CMP BL,'B'
    JE L2
    CMP BL,'C'
    JE L3
    CMP BL,'D'
    JE L4
    CMP BL,'E'
    JE L5
    CMP BL,'F'
    JE L6
    JMP L8
    L1:
        MOV AH,9
        MOV DX,OFFSET a    ;string output
        INT 21h
        JMP L9
    L2:
        MOV AH,9
        MOV DX,OFFSET b    ;string output
        INT 21h
        JMP L9
    L3:
        MOV AH,9
        MOV DX,OFFSET CC    ;string output
        INT 21h
        JMP L9
    L4:
       MOV AH,9
       MOV DX,OFFSET d    ;string output
       INT 21h
       JMP L9
    L5:
       MOV AH,9
       MOV DX,OFFSET e    ;string output
       INT 21h
       JMP L9
    L6:
       MOV AH,9
       MOV DX,OFFSET f    ;string output
       INT 21h
       JMP L9
    L8:
    MOV AH,2
    MOV DL,BL
    INT 21h
    L9:
       MOV AH,4Ch
       INT 21h
  MAIN ENDP
END MAIN