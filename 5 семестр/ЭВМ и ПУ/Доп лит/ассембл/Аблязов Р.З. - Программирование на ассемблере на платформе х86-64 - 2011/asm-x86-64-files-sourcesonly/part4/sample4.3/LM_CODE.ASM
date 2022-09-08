;---------------------------
; Processor in long mode
; stack pointer = 08000h
; avail virtual memory 0h-200000h
;---------------------------
include 'lmstructures.asm';

PLM4_BASE_ADDRESS equ 100000h
TSS_SELEKTOR equ 20h

RING0_Stack equ 80000h

LM_CODE_START:
	mov rdi, PLM4_BASE_ADDRESS
	call ZeroPage_4K

	xor rax, rax	
	mov rbx, rax
	call AllocPage_2M

	mov eax, 0200000h	
	mov rbx, rax
	call AllocPage_2M

	mov eax, 0400000h
	mov rbx, rax
	call AllocPage_2M

	xor rax, rax
	mov eax, PLM4_BASE_ADDRESS
	mov cr3, rax
	 ;first 6 MB virtual memory is mapped

	mov rsi, message1
	mov al, 0
	mov ah, 0
	mov bl, "5"
	call OutText

	lidt	tbyte [IDTR64]
	lgdt	tbyte [GDTR64]

	mov [TSS.RSP0], RING0_Stack
	mov ax,TSS_SELEKTOR
	ltr ax

	mov rsi, message2
	mov al, 0
	mov ah, 1
	mov bl, "5"
	call OutText

	; init interrupt controllers
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

	mov rsi, message3
	mov al, 0
	mov ah, 2
	mov bl, "5"
	call OutText

	in   al, 70h
	and  al, 7Fh
	out  70h, al
	sti

	mov rsi, message4
	mov al, 0
	mov ah, 3
	mov bl, "5"
	call OutText

	jmp $


message1 db "We in long mode!",0
message2 db "System Tables is Updated",0
message3 db "Controllers was initialized",0
message4 db "Interrupt succesful enabled",0

sec_counter db "0000",0

OutText:
;IN
;  RSI - ZS offset
;  AL  - col
;  AH  - row
;  BL  - char attributes
	push rdx
	xor rdx, rdx
	mov edx, 0B8000h
	call OutTextEx
	pop rdx
	ret

OutTextEx:
;IN
;  RSI - ZS offset
;  AL  - col
;  AH  - row
;  BL  - char attributes
;  RDX - text buffer

	push rax
	push rdi
	push rsi
	push rbx

	xor rdi, rdi
	push rax
	shr rax, 8
	and rax, 0FFh
	imul rdi, rax, 160
	pop rax
	and eax, 0FFh
	shl rax, 1
	add rdi, rax
	add rdi, rdx

      .rep:
	cmp byte [rsi],0
	jz .end
	mov bh, byte [rsi]
	mov byte [rdi], bh
	inc rdi
	mov byte [rdi], bl
	inc rdi
	inc rsi

	jmp .rep
       .end:

	pop rbx
	pop rsi
	pop rdi
	pop rax
	ret

NextAvail4KPage dd 1  ; next avail page for table for virt addr translation

AllocPage_2M:
;IN
;   RAX physical address low 21 bit must be clear
;   RBX virtual address  low 21 bit high 16 bits must be clear
	push rax
	push rbx
	push r8
	push rdi
	push rdx
	push r9
	push r10
	push r12    ; save all using registers

	mov r12, rax	  ; r12 = phys addr

	mov r8, rbx
	shr r8, 39  ; r8 = index in PML4

	shl r8, 3   ; r8 = offset in PML4
	add r8, PLM4_BASE_ADDRESS ; r8 = PML4 entry addr
	mov r9d, [r8+4]
	shl r9, 32
	mov r9d, [r8]		  ; r9 = PML4 entry
	mov eax, r9d		  ; eax = r9d
	and eax, 1		  ; checking present flag
	jz @f
	jmp .setPDPE
       @@:
		    ; if PDP not presented then alloc PDP table
	xor rdi, rdi
	mov edi, [NextAvail4KPage]
	shl rdi, 12    ; rdi = next avail page addr
	add rdi, PLM4_BASE_ADDRESS
	call ZeroPage_4K

	mov rax, rdi		   ; rax = new PDP table
	or eax, 3		   ; rax = PDP table addr or Present or Write
	mov rdx, rax		   ; rdx = rax

	mov [r8], eax
	shr rax, 32
	mov [r8+4], eax
	inc dword [NextAvail4KPage]
	mov r9, rdx		   ;
       .setPDPE:		   ;r9 = PML4 entry
	;-------------------------------------------------------
	and r9d, 0FFFFF000h	   ; r9 = PDP table addr
	mov r8, rbx
	shr r8, 30
	and r8d, 1FFh		   ; r8 = index in PDP
	shl r8, 3		   ; r8 = offset in PDP
	add r8, r9		   ; r8 = PDP entry addr
	mov r10d, [r8+4]
	shl r10, 32
	mov r10d, [r8]		   ; r10 = PDP entry
	mov eax, r10d		   ; eax = r10d
	and eax, 1		   ; checking present flag
	jz @f
	jmp .setPDE
       @@:
		 ; if PDPE not presented then alloc PD table
	xor rdi, rdi
	mov edi, [NextAvail4KPage]
	shl rdi, 12    ; rdi = next avail page addr
	add rdi, PLM4_BASE_ADDRESS
	call ZeroPage_4K

	mov rax, rdi
	or eax, 3		   ; rax = PD table addr or Present or Write
	mov rdx, rax

	mov [r8], eax
	shr rax, 32
	mov [r8+4], eax
	inc dword [NextAvail4KPage]
	mov r10, rdx		   ; r10 = PDP entry
       .setPDE: 		   ; r10 = PDPE
	;----------------------------------------------------------
	and r10d, 0FFFFF000h	   ; r10 = PD table addr

	mov rdx, rbx
	shr rdx, 21
	and edx, 1FFh		   ;
	xor r8, r8
	mov r8d, edx		   ; r8 = index in PD
	shl r8, 3		   ; r8 = offset in PD
	add r8, r10		   ; r8 = PD entry addr

				   ; r12 = phys addr
	or r12d, 010000011b	   ; page addr or PS or Present or Write
	mov [r8], r12d
	shr r12, 32
	mov [r8+4], r12d

	pop r12
	pop r10
	pop r9
	pop rdx
	pop rdi
	pop r8
	pop rbx
	pop rax
	ret

ZeroPage_4K:
;IN
;   RDI - 4K page addr for NULL
	push rdi
	push rax
	push rcx

	xor rax, rax
	mov rcx, 1000h/8
	rep stosq

	pop rcx
	pop rax
	pop rdi
	ret

counter  dd 0

IRQ0_handler:
    push rax
    push rdx
    push rbx

    inc [counter]

    xor edx, edx
    xor eax, eax
    inc dword [counter]
    mov eax, dword [counter]
    mov ebx, 18;
    div ebx
    cmp edx, 0
    jnz .cont

    inc  byte [sec_counter+3]

    cmp  byte [sec_counter+3],":"
    jnz .cont
    mov byte [sec_counter+3],"0"
    inc byte [sec_counter+2]

    cmp byte [sec_counter+2], ":"
    jnz .cont
    mov byte [sec_counter+2],"0"
    inc byte [sec_counter+1]

    cmp byte [sec_counter+1], ":"
    jnz .cont
    mov byte [sec_counter+1],"0"
    inc byte [sec_counter]

    cmp byte [sec_counter], ":"
    jnz .cont
    mov byte [sec_counter], "0"
    mov byte [sec_counter+1], "0"
    mov byte [sec_counter+2], "0"
    mov byte [sec_counter+3], "0"

 .cont:
    mov rsi, sec_counter
    mov al, 0
    mov ah, 4
    mov bl, "5"
    call OutText

    pop rbx
    pop rdx
    pop rax

    jmp  int_EOI

int_EOI:
    push rax
    mov  al, 20h
    out  020h, al  
    out  0a0h, al
    pop  rax
    iretq

align 16
IDT64:
  dq 0,0 ; #DE  Divede by zero error
  dq 0,0 ; #DB  Debug
  dq 0,0 ; #NMI Not maskable interrupt
  dq 0,0 ; #BP  Breakepoint
  dq 0,0 ; #OF  Overflow
  dq 0,0 ; #BR  Bound range
  dq 0,0 ; #UD  Invalide opcode
  dq 0,0 ; #NM  Device not available
  dq 0,0 ; #DF  Double fault
  dq 0,0 ; --   Coprocessor segment overrun (unsuppored)
  dq 0,0 ; #TS  Invalide TSS
  dq 0,0 ; #NP  Segment not present
  dq 0,0 ; #SS  Stack
  dq 0,0 ; #GP  General protection
  dq 0,0 ; #PF  Page fault
  dq 0,0 ; Reserved
  dq 0,0 ; #MF  x87 floating point exception pending
  dq 0,0 ; #AC  Aligment check
  dq 0,0 ; #MC  Machine check
  dq 0,0 ; #XF  SIMD floating point
  dq 0,0 ; Reserved
  dq 0,0 ; Reserved
  dq 0,0 ; Reserved
  dq 0,0 ; Reserved
  dq 0,0 ; Reserved
  dq 0,0 ; Reserved
  dq 0,0 ; Reserved
  dq 0,0 ; Reserved
  dq 0,0 ; Reserved
  dq 0,0 ; Reserved
  dq 0,0 ; #SX  Security exception
  dq 0,0 ; Reserved

  DEFINE_INTGATE64 CODE64_SELEKTOR,IRQ0_handler,0 ; 20 IRQ-0: Timer
  DEFINE_INTGATE64 CODE64_SELEKTOR,int_EOI,0 ; 21 IRQ-1
  DEFINE_INTGATE64 CODE64_SELEKTOR,int_EOI,0 ; 22 IRQ-2
  DEFINE_INTGATE64 CODE64_SELEKTOR,int_EOI,0 ; 23 IRQ-3
  DEFINE_INTGATE64 CODE64_SELEKTOR,int_EOI,0 ; 24 IRQ-4
  DEFINE_INTGATE64 CODE64_SELEKTOR,int_EOI,0 ; 25 IRQ-5
  DEFINE_INTGATE64 CODE64_SELEKTOR,int_EOI,0 ; 26 IRQ-6
  DEFINE_INTGATE64 CODE64_SELEKTOR,int_EOI,0 ; 27 IRQ-7
  DEFINE_INTGATE64 CODE64_SELEKTOR,int_EOI,0 ; 28 IRQ-8
  DEFINE_INTGATE64 CODE64_SELEKTOR,int_EOI,0 ; 29 IRQ-9
  DEFINE_INTGATE64 CODE64_SELEKTOR,int_EOI,0 ; 2A IRQ-A
  DEFINE_INTGATE64 CODE64_SELEKTOR,int_EOI,0 ; 2B IRQ-B
  DEFINE_INTGATE64 CODE64_SELEKTOR,int_EOI,0 ; 2C IQR-C
  DEFINE_INTGATE64 CODE64_SELEKTOR,int_EOI,0 ; 2D IRQ-D
  DEFINE_INTGATE64 CODE64_SELEKTOR,int_EOI,0 ; 2E IRQ-E
  DEFINE_INTGATE64 CODE64_SELEKTOR,int_EOI,0 ; 2F IRQ-F

IDT64_Size equ $-IDT64

label IDTR64
    dw IDT64_Size-1
    dq IDT64

TSS TSS64
TSS_Size equ $ - TSS

align 8
GDT64:
	dq 0
	db		0FFh,0FFh,00h,00h,00h,10011010b,11001111b,00h
	db		0FFh,0FFh,00h,00h,00h,10010010b,11001111b,00h
	CODE64Descr    db	       00h, 00h,00h,00h, 00h,10011000b,00100000b,00h
	DEFINE_TSS64Descr TSS, TSS_Size-1
GDT64_size	  equ		  $-GDT64

label GDTR64
      dw GDT64_size-1
      dq GDT64

