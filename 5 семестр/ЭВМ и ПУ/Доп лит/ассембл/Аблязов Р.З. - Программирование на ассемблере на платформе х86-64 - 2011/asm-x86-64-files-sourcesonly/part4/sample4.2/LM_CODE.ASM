;---------------------------
; Processor in long mode
; stack pointer = 08000h
; avail virtual memory 0h-200000h
;---------------------------

PLM4_BASE_ADDRESS equ 100000h

LM_CODE_START:
	mov rdi, PLM4_BASE_ADDRESS
	call ZeroPage_4K

	xor rax, rax
	mov eax, LM_CODE_START
	and eax, 0FFFFF000h
	mov rbx, rax
	call AllocPage_4K


	mov eax, 0B8000h
	mov rbx, rax
	call AllocPage_4K

	mov eax, 008000h
	mov rbx, rax
	call AllocPage_4K

	mov eax, 07000h
	mov rbx, rax
	call AllocPage_4K

	mov eax,   0B8000h
	mov ebx, 12345000h
	call AllocPage_4K

	xor eax, eax
	mov ebx, 0ABCB8000h
	and ebx, 0FFE00000h
	call AllocPage_2M

	mov eax, 0B8000h
	;mov ebx, 048Ah
	mov rbx, 48A98765000h
	;shl ebx, 32
	;mov ebx, 98765000h ; rbx = 48A98765000h
	call AllocPage_4K

	xor rax, rax
	mov eax, PLM4_BASE_ADDRESS
	mov cr3, rax

	mov rsi, message
	mov al, 0
	mov ah, 0
	mov bl, "5"
	call OutText

	mov rsi, testmsg1
	mov al, 0
	mov ah, 1
	mov bl, "5"
	mov rdx, 12345000h
	call OutTextEx

	mov rsi, testmsg2
	mov al, 0
	mov ah, 2
	mov bl, "5"
	mov rdx, 0ABCB8000h
	call OutTextEx

	mov rsi, testmsg3
	mov al, 0
	mov ah, 3
	mov bl, "5"
	;mov edx, 48Ah
	;shl edx, 32
	;mov edx, 98765000h ; rdx = 48A98765000h
	mov rdx, 48A98765000h
	call OutTextEx

	jmp $


message db "We in long mode!",0
testmsg1 db "Write to address 0x 12345000",0
testmsg2 db "Write to address 0x ABCB8000",0
testmsg3 db "Write to address 0x 0000048A 98765000",0

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

AllocPage_4K:
;IN
;   RAX physical address low 12 bits must be clear
;   RBX virtual address  low 12 bits and high 16 bits must be clear
	push rax
	push rbx
	push r8
	push rdi
	push rdx
	push r9
	push r10
	push r11
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

	mov r11d, [r8+4]
	shl r11, 32
	mov r11d, [r8]		   ;
	mov eax, r11d		   ; eax = r10d
	and eax, 1		   ; checking present flag
	jz @f
	jmp .setPTE
       @@:
	xor rdi, rdi
	mov edi, [NextAvail4KPage]
	shl rdi, 12    ; rdi = next avail page addr
	add rdi, PLM4_BASE_ADDRESS
	call ZeroPage_4K

	mov rax, rdi
	or eax, 3		   ; rax = PT addr or Present or Write
	mov rdx, rax

	mov [r8], eax
	shr rax, 32
	mov [r8+4], eax
	inc dword [NextAvail4KPage]
	mov r11, rdx		   ; r11 = PD entry
       .setPTE:
	;------------------------------------------------------------
	and r11d, 0FFFFF000h	   ; r11 = PT addr

	mov rdx, rbx
	shr rdx, 12
	and edx, 1FFh
	xor r8, r8
	mov r8d, edx		   ; r8 = index in PT
	shl r8, 3		   ; r8 = offset in PT
	add r8, r11		   ; r8 = PT entry addr

				   ; r12 = phys addr
	or r12d, 3		   ; page addr or present or write
	mov [r8], r12d
	shr r12, 32
	mov [r8+4], r12d

	pop r12
	pop r11
	pop r10
	pop r9
	pop rdx
	pop rdi
	pop r8
	pop rbx
	pop rax
	ret

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
