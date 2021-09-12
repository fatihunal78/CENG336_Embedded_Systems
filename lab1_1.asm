

   ORG 100H

SEGMENT CODE
	MOV AX, 0003H
	INT 10H			; ekrani sil

	MOV DH, 0

	MOV AX, 0XB800		; 
	MOV ES, AX		; 
	MOV DI, 0		; 
BASLA:	MOV SI, MSG		; 
	MOV CX, 0000H
    	PUSH CX

   P:	MOV AL,[DS:SI]
	CMP AL, '$'
	JE endP
	MOV [ES:DI],AL
	ADD DI, 2
	INC SI
	JMP P
   endP:

	ADD DI, 2
	MOV AH, 2		; set cursor position
	MOV BH, 0		; to the end of the
				; message
	MOV DL, 22
	INT 10H

OKU: 	MOV AH, 3
	MOV BH, 0
	INT 10H

	MOV AH, 2		; set cursor position
	MOV BH, 0		; to the end of the
	;MOV DH, 0		; message
	ADD DL, 1
	INT 10H
	
	MOV AH,0		; read a character
	INT 16H
	
	CMP AL, 0DH
	JE GECME
	JNE GEC

GECME:	ADD DH, 1
	POP CX
	PUSH DX
	PUSH AX
	MOV DX, 378h		
	;MOV [ES:DI],CL		; print entered value
	MOV AL, CL
	OUT DX, AL
	POP AX
	POP DX
	MOV AL, 160
	MUL DH
	MOV DI, 0
	ADD DI, AX
	JMP BASLA

GEC:	MOV [ES:DI],AL
	ADD DI, 2

	CMP AL, 'Q'
	JE ENDPROG

	CMP AL, 'q'
	JE ENDPROG

	POP CX
	PUSH AX
	MOV BL, 0AH		; BX= 10
	MOV AX, CX
	MOV AH, 00H
	MUL BL
	
	POP CX
	SUB CX, 0030h		; AL= AL - 48
	ADD AX, CX
	PUSH AX

	JMP OKU

ENDPROG:MOV AH, 4CH		; Programi bitir
	INT 21H
		

SEGMENT DATA
	MSG: db 'Enter a number or `Q`:$', 13, 10, '$'
