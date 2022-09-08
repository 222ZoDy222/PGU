include 'pmstructures.asm';
include 'APIC_defs.asm'


IDT_size equ IDT_END-IDT

   START_CODE:

	mov esi, message1
	mov al, 0
	mov ah, 0
	mov bl, "5"
	call OutText
	
	lidt	fword [IDTR]
	
; init APIC
       mov ecx, IA32_APIC_BASE
       rdmsr
       bts eax, 11
       wrmsr

       ;and eax, 0FFFFF000h  ;eax = APIC BASE
       ;mov edi, eax
;APIC enabled

	mov esi, message2
	mov al, 0
	mov ah, 1
	mov bl, "5"
	call OutText	

; enabling LAPIC timer
	mov dword [APIC_LVT_Timer_REG_DEF], ((1 shl 17) or 20h)
	mov dword [APIC_Timer_Divide_Configuration_REG_DEF], 1001b
	mov dword [APIC_Timer_Initial_Count_REG_DEF], 2083333

	mov esi, message3
	mov al, 0
	mov ah, 2
	mov bl, "5"
	call OutText

;configuring IO APIC

	mov dword [IOAPIC_IOREGSEL_REG_DEF], IOAPIC_IOAPICVER
	mov eax, dword [IOAPIC_IOWIN_REG_DEF]
	shr eax, 16
	inc eax      ;
	mov ebx, 10
	mov esi, Max_RTE_Str
	call dword_to_STR

	mov esi, message4
	mov al, 0
	mov ah, 3
	mov bl, "5"
	call OutText

	mov eax, 1
	cpuid
	and ebx, 0FF000000h ; high byte = Local APIC ID

	mov dword [IOAPIC_IOREGSEL_REG_DEF], IOAPIC_IOAPICID
	mov dword [IOAPIC_IOWIN_REG_DEF], 2000000h

	mov dword [IOAPIC_IOREGSEL_REG_DEF], IOAPIC_IOREDTBL1_hi
	mov dword [IOAPIC_IOWIN_REG_DEF], ebx


	mov dword [IOAPIC_IOREGSEL_REG_DEF], IOAPIC_IOREDTBL1_low
	mov dword [IOAPIC_IOWIN_REG_DEF], 21h

	mov esi, message5
	mov al, 0
	mov ah, 4
	mov bl, "5"
	call OutText

	sti

	jmp $

message1 db "We in protected mode!",0
message2 db "APIC was initialized",0
message3 db "Local APIC timer started",0
message4 db "Max redirection entries of IO APIC : "
Max_RTE_Str db 10 dup (0)
message5 db "IO APIC initialized",0

TimerCounterStr db 20 dup (0)
KBRDCounterStr db 20 dup (0)

IDTR:
    dw IDT_size-1
    dd IDT

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

dword_to_STR:
;на входе EAX число 32 бит
;         ESI указатель на строку
;         EBX разрядность результата
      pushad
      cmp ebx, 16
      ja  .end
      xor ecx, ecx
      jmp .repeat
 
.mesto db 32 dup (0)
 
    .repeat:
      xor edx, edx
      div ebx
      mov edi, eax
      mov al, dl
      cmp al, 10
      sbb al, 69h
      das
      mov byte [.mesto+ecx], al
      mov eax, edi
 
      inc ecx
      cmp eax, 0
      jz .endrep
      jmp .repeat
    .endrep:
      mov edi, .mesto
      add edi, ecx
    .copyrep:
      dec edi
      mov dl, byte [edi]
      mov byte [esi], dl
      inc esi
 
      loop .copyrep
    .end:
      popad
      ret


exGP_handler:
    pop  eax ;

    iretd

counter dd 0

LVT_APIC_Timer_handler:

    push esi
    push eax
    push ebx
    inc dword [counter]

    mov eax, [counter]
    mov ebx, 10
    mov esi, TimerCounterStr
    call dword_to_STR

    mov esi, TimerCounterStr
    mov al, 0
    mov ah, 5
    mov bl, "5"
    call OutText

    mov dword [APIC_EOI_REG_DEF], 0 ;EOI
    pop ebx
    pop eax
    pop esi

    iretd

kbrd_counter dd 0

Keyboard_handler:

    push esi
    push eax
    push ebx
    inc dword [kbrd_counter]

    mov eax, [kbrd_counter]
    mov ebx, 10
    mov esi, KBRDCounterStr
    call dword_to_STR

    mov esi, KBRDCounterStr
    mov al, 0
    mov ah, 6
    mov bl, "5"
    call OutText

    in	 al, 060h
    dec  al
    mov  ah, al
    and  ah, 80h
    jz @f

    in	 al, 061h
    or	 al, 80
    out  061h, al
    xor  al, 80
    out  061h, al
   @@:
    mov dword [APIC_EOI_REG_DEF], 0 ;EOI
    pop ebx
    pop eax
    pop esi

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
	DEFINE_INT_GATE LVT_APIC_Timer_handler, CODE_SELEKTOR  ; 20h (32) vector
	DEFINE_INT_GATE Keyboard_handler, CODE_SELEKTOR  ; 21h (33) vector


IDT_END:
