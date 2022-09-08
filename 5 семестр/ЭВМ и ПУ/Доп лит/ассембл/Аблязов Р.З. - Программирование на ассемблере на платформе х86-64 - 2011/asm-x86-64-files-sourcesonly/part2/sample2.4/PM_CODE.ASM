include 'pmstructures.asm';

TssDescriptorsSize equ TssDescriptorsEnd-TssDescriptors
IDT_size equ IDT_END-IDT


NewGDT		    equ  6F0000h
NewGDTSize	    equ  1000h

Main_task_stack     equ  610000h
Task_number2_Stack  equ  630000h
Task_number3_Stack  equ  650000h
irq0_handler_Stack  equ  670000h

FirstTask_Selektor  equ   20h
FirstTaskTss	    equ   700000h

TASK_NUMBER_2_Selektor	 equ 28h
TASK_NUMBER_2_Tss	 equ   701000h

TASK_NUMBER_3_Selektor	 equ   30h
TASK_NUMBER_3_Tss	 equ   702000h

Irq0_handler_Selektor	  equ	38h
Irq0_handler_Tss	  equ	703000h

   START_CODE:

	mov esi, message1
	mov al, 0
	mov ah, 0
	mov bl, "5"
	call OutText

	xor eax, eax
	mov edi,NewGDT
	mov ecx, NewGDTSize/4
	rep stosd

	sgdt [GDTR_Image]
	mov esi, [GDTR_Image.BaseAddress]
	mov edi, NewGDT
	xor ecx, ecx
	inc word [GDTR_Image.Limit]
	mov cx, [GDTR_Image.Limit]
	shr ecx, 2
	rep movsd

	mov edi, NewGDT
	mov ax, [GDTR_Image.Limit]
	add edi, eax
	mov esi, TssDescriptors
	mov ecx, TssDescriptorsSize/4
	rep movsd

	mov [GDTR_Image.BaseAddress], NewGDT
	mov ax, [GDTR_Image.Limit]
	add ax, TssDescriptorsSize
	dec ax
	mov [GDTR_Image.Limit], ax
	lgdt [GDTR_Image]


	mov esi, message2
	mov al, 0
	mov ah, 1
	mov bl, "5"
	call OutText


	mov eax, CR3 ; EAX = CR3
	pushfd
	pop edx      ; EDX = EFLAGS

	mov ecx, Main_task_stack
	mov ebx, FirstTask
	mov edi, FirstTaskTss
	call Set_TSS

	mov ecx, Task_number2_Stack
	mov ebx, TASK_NUMBER_2
	mov edi, TASK_NUMBER_2_Tss
	call Set_TSS

	mov ecx, Task_number3_Stack
	mov ebx, TASK_NUMBER_3
	mov edi, TASK_NUMBER_3_Tss
	call Set_TSS

	mov ecx, irq0_handler_Stack
	mov ebx, irq0_handler
	mov edi, Irq0_handler_Tss
	call Set_TSS


	lidt	fword [IDTR]

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

	mov esi, message4
	mov al, 0
	mov ah, 3
	mov bl, "5"
	call OutText


	mov ax, FirstTask_Selektor
	ltr ax

FirstTask:

	mov esi, message3
	mov al, 0
	mov ah, 2
	mov bl, "5"
	call OutText

	sti

	jmp $

message1 db "We in protected mode!",0
message2 db "The GDT is updated!",0
message3 db "Multitask mehanism was enabled!",0
message4 db "Interrupt controllers was initialized",0



  GDTR_Image  GDTR32

IDTR:
    dw IDT_size-1
    dd IDT

  TssDescriptors:
   DEFINE_TSS_DESCRIPTOR FirstTaskTss, 100h
   DEFINE_TSS_DESCRIPTOR TASK_NUMBER_2_Tss, 100h
   DEFINE_TSS_DESCRIPTOR TASK_NUMBER_3_Tss, 100h
   DEFINE_TSS_DESCRIPTOR Irq0_handler_Tss, 100h
  TssDescriptorsEnd:

OutText:
;IN
;  ESI - ZS offset
;  AL  - col
;  AH  - row
;  BL  - char attributes

	pushad
	xor edi, edi
	push eax
	shr eax, 8
	and eax, 0FFh
	imul edi, eax, 160
	pop eax
	and eax, 0FFh
	shl eax, 1
	add edi, eax
	add edi, 0B8000h

      .rep:
	cmp byte [esi],0
	jz .end
	mov bh, byte [esi]
	mov byte [edi], bh
	inc edi
	mov byte [edi], bl
	inc edi
	inc esi

	jmp .rep
       .end:
	popad
	ret

ClearBusyFlag:
; IN
;  EAX - selektor
	push eax
	push edi

	mov edi, NewGDT
	add edi, eax
	and byte [edi+5], 11111101b

	pop edi
	pop eax
	ret

SetBusyFlag:
; IN
;  EAX - selektor
	push eax
	push edi

	mov edi, NewGDT
	add edi, eax
	add edi, 5
	or byte [edi], 10b

	pop edi
	pop eax
	ret


message5 db "Task number 1 message  "
counter1 dd 11111111h
	 db 0

TASK_NUMBER_2:
	sti

	mov esi, message5
	mov al, 0
	mov ah, 6
	mov bl, "5"

       @@:
	call OutText

	inc dword [counter1]
	jmp @b



message6 db "Task number 2 message  "
counter2 dd 11111111h
	 db 0

TASK_NUMBER_3:
	sti

	mov esi, message6
	mov al, 0
	mov ah, 7
	mov bl, "5"

       @@:
	call OutText

	inc dword [counter2]
	jmp @b


Set_TSS:
;IN
; EAX  - CR3
; EBX  - EIP
; ECX  - ESP
; EDX  - EFLAGS
; EDI  - TSS base address
	pushad

	push eax
	push edi
	push ecx


	xor eax, eax
	mov ecx, 26
	cld
	rep stosd

	pop ecx
	pop edi
	pop eax

	virtual at edi
	 .edi TSS32
	end virtual

	mov [.edi.tsCR3], EAX
	mov [.edi.tsEIP], EBX
	mov [.edi.tsESP], ECX
	mov [.edi.tsEFLAGS], EDX

	mov [.edi.tsCS], CODE_SELEKTOR
	mov [.edi.tsDS], DATA_SELEKTOR
	mov [.edi.tsSS], DATA_SELEKTOR
	mov [.edi.tsES], DATA_SELEKTOR

	popad
	ret

interrupt_mes db "Interupt message  "
counter dd 11111111h
	db 0

irq0_handler:

    mov edi, Irq0_handler_Tss

    virtual at edi
     .edi TSS32
    end virtual

   .repeat:
    inc dword [counter]

    mov esi,interrupt_mes
    mov al, 0
    mov ah, 4
    mov bl, "5"
    call OutText

    xor eax, eax

    mov ax, [.edi.PreviousTaskLink]
    call ClearBusyFlag

    cmp ax, TASK_NUMBER_2_Selektor
    jz @f
    mov ax, TASK_NUMBER_2_Selektor
    call SetBusyFlag
    mov [.edi.PreviousTaskLink], TASK_NUMBER_2_Selektor

    jmp .end_dispatch
   @@:
    mov ax, TASK_NUMBER_3_Selektor
    call SetBusyFlag
    mov [.edi.PreviousTaskLink], TASK_NUMBER_3_Selektor

   .end_dispatch:
    mov  al, 20h
    out  020h, al  
    out  0a0h, al

    iretd
    jmp .repeat


int_EOI:
    push ax
    mov  al, 20h
    out  020h, al  
    out  0a0h, al
    pop  ax
    iretd

exGP_handler:
    pop  eax ; код ошибки

    iretd


align 8
IDT:
	dq 0 ; 0
	dq 0
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
	DEFINE_INT_GATE exGP_handler, CODE_SELEKTOR  ; 13  #GP
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
	DEFINE_TASK_GATE Irq0_handler_Selektor	; 20 (IRQ 0 - системный таймер)
	DEFINE_INT_GATE int_EOI, CODE_SELEKTOR	; 21 (IRQ 1 - клавиатура)
	DEFINE_INT_GATE int_EOI, CODE_SELEKTOR	     ; 22 (IRQ 2 - ведомый контроллер прерываний)
	DEFINE_INT_GATE int_EOI, CODE_SELEKTOR	     ; 23 (IRQ 3 - COM2)
	DEFINE_INT_GATE int_EOI, CODE_SELEKTOR	     ; 24 (IRQ 4 - COM1)
	DEFINE_INT_GATE int_EOI, CODE_SELEKTOR	     ; 25 (IRQ 7 - LPT2)
	DEFINE_INT_GATE int_EOI, CODE_SELEKTOR	     ; 26 (IRQ 6 - FDD)
	DEFINE_INT_GATE int_EOI, CODE_SELEKTOR	     ; 27 (IRQ 7 - LPT1)
	DEFINE_INT_GATE int_EOI, CODE_SELEKTOR	     ; 28 (8)
	DEFINE_INT_GATE int_EOI, CODE_SELEKTOR	     ; 29 (9)
	DEFINE_INT_GATE int_EOI, CODE_SELEKTOR	     ; 2A (10)
	DEFINE_INT_GATE int_EOI, CODE_SELEKTOR	     ; 2B (11)
	DEFINE_INT_GATE int_EOI, CODE_SELEKTOR	     ; 2C (12)
	DEFINE_INT_GATE int_EOI, CODE_SELEKTOR	     ; 2D (13)
	DEFINE_INT_GATE int_EOI, CODE_SELEKTOR	     ; 2E (14)
	DEFINE_INT_GATE int_EOI, CODE_SELEKTOR	     ; 2F (15)

IDT_END:
