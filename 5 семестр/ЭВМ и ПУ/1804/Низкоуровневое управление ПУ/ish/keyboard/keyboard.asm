.MODEL	small
dseg	segment	para
	kodir	DB	27,'1234567890',0,0,0,0
		DB	12 dup(0),13,42 dup(0),'789',0,'456',0,'1230',11 dup(0)

	buf_ful	DB	10,13,'The buffer is full','$'
		
	heading	DB	'Laboratory work.',10,13,'$'
	string	DB	100 dup(?)
	per	DW	?
	segold	DW	?
	offsold	DW	?
	flag	DB	?
	anykey  DB	10,13,'Press any key...$'
dseg	ends

stseg	segment	para	stack	'stack'
	dw	40h dup(?)
stseg   ends

cseg	segment	para	public
	assume	cs:cseg,ds:dseg,ss:stseg

	buffer	DW	17 dup(?)     ;Буфер клавиатуры
				  ;в поле адресов программы
	buffend	DW	0	  ;указатель на конец буфера
	buffbeg	DW	0	  ;указатель на начало буфера
	EXIT_FLG        db      0
	LENGHT          dw      0
 	count	       db       0
	fl	       db	0


int_keyb	PROC far
	push	bx		  ;сохранение
	push	cx		  ;используемых
	push	es		  ;регистров
	push	ds		  ;в стеке
	push	di
	
	in	al,60h		  ;чтение скэн-кода
	mov	ah,al		  ;сохранение его в ah
	mov	bx,ax		  ;сохранение ax в bx
	in	al,61h		  ;подтверждение
	or	al,80h
	out	61h,al		  ;	приема
	and	al,7fh
	out	61h,al		  ;		символа

	
	 mov     ax,bx           ;; Восстановить сохраненное значение в AX.
        xor     cx,cx           ;; Записать в ES
 
        cmp     al,1            ;; Если нажата клавиша ESC,
        jne    translate         ;; то установить флаг EXIT_FLG в 1 и выйти
        mov    EXIT_FLG,1   ;; из обработчика, иначе произвести иденти-
        jmp     quit            ;; фикацию и обработку символа.
 
    
 translate:
             
        test    al,80h    ;; Проверить отпускание какой-либо клавиши,
        jnz     quit            ;; если оно было зафиксировано, то выйти.

     
 decod_it:
        sub     al,1h           ;; Перекодировать
        mov     bx,seg kodir     ;;     поступивший 
        mov     ds,bx           ;;         скан-код
        mov     bx,offset kodir  ;;             в ASCII-символ
        xlat    kodir            ;;

	
        mov     di,buffend       ;; DX = адрес конца циклического буфера.
	


 cmp     fl,1       ;; Если буфер не заполнен до конца,
        jne     not_full        ;; то перейти к not_full.
        mov     ah,9            ;; Иначе вывести
        mov     dx,offset buf_ful ;; сообщение о том,
        int     21h             ;; что буфер заполнен 
        jmp     quit            ;; и выйти из обработчика.



 not_full:
	
        mov     BUFFER[di],ax ;; Записать декодированный символ в буфер.
    	
    add     di,2            ;; Увеличить указатель буфера на 2,
                                ;; т.к. пишем слова.
        cmp     di,32           ;; Если указатель != 32 (16 слов),
        jne     not_end         ;; то переходим к not_end,
        xor     di,di           ;; иначе устанавливаем указатель конца буфера
                                ;; на начало физического буфера в памяти.
	
not_end:
        mov     buffend,di       ;; Фиксируем указатель конца буфера в памяти.
        inc     LENGHT          ;; Увеличить длину буфера на 1 (записано
       inc count                         ;; 1 слово)



quit:	pop	di
	pop	ds
	pop	es
	pop	cx
	pop	bx		  ;восстановление стека
	push	ax
	mov	al,20h		  ;разрешение прерываний
	out	20h,al		  ;более низкого приоритета
	pop	ax
	iret
int_keyb	endp





init proc near
	push	ds		  ;сохранение в стеке
	push	es		  ;	изменяющихся сегментных регистров
	mov	ax,3509h
	int	21h		  ;чтение старого вектора прерывания 9h
	mov	segold,es
	mov	offsold,bx
	cli
	mov	ax,seg int_keyb
	mov	ds,ax
	mov	dx,offset int_keyb
	mov	ax,2509h
	int	21h		  ;установка нового 9h-го вектора
	pop	es		  ;восстановление
	pop	ds		  ;	сегментных регистров из стека
	sti

        ret
init endp

shutdown proc near
       push	ds
	mov	dx,offsold
	mov	ax,segold	  ;восстановление старого вектора
	mov	ds,ax
	mov	ax,2509h	  ;прерывания от клавиатуры
	int	21h
	pop	ds

        ret                    
shutdown endp




start:	mov	ax,dseg
	mov	ds,ax		  ;запись в ds адреса сегмента данных
	
	call init

	mov 	ah,0fh          ;; 
      	int	10h             ;; Очистить 
       	xor	ah,ah           ;; экран. 
      	int	10h             ;;
	
	mov	ah,9
	mov	dx,offset heading
	int	21h

 main:
     	 mov     di,buffbeg       ;; DI = адрес начала буфера
  		
     	 cmp     EXIT_FLG,0      ;; Проверить флаг выхода из программы,
    	 jne     endprog            ;; если установлен, выйти.
    	 cmp     count,0        ;; Есть ли в буфере информация для вывода?
   	 je      main            ;; Если нет, то перейти к main.
  		
    	mov     ax,buffer[di]   ;; AX = очередной символ из буфера клавиатуры.

	
      	cmp     al,13           ;; Если это не Enter,
   	jne     not_enter       ;; то перейти к not_enter,
   	mov     al,10           ;; иначе перевести
     	int     29h             ;; каретку,
     	mov     al,13           ;; перейти на новую строку
      
 not_enter:
	
      	int     29h
	cmp fl,1
	je endprog

	cmp lenght,16
	jne m1
	mov fl,1
m1:
        dec     count          ;; Уменьшить количество символов, находящихся
                                ;; в буфере.
        inc     di              ;; Сместить указатель 
        inc     di              ;; начала буфера на 2.
        mov     buffbeg,di       ;; Зафиксировать указатель в памяти.

   	
        jmp     main            ;; Возврат на метку main для продолжения обработки

	
endprog:
	call shutdown

	mov	ah,9
	mov	dx,offset anykey
	int	21h
	
	mov	ah,7
	int	21h

	mov	ax,4c00h	  ;выход из программы с кодом возврата,
	int	21h		  ;равным 0 - нормальный выход

cseg	ends
end	start	




