stseg   segment para    stack
        dw      16      dup(?)
stseg   ends
dseg    segment para

Notes			dw		4571, 4072, 3626, 3418, 3043, 2711, 2420
					;ноты До, Ре, Ми, Фа, Соль, Ля, Си
Num_notes 		dw      7
dseg    ends
cseg    segment para


lab7    proc    far
        assume  cs:cseg,ds:dseg,ss:stseg
        push    ds
        mov     ax,0
        push    ax
        mov     ax,dseg
        mov     ds,ax
		GATE			EQU		61h		; порт, бит 1 - разрешающий работу динамика
		COMMAND_REG 	EQU 	43h		; командный регистр
		CHANNEL_2 		EQU 	42h		; канал 2 таймера
		PLUS			EQU		2Bh
		MINUS			EQU		2Dh
		ESCAPE			EQU		1Bh
		
		
		lea si, Notes
		mov cx, Num_notes
		; cx - верхняя граница массива
		sub cx,1
		sal cx,1				
		
		new_note:
		call SoundStop
		
		; установка порта 43
		mov al, 10110110b
		out COMMAND_REG, al
		
		mov ax, [si]
		out CHANNEL_2, al
		mov al, ah
		out CHANNEL_2, al
		
		call SoundStart
		
		; ожидание нажатия клавиши
		wait_key:
		mov ah,0
		int 16h
		
		cmp	al, ESCAPE	; завершение работы
		je exit
		
		cmp al, PLUS	; следующая нота
		je high_note
		
		cmp al, MINUS
		je low_note		; предыдущая нота
		
		; неизвестная клавиша
		jmp wait_key
		
		high_note:
		; обработка прибавления
		cmp si,	cx
		je wait_key ; если верхняя граница массива, ничего не делать
		inc si
		inc si
		jmp new_note
		
		low_note:
		; обработка уменьшения
		cmp si,0
		je wait_key
		dec si
		dec si
		jmp new_note
		
		exit:
		call SoundStop
		
		ret
lab7 endp

; подключение таймера к динамику
SoundStart proc near
		in al, GATE
		or al, 11111111b
		out GATE, al
		ret
SoundStart endp

; отключение таймера от динамика
SoundStop proc near
		in al, GATE
		and al, 11111110b
		out GATE, al
		ret
SoundStop endp

cseg    ends
        end     lab7



