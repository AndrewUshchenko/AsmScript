;------------------------------------------------
;============Практическое задание================
;----Дана строка, состоящая из слов, разделенных любым количеством пробелов.
;----Напишите программу , которая редактирует это предложение , удаляя символ, 
;----встречающийся подряд более , чем один раз
;@author Andrew Ushchenko (https://github.com/AndrewUshchenko) <andrew@uas-proger.net>

;-----Start code-----
formList segment 'code'
assume CS:formList, DS:data

;---Start process
begin: mov AX,data
	mov DS,AX ;Not data->DS
	
	mov	AH, 09h
	mov DX, offset helloMsg
	int	21h		; приглашение на экран

	mov	AH, 0ah
	lea DX,buf
	int	21h		; вводим строку

	mov	AH, 09h
	mov DX,offset resultMsg
	int	21h		; Result string

	mov DX, offset newLine
	int 21h
	
	lea	SI, string	; адрес строки
	mov	DH, 0		; предыдущий символ
	mov BL,0
FOREACH:
	inc BL
	lodsb			; очередной
	cmp	AL, 0dh		; введенная строка заканчивается кодом 0dh
	je	exit
	cmp	AL, DH		; совпадает с предыдущим?
	je	FOREACH
	mov	DH, AL		; сохраним
	
	cmp BL,1
	jle FOREACH
	mov AH,02h
	mov DL,offset DH
	int	21h		; и выведем
	jmp	FOREACH

exit:
	mov	AH, 09h
	mov DX, offset endMsg
	int	21h
	
	mov	AX, 4c00h
	int	21h
formList	ends	;End CodeSegment (CS)

data segment	;Here data (string message, value)
	helloMsg		db	10,'Hello, please enter string',10,'$'	
	newLine			db 10,'$'
	resultMsg		db 10,'Result string: $'
	endMsg			db 10,'DONE!$'

	buf				db  128; буфер для приема строки с клавиатуры 
	string 			db 	128
data ends		;End DataSegment

stk segment stack
	dw 128 dup(0)
stk	ends

end	begin;End
