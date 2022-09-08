;---------------------------
; Processor in long mode
; stack pointer = 08000h
; avail virtual memory 0h-200000h
;---------------------------
include 'lmstructures.asm';

PLM4_BASE_ADDRESS equ 100000h
TSS_SELEKTOR equ 38h

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

	lgdt	tbyte [GDTR64]

	mov ax, 20h
	mov ds, ax
	mov ss, ax
	mov es, ax

	mov rsi, message2
	mov al, 0
	mov ah, 1
	mov bl, "5"
	call OutText

;prepare syscall/sysret mehanism

	mov ecx, IA32_EFER
	rdmsr
	or eax,1
	wrmsr	  ; enable syscall/sysret mahanism

	pushf
	xor r11, r11
	pop r11        ;r11 - RFLAGS image

	mov ecx, IA32_STAR
	xor eax, eax
	mov edx, 000230018h
	wrmsr

	mov ecx, IA32_LSTAR
	mov eax, RING0_CODE
	xor edx, edx
	wrmsr

	mov ecx, IA32_FMASK
	mov eax, r11d
	xor edx, edx
	wrmsr

	mov rsi, message3
	mov al, 0
	mov ah, 2
	mov bl, "5"
	call OutText


	xor rcx, rcx
	mov ecx, RING3_CODE
	;sysretq
	db 48h, 0Fh, 07h

RING3_CODE:
	mov ax, 02Bh
	mov ds, ax

       @@:
	inc dword [R3_c]
	mov rsi, message4
	mov al, 0
	mov ah, 3
	mov bl, "5"
	call OutText

	syscall
	jmp @b

RING0_CODE:
	mov ax, 20h
	mov ds, ax

	inc dword [R0_c]
	mov rsi, message5
	mov al, 0
	mov ah, 4
	mov bl, "5"
	call OutText

	;sysretq
	db 48h, 0Fh, 07h

message1 db "We in long mode!",0
message2 db "GDT and TR is updated",0
message3 db "SYSCALL/SYSRET mechanism was initialized",0
message4 db "RING3 code running   "
    R3_c dd 0
	 db 0
message5 db "RING0 code running   "
    R0_c dd 0
	 db 0


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
	or eax, 7		   ; rax = PDP table addr or Present or Write or U/S
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
	or eax, 7		   ; rax = PD table addr or Present or Write or U/S
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
	or r12d, 010000111b	   ; page addr or PS or Present or Write or U/S
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

align 8
GDT64:
	dq 0
	db		0FFh,0FFh,00h,00h,00h,10011010b,11001111b,00h	       ; 08
	db		0FFh,0FFh,00h,00h,00h,10010010b,11001111b,00h	       ;  10

CODE64R0_Descr	  db	00h, 00h,00h,00h, 00h,10011000b,00100000b,00h	;18
DATA64R0_Descr	  db	0FFh,0FFh,00h,00h,00h,10010010b,11001111b,00h	;20

DATA64R3_Descr	  db	0FFh,0FFh,00h,00h,00h,11110010b,11001111b,00h	;28
CODE64R3_Descr	  db	00h, 00h,00h,00h, 00h,11111000b,00100000b,00h	;30

GDT64_size	  equ		  $-GDT64

label GDTR64
      dw GDT64_size-1
      dq GDT64