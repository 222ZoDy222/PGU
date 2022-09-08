INT_GATE equ 1000111000000000b

macro DEFINE_GATE _address,_code_selektor, _type
      {
       dw   _address and 0FFFFh ,_code_selektor,_type, _address shr 16
      }

IDT_size  equ IDT_END-IDT
		
		mov ax, VIDEO_SELEKTOR
		mov es, ax

		lidt	fword [IDTR]

	; инициализируем контроллеры прерываний
	mov  bx, 2820h
	
	mov	al, 00010001b
	
	out	020h, al
	out	0A0h, al
	mov	al, bl
	out	021h, al
	mov	al, bh
	out	0A1h, al
	mov	al, 00000100b
	out	021h, al
	mov	al, 2
	out	0A1h, al
	mov	al, 00000001b
	out	021h, al
	out	0A1h, al


	; разрешаем аппаратные прерывани€ и NMI
		in   al, 70h
		and  al, 7Fh
		out  70h, al
		sti

		mov eax, 00F00h
		mov ecx, 0820h
		mov edi, 00
		rep stosw

		mov byte [es:0], "0"
		mov byte [es:2], "0"
		mov byte [es:4], "0"
		mov byte [es:6], "0"


		mov  dword [cursor], 80

		mov esi, message1
		int 1
		mov  dword [cursor], 160
		mov esi, message2
		int 1
		mov  dword [cursor], 240


		jmp    $

        IDTR:
		dw IDT_size-1
		dd IDT

clear_screen:
    push eax
    push ecx
    push edi

    mov eax, 00F00h
    mov ecx, 0820h
    mov edi, 80
    rep stosw

    pop edi
    pop ecx
    pop eax
    mov dword [cursor], 79
    ret


syscall_handler:
    pushad
  _puts:
    lodsb
    mov  edi, dword [cursor]
    mov  [es:edi*2], al
    inc  dword [cursor]
    test al, al
    jnz  _puts
    popad
    iretd  

counter dd 0

irq0_handler:
    push eax
    push edx
    push ebx

    xor edx, edx
    inc dword [counter]
    mov eax, dword [counter]
    mov ebx, 18;
    div ebx
    cmp edx, 0
    jnz .cont

    inc  byte [es:6]

    cmp  byte [es:6],":"
    jnz .cont
    mov byte [es:6],"0"
    inc byte [es:4]

    cmp byte [es:4], ":"
    jnz .cont
    mov byte [es:4],"0"
    inc byte [es:2]

    cmp byte [es:2], ":"
    jnz .cont
    mov byte [es:2],"0"
    inc byte [es:0]

    cmp byte [es:0], ":"
    jnz .cont
    mov byte [es:0], "0"
    mov byte [es:2], "0"
    mov byte [es:4], "0"
    mov byte [es:6], "0"

 .cont:
    pop ebx
    pop edx
    pop eax

    jmp  int_EOI

irq1_handler:
    push ax
    push edi
    xor  ax, ax

    in	 al, 060h
    dec al
    jnz .cont

    call clear_screen
    ;jmp Ack

.cont:
    ; отжати€  не обрабатываем, только нажати€
    mov  ah, al
    and  ah, 80h
    jnz clear_request

    ; преобразуем позиционный код в ASCII по таблице
    and  al, 7Fh
    push edi
    mov  edi, ASCII
    add  di, ax
    mov  al, [edi]
    pop  edi

    ; выводим символы на экран один за другим
    mov  edi, dword [cursor]
    shl  edi, 1
    mov  byte [es:edi], al
    inc  dword [cursor]

    cmp dword [cursor], 640h
    jb Ack
    mov dword [cursor], 80

    ; посылка подтверждени€ обрабоки в порт клавиатуры
    ; (установка и сброс 7 бита порта 061h)
   Ack:
    in	 al, 061h
    or	 al, 80
    out  061h, al
    xor  al, 80
    out  061h, al

clear_request:
    pop  edi
    pop  ax
    jmp  int_EOI    


int_EOI:
    push ax
    mov  al, 20h
    out  020h, al  
    out  0a0h, al
    pop  ax
    iretd
    
exGP_handler:
    pop  eax ; код ошибки
    mov  esi, gp
    int  1
    iretd		
				
align 8        
IDT:
	dq 0 ; 0
	DEFINE_GATE syscall_handler, CODE_SELEKTOR,INT_GATE
	dq 0 ; 2
	dq 0 ; 3
	dq 0 ; 4
	dq 0 ; 5
	dq 0 ; 6
	dq 0 ; 7
	dq 0 ; 8
	dq 0 ; 9
	dq 0 ; 10
	dq 0 ; 11
	dq 0 ; 12
	DEFINE_GATE exGP_handler, CODE_SELEKTOR,INT_GATE  ; 13  #GP
	dq 0  ; 14
	dq 0  ; 15
	dq 0  ; 16
	dq 0  ; 17
	dq 0  ; 18
	dq 0  ; 19
	dq 0  ; 20
	dq 0  ; 21
	dq 0  ; 22
	dq 0  ; 23
	dq 0  ; 24
	dq 0  ; 25
	dq 0  ; 26
	dq 0  ; 27
	dq 0  ; 28
	dq 0  ; 29
	dq 0  ; 30
	dq 0  ; 31
	DEFINE_GATE irq0_handler, CODE_SELEKTOR,INT_GATE  ; 20 (IRQ 0 - системный таймер)
	DEFINE_GATE irq1_handler, CODE_SELEKTOR,INT_GATE  ; 21 (IRQ 1 - клавиатура)ss
	DEFINE_GATE int_EOI, CODE_SELEKTOR,INT_GATE	  ; 22 (IRQ 2 - ведомый контроллер прерываний)
	DEFINE_GATE int_EOI, CODE_SELEKTOR,INT_GATE	  ; 23 (IRQ 3 - COM2)
	DEFINE_GATE int_EOI, CODE_SELEKTOR,INT_GATE	  ; 24 (IRQ 4 - COM1)
	DEFINE_GATE int_EOI, CODE_SELEKTOR,INT_GATE	  ; 25 (IRQ 7 - LPT2)
	DEFINE_GATE int_EOI, CODE_SELEKTOR,INT_GATE	  ; 26 (IRQ 6 - FDD)
	DEFINE_GATE int_EOI, CODE_SELEKTOR,INT_GATE	  ; 27 (IRQ 7 - LPT1)
	DEFINE_GATE int_EOI, CODE_SELEKTOR,INT_GATE	  ; 28 (8)
	DEFINE_GATE int_EOI, CODE_SELEKTOR,INT_GATE	  ; 29 (9)
	DEFINE_GATE int_EOI, CODE_SELEKTOR,INT_GATE	  ; 2A (10)
	DEFINE_GATE int_EOI, CODE_SELEKTOR,INT_GATE	  ; 2B (11)
	DEFINE_GATE int_EOI, CODE_SELEKTOR,INT_GATE	  ; 2C (12)
	DEFINE_GATE int_EOI, CODE_SELEKTOR,INT_GATE	  ; 2D (13)
	DEFINE_GATE int_EOI, CODE_SELEKTOR,INT_GATE	  ; 2E (14)
	DEFINE_GATE int_EOI, CODE_SELEKTOR,INT_GATE	  ; 2F (15)


IDT_END:


ASCII	 db 0,'1234567890-+',0,0,'QWERTYUIOP[]',0,0,'ASDFGHJKL;',"'`",0,0,'ZXCVBNM,./',0,'*',0,' ',0, 0,0,0,0,0,0,0,0,0,0, 0,0, '789-456+1230.', 0,0

; —ообщение
gp db 'GENERAL PROTECTION FAULT',0

; ѕозици€ курсора
cursor	 dd 0

	message1 db 'We in protected mode',0
	message2 db 'Intel x86 is very good processors',0