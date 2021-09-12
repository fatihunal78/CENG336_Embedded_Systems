   ORG 100H

SEGMENT CODE
	MOV AX, 0003h
	INT 10H			; ekraný sil

START:
	MOV CL, 07h
	
	MOV BH, 00h		;bh outputu tutuyor
	MOV BL, 10000000b
	
level3:	OR BH, BL

	MOV AL, BH
	MOV DX, 378h
	OUT DX, AL

	MOV DX, 379H
	IN AL, DX
	
	AND AL, 00010000b
	CMP AL, 00010000b
	JE level7

	NOT BL
	AND BH, BL
	NOT BL

level7:	CMP CL, 0
	JE level9
	DEC CL

	mov ah, 1
	int 16h
	jz level8
	mov ah, 0
	int 16h
	CMP AL, 'Q'
	JE E
	CMP AL, 'q'
	JE E
	JNE level8

E:	MOV AH, 4CH		; Programi bitir
	INT 21H

level8:	SHR BL, 1
	JMP level3
	
level9:	MOV DI, 0
	MOV SI, MSG

	MOV AX, 0XB800		; 
	MOV ES, AX		; 
	
	MOV BL, BH
	AND BL, 10000000b
	CMP BL, 10000000b
	JE bit1
	MOV AL, 30h		; 0
	JMP bit2
bit1:	MOV AL, 31h		; 1
bit2:	MOV [ES:DI],AL
	ADD DI, 2

	MOV BL, BH
	AND BL, 01000000b
	CMP BL, 01000000b
	JE bit3
	MOV AL, 30h		; 0
	JMP bit4
bit3:	MOV AL, 31h		; 1
bit4:	MOV [ES:DI],AL
	ADD DI, 2

	MOV BL, BH
	AND BL, 00100000b
	CMP BL, 00100000b
	JE bit5
	MOV AL, 30h		; 0
	JMP bit6
bit5:	MOV AL, 31h		; 1
bit6:	MOV [ES:DI],AL
	ADD DI, 2

	MOV BL, BH
	AND BL, 00010000b
	CMP BL, 00010000b
	JE bit7
	MOV AL, 30h		; 0
	JMP bit8
bit7:	MOV AL, 31h		; 1
bit8:	MOV [ES:DI],AL
	ADD DI, 2

	MOV BL, BH
	AND BL, 00001000b
	CMP BL, 00001000b
	JE bit9
	MOV AL, 30h		; 0
	JMP bit10
bit9:	MOV AL, 31h		; 1
bit10:	MOV [ES:DI],AL
	ADD DI, 2

	MOV BL, BH
	AND BL, 00000100b
	CMP BL, 00000100b
	JE bit11
	MOV AL, 30h		; 0
	JMP bit12
bit11:	MOV AL, 31h		; 1
bit12:	MOV [ES:DI],AL
	ADD DI, 2

	MOV BL, BH
	AND BL, 00000010b
	CMP BL, 00000010b
	JE bit13
	MOV AL, 30h		; 0
	JMP bit14
bit13:	MOV AL, 31h		; 1
bit14:	MOV [ES:DI],AL
	ADD DI, 2

	MOV BL, BH
	AND BL, 00000001b
	CMP BL, 00000001b
	JE bit15
	MOV AL, 30h		; 0
	JMP bit16
bit15:	MOV AL, 31h		; 1
bit16:	MOV [ES:DI],AL
	ADD DI, 2

JMP START
ENDPROG:
	MOV AH, 4CH		; Programi bitir
	INT 21H
		

SEGMENT DATA
	MSG: db 'Enter a number or `Q`:$', 13, 10, '$'



