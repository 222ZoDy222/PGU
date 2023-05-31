stseg   segment para    stack
        dw      16      dup(?)
stseg   ends
dseg    segment para
names   db  'Filippov: Ivanov: Petrov: $'
res		db	'Result:'
res_len dw  7

str_date	db   	8 dup(?)	; считанная с клавиатуры строка ДД.ММ.ГГГГ

buffer			dw 	0
average_day		dw	0
average_month	dw	0
average_year	dw	0

num_iterations	dw	0

dseg    ends
cseg    segment para


lab7    proc    far
        assume  cs:cseg,ds:dseg,ss:stseg
        push    ds
        mov     ax,0
        push    ax
        mov     ax,dseg
        mov     ds,ax
		
		; видео режим
		mov ah, 00h
		mov al, 4
		int 10h
		
		call cleanBuf
		
		lea si, names
		get_dates:
		
		; печать очередного имени (до пробела)
		mov ah, 0eh
		mov bl, 3
		print:
		mov al, [si]
		int 10h
		inc si
		cmp byte ptr [si], ' '
		jne print
		inc si	; смещение на начало следующего имени или символа конца
		push si	; сохранить si, т.к. он потом используется
		
		; чтение даты
		lea si, str_date
		call  getDate
		
		call newLine
		
		; перевод дня
		mov buffer,0
		mov cx, 2
		lea di, buffer
		call asciiToBin
		mov ax, average_day
		add ax, [di]
		mov average_day, ax
		
		mov buffer, 0
		inc si
		inc si	; перевод на месяц
		call asciiToBin
		mov ax, average_month
		add ax, [di]
		mov average_month, ax
		
		mov buffer,0
		inc si
		inc si
		add cx, 2
		call asciiToBin
		mov ax, average_year
		add ax, [di]
		mov average_year,ax
		
		add num_iterations, 1		; увеличить счетчик дат
		; восстановить si, проверить на окончание вывода
		pop si
		cmp byte ptr [si], '$'
		jne get_dates
		
		;выполнить деление для получения 
		mov ax, average_day
		mov bx, num_iterations
		cwd
		div bx
		mov average_day, ax
		
		mov ax, average_month
		mov bx, num_iterations
		cwd
		div bx
		mov average_month, ax
		
		mov ax, average_year
		mov bx, num_iterations
		cwd
		div bx
		mov average_year, ax
		
		lea di, str_date
		mov ax, average_day
		mov cx, 2
		call binToAscii
		
		inc di
		inc di
		mov ax, average_month
		mov cx, 2
		call binToAscii
		
		inc di
		inc di
		mov ax, average_year
		mov cx, 4
		call binToAscii
		
		; вывод результата
		lea si, res
		mov cx, res_len 
		call printString
		
		lea si, str_date
		mov cx,8
		call printString
		
		; нужно для остановки приложения, чтобы увидеть вывод
		mov ah, 00h
		int 16h
		ret
lab7 endp


; процедура считывания даты в виде строки, si - указатель на память, в которую будут
; записаны ascii символы строки
getDate proc near
		push si
		push cx
		mov cx,8
		read:
		mov ah,0
		int 16h
		mov [si], al
		inc si
		mov ah, 0eh
		int 10h
		loop read
		pop cx
		pop si
		ret
getDate endp
		
; процедура печати строки. параметры: SI - адрес строки, CX - число символов
printString proc near
	
	push si
	push cx
	mov ah, 0eh
	mov bl, 3
	.print:
	mov al, [si]
	
	int 10h
	inc si
	loop .print
	pop cx
	pop si
	ret
printString endp		

; Преобразование строки ASCII в двоичный вид
; si - адрес ascii-представления
; cx - число символов
; di - адрес двойного слова для результата

asciiToBin	proc near
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	
	mov bx,1	; множитель
	add si, cx	; адрес конца массива
	dec si
	convert:
	xor ax, ax
	mov al, [si]
	sub al, 30h
	mul bx
	add [di], ax
	mov ax, bx
	mov bx,10
	mul bx
	mov bx, ax
	dec si
	loop convert
	
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret
asciiToBin endp

; преобразование числа в ascii строку, 
; ax - число
; di - указатель на строку для вывода
; cx - длина строки для вывода в байтах
binToAscii 	proc  near
	
	push ax
	push di
	push dx
	push cx
	
	add di, cx	; перемещение указателя в конец массива
	dec di
	; проверка, если число меньше 10, нужно будет добавить ноль
	cmp ax, 10
	jae a
	mov bx, 1
	push bx ; если в вершине стека единица. то число меньше 10, нужно внести 0 в результирующую строку
	jmp to_conv
	a:
	mov bx, 0; если ноль, то дополнительные значения не нужны
	push bx
	
	to_conv:
	mov bx,10
	.convert:
	cwd
	div bx
	mov [di],dl
	add [di], byte ptr 30h
	dec di
	cmp ax,0
	jne .convert
	
	pop bx
	cmp bx,1
	jne b
	mov [di], byte ptr '0'
	b:
	
	pop cx
	pop dx
	pop di
	pop ax
	ret
binToAscii endp

newLine proc near
	push ax
	push bx
	mov ah,0Eh
	mov bl,3
	mov al, 0Dh ;/r
	int 10h
	mov al, 0Ah
	int 10h
	
	pop bx
	pop ax
	ret
newline endp

cleanBuf proc near

	circle:
	mov ah,01h
	int 16h
	jz quit
	
	; чтение символа
	mov ah,0
	int 16h
	
	jmp circle
	quit:
	ret
	
cleanBuf endp

cseg    ends
        end     lab7



