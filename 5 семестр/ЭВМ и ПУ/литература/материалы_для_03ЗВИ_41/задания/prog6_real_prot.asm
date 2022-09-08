;  prog6.asm
; программа перехода в защищенный режим
; и обратно

.486P		;разрешение инструкций защищенного режима
.MODEL	large

                ;структура для описания дескрипторов сегментов

descr	STRUC       ; дескриптор содержит восемь байт

limit	dw	0
base_1	dw	0
base_2	db	0
attr	db	0
lim_atr	db	0
base_3	db	0
         ENDS

                ; макрос инициализации дескрипторов
                ; для заполнения полей адреса и размера сегмента
load_descr	MACRO	des,seg_addr,seg_size
 	mov	des.limit,seg_size
 	xor	eax,eax
 	mov	ax,seg_addr
 	shl	eax,4
 	mov	des.base_1,ax
 	rol	eax,16
 	mov	des.base_2,al
        	ENDM


;структура для загрузки регистра gdtr
point	STRUC
lim	dw	0
adr	dd	0
	ENDS

   ;   начало сегмента стека программы

stk	segment	stack 'stack' use16
	db	256 dup (0)
stk	ends

    ;  таблица глобальных дескрипторов

gdt_seg	segment	para public 'data' use16
gdt_0	        descr	<0,0,0,0,0,0>	        ; пустой дескриптор
gdt_gdt_8	descr	<0,0,0,92h,0,0> ; дескриптор самой GDT как сегмента
gdt_ldt_10	descr	<0,0,0,0,0,0>   ; не используем 
gdt_ds_18	descr	<0,0,0,92h,0,0> ; дескриптор сегмента данных
gdt_es_vbf_20	descr	<0,0,0,92h,0,0>	; видеобуфер
gdt_ss_28	descr	<0,0,0,92h,0,0>	; сегмент стека
gdt_cs_30	descr	<0,0,0,9ah,0,0>	; сегмент кода
gdt_size=$-gdt_0-1              	; размер GDT минус 1
                  GDT_SEG ENDS

               ;данные программы
data	segment	para public 'data' use16	;сегмент данных
point_gdt	point	<gdt_size,0>
stroka_1	db "программа перешла в защищенный режим работы процессора"
dlina=$-stroka_1
stroka_2        db      'снова переход в реальный режим','$'
data_size=$-point_gdt-1
data	ends

               ; кодовый сегмент программы
code	segment	byte public 'code' use16
;сегмент кода с 16-разрядным режимом адресации
assume	cs:code,ss:stk
main	proc
	mov	ax,stk
	mov	ss,ax
;заполняем таблицу глобальных дескрипторов
assume	ds:gdt_seg
	mov	ax,gdt_seg
	mov	ds,ax
	load_descr	gdt_gdt_8,GDT_SEG,gdt_size ; GDT_SEG - адрес GDT
                                                   ; gdt_size - размер gdt
	load_descr	gdt_ds_18,DATA,data_size   ; DATA - адрес сегмента 
                                                   ; данных, data_size -
                                                   ; размер сегмента данных 
	load_descr	gdt_es_vbf_20,0b800h,3999  ; 0b800h - адрес видеобуфера
                                                   ; в текстовом режиме
                                                   ; 3999 - длина в байтах
	load_descr	gdt_ss_28,STK,255          ; размер стека - 255
	load_descr	gdt_cs_30,CODE,0ffffh	   ; размер кодового сегмента
                                                   ; взят 64 кбайта
assume	ds:data
	mov	ax,data
	mov	ds,ax
;загружаем gdtr
	xor	eax,eax
	mov	ax,gdt_seg
	shl	eax,4
	mov	point_gdt.adr,eax
	lgdt	point_gdt
;запрещаем прерывания
	cli
	mov	al,80h
	out	70h,al
;переключаемся в защищенный режим
	mov	eax,cr0
	or	al,1
	mov	cr0,eax
;настраиваем регистры
	db	0eah	;машинный код команды jmp
	dw	offset protect	;смещение метки перехода
			;в сегменте команд
	dw	30h	;селектор сегмента кода
			;в таблице GDT
protect:
;загрузить селекторы для остальных дескрипторов
	mov	ax,18h  ; 18h - это смещение(index) сегмента данных в GDT
	mov	ds,ax   ; его в регистр ds
	mov	ax,20h  ; 20h - это смещение(index) сегмента видеобуфера 
	mov	es,ax   ; его в регистр es
	mov	ax,28h  ; 28h - это смещение(index) сегмента стека в GDT
	mov	ss,ax   ; его в регистр ss
;работаем в защищенном режиме:
;выводим строку в видеобуфер
	mov	cx,dlina	;длина сообщения
	mov	si,offset stroka_1	;адрес строки сообщения
	mov	di,1920	;начальный адрес видеобуфера для вывода
	mov	ah,07h	;атрибут выводимых символов

outstr:
	mov	al,[si]
	mov	es:[di],ax
	inc	si
	inc	di
	inc	di
	loop	outstr

;формирование дескрипторов для реального режима
; уменьшаем размеры до нормы реального режима - 0ffffh=64 кбайта
	assume	ds:gdt_seg
	mov	ax,8h
	mov	ds,ax
	mov	gdt_ds_18.limit,0ffffh
	mov	gdt_es_vbf_20.limit,0ffffh
	mov	gdt_ss_28.limit,0ffffh
	mov	gdt_cs_30.limit,0ffffh
assume	ds:data
;снова загрузка регистров дескрипторов
	mov	ax,18h
	mov	ds,ax
	mov	ax,20h
	mov	es,ax
	mov	ax,28h
	mov	ss,ax

	db	0eah         ; снова команда JMP
	dw	offset jump
	dw	30h
jump:
	mov	eax,cr0      ; переключение в реальный режим 
	and	al,0feh      
	mov	cr0,eax
	db	0eah         ; и еще команда JMP
	dw	offset r_mode
	dw	code
r_mode:
	mov	ax,data
	mov	ds,ax
	mov	ax,stk
	mov	ss,ax
;разрешаем прерывания
	sti
	xor	al,al
	out	70h,al
;окончание работы программы
        mov     ah,09h
        lea     dx,stroka_2
        int     21h
	mov	ax,4c00h
	int	21h
main	endp
code	ends
	end	main
