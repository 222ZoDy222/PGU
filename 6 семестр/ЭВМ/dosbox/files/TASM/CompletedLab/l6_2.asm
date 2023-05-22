stseg   segment para    stack
        dw      16      dup(?)
stseg   ends
dseg    segment para
numSymb  dw  640  ; для одной части трикотора нужно 640 символов
mas     db  'Gorbunov Isaev'
masLen	dw 14
x		dw 	80
y		dw	25
dseg    ends
cseg    segment para


lab6    proc    far
        assume  cs:cseg,ds:dseg,ss:stseg
        push    ds
        mov     ax,0
        push    ax
        mov     ax,dseg
        mov     ds,ax
		
		
		; видео режим - 3 (цветной текст 80*25)
		mov ah, 00h
		mov al, 3
		int 10h
		
		mov dh,0
		mov cx, numSymb
		mov bl, 0h
		call printLine
		
		mov dh, 8
		mov cx, numSymb
		mov bl, 40h
		call printLine

		mov dh, 16
		mov cx, numSymb
		add cx, 80
		mov bl, 60h
		call printLine
		
		
		; выставить курсор на середину
		mov ah, 02h
		mov bh, 0
		mov dh, 12
		mov dl,30
		int 10h
		
		; вывод имени
		lea si, mas
		mov ah, 0eh
		mov cx, masLen
		
		printName:
		mov al, [si]
		int 10h
		inc si
		loop printName
		
		
		; нужно для остановки приложения, чтобы увидеть вывод
		mov ah, 00h
		int 16h
		
	  
		ret
lab6    endp

; параметры - dh - строка, с которой начинается вывод, bl - байт атрибута, cx- число символов
printLine proc near

		; установка позиции курсора
		mov ah, 02h
		mov bh, 0
		mov dl,0
		int 10h
		
		mov ah, 9
		mov al, 20h	; пробел
		mov bh, 0	; видеостраница
		int 10h
		ret

printLine endp 

cseg    ends
        end     lab6



