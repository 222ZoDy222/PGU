;программа активизации системы прерываний в защищенном режиме
;prog12.asm
.386P	;разрешение инструкций i386
.MODEL large
;
;структура для описания дескрипторов сегментов
descr	STRUC
limit	dw	0
base_1	dw	0
base_2	db	0
attr	db	0
lim_atr	db	0
base_3	db	0
	ENDS

;макрос инициализации дескрипторов
load_descr	MACRO	des,seg_addr,seg_size
	mov	des.limit,seg_size
	xor	eax,eax
	mov	ax,seg_addr
	shl	eax,4
	mov	des.base_1,ax
	rol	eax,16
	mov	des.base_2,al
	ENDM


;структура для описания записи в регистры gdtr и idtr
point	STRUC
lim	dw	0
adr	dd	0
	ENDS

;структура для описания дескрипторов таблицы idt
descr_idt	STRUC
offs_1	dw	0
sel	dw	30h	;селектор сегмента команд в таблице GDT
no_use	db	0
type_attr	db	8eh	;шлюз прерывания
offs_2	dw	0
	ENDS

;

stk	segment	stack 'stack' 
	db	256 dup (0)
stk	ends

;сегмент с таблицей глобальных дескрипторов
gdt_seg	segment	para public 'data' use16
gdt_0	descr	<0,0,0,0,0,0>
;описывает саму GDT
gdt_gdt_8	descr	<0,0,0,92h,0,0>
gdt_ldt_10	descr	<0,0,0,0,0,0>	;не используем
;дескриптор сегмента данных
gdt_ds_18	descr	<0,0,0,92h,0,0>
gdt_es_vbf_20	descr	<0,0,0,92h,0,0>	;видеобуфер
gdt_ss_28	descr	<0,0,0,92h,0,0>	;сегмент стека
gdt_cs_30	descr	<0,0,0,9ah,0,0>	;сегмент кода
gdt_size=$-gdt_0-1	;размер GDT минус 1
gdt_seg	ends

; сегмент с таблицей прерываний IDT

idt_seg	segment	para public 'data' use16
int00h	descr_idt	<dummy,,,,>
	REPT		2            ; то есть повторяем еще два раза
	descr_idt	<dummy,,,,>
	ENDM
int03h	descr_idt	<int_03h,,,,>
	descr_idt	<dummy,,,,>
int05h	descr_idt	<int_05h,,,,>
	REPT	7
	descr_idt	<dummy_err,,,,>
	ENDM
int0dh	descr_idt	<int_0dh,,,,>
	REPT	3
	descr_idt	<dummy,,,,>
	ENDM
int11h	descr_idt	<dummy_err,,,,>
	REPT	14
	descr_idt	<dummy,,,,>
	ENDM
int20h	descr_idt	<new_08h,,,,>
        descr_idt       <dummy,,,,>
	REPT	222
	descr_idt	<dummy,,,,>
	ENDM
idt_size=$-int00h-1      ; для вычисления размера IDT
idt_seg	ends

;данные программы
data	segment	para public 'data' use16	;сегмент данных
point_gdt	point	<gdt_size,0>
point_idt	point	<idt_size,0>
stroka          db    'идут прерывания от таймера в защищенном режиме'
dlina=$-stroka 
char     	db	'0'
maskf   	db	07h
position	dw	2015
cnt     	db	0	;счётчик для выхода из программы
data_size=$-point_gdt-1    ; размер сегмента данных
data	ends



code	segment	byte public 'code' use16
;сегмент кода с 16-разрядным режимом адресации
	assume	cs:code,ss:stk
dummy	proc	               ; обработчик исключения без кода ошибки
	mov	ax,0ffffh
	db	66h
	iret
	endp
dummy_err	proc	       ;обработчик исключения с кодом ошибки
	pop	eax     	;снимаем со стека код ошибки
	db	66h
	iret
	endp

int_03h	proc           ; обработчик прерывания 03h - это
                       ;         
                       ;для этого исключения не формируется кода ошибки,
;поэтому анализируем содержимое eip в стеке и возвращаемся в программу
	pop	eax
	push	eax
	db	66h
	iret
	endp
                       ; обработчик прерывания 05h - это
                       ; исключение при нарушении границ массива
int_05h	proc	       ;
	mov	al,5
	mov	ah,al
	mov	si,2
	db	66h
	iret
	endp

int_0dh	proc            ; обработчик прерывания 0dh - это нарушение
                        ; общей защиты 
	pop	eax	;снимаем со стека код ошибки
	sub	bx,4	;исправляем причину возникновения исключения
	db	66h	;возвращаемся обратно и рестарт виноватой команды
	iret
	endp

new_08h	proc	        ;новое прерывание от таймера
	assume	ds:data
	push	ds
	push	es
	push	ax
	push	bx
	mov	ax,20h
	mov	es,ax
scr:
	mov	al,char
	mov	ah,maskf
	mov	bx,position
	mov	es:[bx],ax
	add	bx,2
	mov	position,bx
	inc	char
        cmp     char,39h
        jle     met3
        mov     char,30h
met3:	pop	bx
	pop	ax
	pop	es
	pop	ds
	mov	al,20h
	out	20h,al
	db	66h
	iret
	endp
new_8259a	proc
;в al - значение нового базового
;вектора для ведущего контроллера
	push	ax
	mov	al,00010001b
	out	20h,al	;ICW1 в порт 20h
	jmp	$+2
	jmp	$+2	;эадержка, чтобы успела отработать аппаратура
	pop	ax
	out	21h,al	;ICW2 в порт 20h - новый базовый номер
	jmp	$+2
	jmp	$+2	;эадержка, чтобы успела
			;отработать аппаратура
	mov	al,00000100b
	out	21h,al	;ICW3 - ведомый подключается
			;к уровню 2 (см. рис. 15.1)
	jmp	$+2
	jmp	$+2	;эадержка, чтобы успела
			;отработать аппаратура
	mov	al,00000001b
	out	21h,al	;ICW4 - EOI выдает программа пользователя
	ret
	endp
main	proc
	mov	ax,stk
	mov	ss,ax
;заполняем таблицу глобальных дескрипторов
assume	ds:GDT_SEG
	mov	ax,GDT_SEG
	mov	ds,ax
	load_descr	gdt_gdt_8,GDT_SEG,gdt_size
	load_descr	gdt_ds_18,DATA,data_size
	load_descr	gdt_es_vbf_20,0b800h,3999
	load_descr	gdt_ss_28,STK,255
	load_descr	gdt_cs_30,CODE,code_size
	assume	ds:data
	mov	ax,data
	mov	ds,ax
;загружаем gdtr
	xor	eax,eax
	mov	ax,GDT_SEG
	shl	eax,4
	mov	point_gdt.adr,eax
	lgdt	point_gdt
;запрещаем прерывания
	cli
	mov	al,80h
	out	70h,al
	mov	al,20h	;новое значение базового вектора
	call	new_8259A
;загружаем idtr
	xor	eax,eax
	mov	ax,IDT_SEG
	shl	eax,4
	mov	point_idt.adr,eax
	lidt	point_idt
;переключаемся в защищенный режим
	mov	eax,cr0
	or	al,1
	mov	cr0,eax
;настраиваем регистры
	db	0eah	;машинный код команды jmp
	dw	offset protect	;смещение метки перехода
			;в сегменте команд
	dw	30h	;селектор сегмента кода в GDT
protect:
;загрузить селекторы для остальных дескрипторов
	mov	ax,18h
	mov	ds,ax
	mov	ax,20h
	mov	es,ax
	mov	ax,28h
	mov	ss,ax
;работаем в защищенном режиме:
        mov cx,dlina
        mov si,offset stroka
        mov di,1920
        mov ah,07h
wiw:
        mov al,[si]
        mov es:[di],ax
        inc si
        inc di
        inc di
        loop wiw
;разрешаем прерывания от таймера, наблюдаем
	sti
                       ; далее просто двойной цикл для задержки времени
        mov cx,04fffh
met1:
        mov ax,04fffh
met2:
        dec ax
        jnz met2
        loop met1
	cli
;
;готовимся к переходу в реальный режим
;прерывания запрещены
;перепрограммируем контроллер на старое значение базового вектора
	mov	al,08h
	call	new_8259A
;формирование дескрипторов для реального режима
	assume	ds:GDT_SEG
	mov	ax,8h
	mov	ds,ax
	mov	gdt_ds_18.limit,0ffffh
	mov	gdt_es_vbf_20.limit,0ffffh
	mov	gdt_ss_28.limit,0ffffh
	mov	gdt_cs_30.limit,0ffffh
	assume	ds:DATA
;загрузка теневых дескрипторов
	mov	ax,18h
	mov	ds,ax
	mov	ax,20h
	mov	es,ax
	mov	ax,28h
	mov	ss,ax
	db	0eah
	dw	offset jump
	dw	30h
jump:	mov	eax,cr0
	and	al,0feh
	mov	cr0,eax
	db	0eah
	dw	offset r_mode
	dw	CODE
r_mode:
	mov	ax,DATA
	mov	ds,ax
	mov	ax,STK
	mov	ss,ax
	mov	ax,3ffh
	mov	point_idt.lim,ax
	xor	eax,eax
	mov	point_idt.adr,eax
	lidt	point_idt
;разрешаем прерывания
	sti
	xor	al,al
	out	70h,al
;окончание работы программы (стандартно)
	mov	ax,4C00h
	int	21h
main	ENDP
code_size=$-dummy
code	ends
end	main
