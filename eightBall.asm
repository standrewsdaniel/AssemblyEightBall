; Daniel St Andrews
; Magic 8 ball emulator
; Calling a subroutine in 64-bit mode    (eightBall.asm)

 ;Irvine64 Prototypes
ExitProcess proto
WriteHex64 PROTO         ; Irvine64 library
Crlf PROTO               ; Irvine64 library

WriteString proto
ReadString PROTO

WriteInt64 proto
ReadInt64 proto

Random64 proto
RandomRange proto
Randomize proto


 ;Add appropriate prompts:
.data
	prompt1 byte  "Pick your lucky number:  ", 0
	prompt2 byte  "What is your question?  ", 0
	prompt3 byte  "Magic 8 Ball says:  ", 0
	ans1 byte  "It is certain  ", 0
	ans2 byte  "Outlook Good  ", 0
	ans3 byte  "Don't count on it  ", 0
	ans4 byte  "My sources say no  ", 0
	ans5 byte  "Better not tell you now  ", 0
	keyVal QWORD ?
	divisor byte 5
	
.code
 main PROC
	;Output message to ask for lucky number:
	MOV RDX, OFFSET prompt1
	CALL WriteString
	call Crlf
	Call ReadInt64
	MOV keyVal, RAX

	; Determine random number:
	Call Randomize
	Call Random64

	; Convert number to the appropriate range:
	MOV RAX, OFFSET keyVal
	MOV EAX, [RAX]
	call RandomRange
	PUSH RAX
	
	;Output message to ask for question:
 	MOV EDX, OFFSET prompt2
	CALL WriteString
	call Crlf
	MOV RCX, 51
	CALL Readstring

	;Output message to to answer question:
	MOV RDX, OFFSET prompt3
	CALL WriteString
	call Crlf
	MOV RDX, 0
	POP RAX

	;Determine result:
	DIV divisor
	CMP RAX, 00
	JE THEN1
	CMP RAX, 1
	JE THEN2
	CMP RAX, 2
	JE THEN3
	CMP RAX, 3
	JE THEN4
	CMP RAX, 4
	JE THEN5

	THEN1:
	MOV RDX, OFFSET ans1
	JMP ENDIF1

	THEN2:
	MOV RDX, OFFSET ans2
	JMP ENDIF1

	THEN3:
	MOV RDX, OFFSET ans3
	JMP ENDIF1

	THEN4:
	MOV RDX, OFFSET ans4
	JMP ENDIF1

	THEN5:
	MOV RDX, OFFSET ans5
	JMP ENDIF1

	ENDIF1:
	;Output the message
	call WriteString			;Output message
	call Crlf

 mov  ecx,0				; Process return code
 call    ExitProcess

main ENDP
END

comment $

~~~~~~~~~~~~~~~~~~~~~~

$