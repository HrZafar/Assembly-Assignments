.MODEL SMALL
.STACK 100h
.DATA
	STR1 BYTE "HArIs ZafAR 1234 56"
	VWL BYTE 0
	CNS BYTE 0
	DGT BYTE 0
	SPC BYTE 0
	STR2 BYTE "CONSONANTS: $"
	STR3 BYTE 10,13,"VOWELS: $"
	STR4 BYTE 10,13,"DIGITS: $"
	STR5 BYTE 10,13,"SPACES: $"
.CODE
  MAIN PROC
	MOV AX,@DATA
	MOV DS,AX
	MOV CX,LENGTHOF STR1
	SUB CX,2
	MOV SI,0
	L1:
		CMP STR1[SI],'A'
		JE VOWEL
		CMP STR1[SI],'a'
		JE VOWEL
		CMP STR1[SI],'E'
		JE VOWEL
		CMP STR1[SI],'e'
		JE VOWEL
		CMP STR1[SI],'I'
		JE VOWEL
		CMP STR1[SI],'i'
		JE VOWEL
		CMP STR1[SI],'O'
		JE VOWEL
		CMP STR1[SI],'o'
		JE VOWEL
		CMP STR1[SI],'U'
		JE VOWEL
		CMP STR1[SI],'u'
		JE VOWEL
		INC SI
	LOOP L1
	MOV CX,LENGTHOF STR1
	SUB CX,2
	MOV SI,0
	L2:
		CMP STR1[SI],' '
		JE SPACE
		CMP STR1[SI],'0'
		JE DIGIT
		CMP STR1[SI],'1'
		JE DIGIT
		CMP STR1[SI],'2'
		JE DIGIT
		CMP STR1[SI],'3'
		JE DIGIT
		CMP STR1[SI],'4'
		JE DIGIT
		CMP STR1[SI],'5'
		JE DIGIT
		CMP STR1[SI],'6'
		JE DIGIT
		CMP STR1[SI],'7'
		JE DIGIT
		CMP STR1[SI],'8'
		JE DIGIT
		CMP STR1[SI],'9'
		JE DIGIT
		INC SI
	LOOP L2
	JMP CONSONANT
	VOWEL:
		INC VWL
		INC SI
		JMP L1
	DIGIT:
		INC DGT
		INC SI
		JMP L2
	SPACE:
		INC SPC
		INC SI
		JMP L2
	CONSONANT:
		ADD BL,VWL
		ADD BL,DGT
		ADD BL,SPC
		MOV CNS,LENGTHOF STR1
		SUB CNS,BL
	L3:
	ADD CNS,48
	ADD VWL,48
	ADD DGT,48
	ADD SPC,48
	MOV AH,9
	MOV DX,OFFSET STR2
	INT 21h
	MOV AH,2
	MOV DL,CNS
	INT 21h
	MOV AH,9
	MOV DX,OFFSET STR3
	INT 21h
	MOV AH,2
	MOV DL,VWL
	INT 21h
	MOV AH,9
	MOV DX,OFFSET STR4
	INT 21h
	MOV AH,2
	MOV DL,DGT
	INT 21h
	MOV AH,9
	MOV DX,OFFSET STR5
	INT 21h
	MOV AH,2
	MOV DL,SPC
	INT 21h
    MOV AH,4Ch
    INT 21h
  MAIN ENDP
END MAIN