;------------------------------------------------
;============Практическое задание================
;----Сформироать список, состоящий из всех простых делителей натурального числа N
;----(число в пределах от 0 до 25) и посчитать количество делителей 
;@author Andrew Ushchenko (https://github.com/AndrewUshchenko) <andrew@uas-proger.net>

;-----Start code-----
formList segment 'code'
assume CS:formList, DS:data

;---Start process
begin: mov AX,data
	mov DS,AX ;Not data->DS
	
	mov AH,09h	
	mov DX, offset 	helloMsg
	int 21h		

	mov AH,02h
	mov DL,'>'
	int 21h
	mov DI,0
INPUT:;Get N
	mov AH,08h
	int 21h
	
	cmp AL,13;enter key
		je DONE
	
	cmp Al,'9'
		ja INPUT
	
	cmp AL,'0'
		jb INPUT
	;Input num
	mov AH,02h
	mov DL,Al;display num
	int 21h
	
	sub AL,'0'
	xor AH,AH
	mov CX,AX
	mov AX,DI
	mov BX,10
	mul BX
	add AX,CX
	mov DI, AX
	jmp INPUT
	
DONE:	mov AX,DI
		mov N,AX
		cmp AX,26;calculate range num
			jnc MAX
		jmp CALC
MAX:	mov DX, offset maxMsg;display error
		mov AH,09h
		int 21h
	
CALC:;get count del
	mov dx,0
	mov cl,25
	Find:
		push ax
		idiv cl
		cmp AH,0
			je PRINT
		RETURNF:pop ax
	loop Find
	
	PRINT:
		
		mov AH,09h
		mov DX, offset newLine
		int 21h
		
		;-----Code for current display num
		aam
		add ax,3030h 
		mov dl,ah 
		mov dh,al 
		mov ah,02 
		int 21h 
		mov dl,dh 
		int 21h
		
		inc count

		cmp cl,0
		jne RETURNF
		
		mov AH,09h
		mov DX, offset newLine
		int 21h
		
		mov dx,0
		mov AH,09h
		MOV DX, offset countMsg
		int 21h
		dec count
		mov AH,09h
		add count,30h
		MOV DX, offset count
		int 21h
		
		mov DX, offset finishMsg
		int 21h
ENDSCRIPT:		mov AH,4ch	;End program
		int 21h
formList	ends	;End CodeSegment (CS)

data segment	;Here data (string message, value)
	helloMsg		db	10,'Hello, please enter N',10,'$'	
	maxMsg				db 	10,'Your num > 25$'
	N				dw 10 dup(?)
	newLine			db 10,'$'
	countMsg		db 'Count: $'
	count 			db 3 dup(0),'$'
	finishMsg		db 10,'Done!$'
data ends		;End DataSegment

stk segment stack
	dw 128 dup(0)
stk	ends

end	begin;End

