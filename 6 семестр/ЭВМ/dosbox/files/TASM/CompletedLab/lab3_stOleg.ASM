stseg   segment para    stack
        dw      16      dup(?)
stseg   ends
dseg    segment para
mas       dw      -8,-3,-2,-6,-5,-22,-54,-3
y         dw      ?
dseg    ends
cseg    segment para
 assume  cs:cseg,ds:dseg,ss:stseg
;передача через стек, порядок: адрес массива, число элементов, адрес возврата
find_max proc near
		
		push dx
		push cx
		push si
		push bp
		mov  bp, sp	; указатель на вершину, ниже - IP, размер массива, адрес массива вершину стека

		mov si,[bp+12]	; cохранение адреса массива
		mov cx,[bp+10]   ; сохранение числа элементов 
		mov dx, [si] 		;в dx хранится промежуточное максимальное значение
        circle:
        cmp dx, [si]
        jge less		     ; первое число больше или равно, следующая итерация
        mov dx, [si]		; сохранение нового максимума
        less:
        inc si
        inc si
        loop circle
		
		mov [bp+12], dx ; сохранение результата на дно стека
		
		pop bp
		pop si
		pop cx
		pop dx
		
		; Восстановление регистров
        ret 2  ; удаление из стека второго значения, остается только результат.
find_max endp

lab3_reg    proc    far
       
        push    ds
        mov     ax,0
        push    ax
        mov     ax,dseg
        mov     ds,ax

       
        lea ax, mas	
		push ax		;адрес массива 		;установка числа повторений цикла
		mov ax,8
		push ax
		call find_max
		pop ax
		mov y,ax
       ret
lab3_reg    endp
cseg    ends
        end     lab3_reg



