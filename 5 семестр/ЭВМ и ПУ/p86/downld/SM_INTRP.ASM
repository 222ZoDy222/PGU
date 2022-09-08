ifdef _TASM_
so		equ   small offset	; TASM 4,x else
so		equ   offset                             ; WASM
endif
.386p
RM_seg segment para public "CODE" use16
assume cs:RM_seg,ds:PM_seg,ss:stack_seg
start:
; clear screen
;		mov	ax,3
;		int	10h	; prepare segment registers
		push	PM_seg
		pop	ds	; test - may be we are in PM?
		mov	eax,cr0
		test	al,1
		jz	no_V86
; tell an exit
		mov	dx, small offset v86_msg
err_exit:
		mov	ah,9
		int	21h
		mov	ah,4Ch
		int	21h
; Windows 95 tells that пе = 0?
no_V86:
		mov	ax,1600h
		int	2Fh
		test	al,al
		jz	no_windows
; tell and exit
		mov	dx,small offset win_msg
		jmp	short err_exit
; we are in the RM
no_windows:
; computes base of all used segments descripters
		xor	eax,eax
		mov     ax,RM_seg
		shl	eax,4
		mov	word ptr GDT_16bitCS+2,ax		; base of all 16bitCS will be RM_seg
		shr	eax, 16
		mov	byte ptr GDT_16bitCS+4,al
		mov	ax,PM_seg
		shl	eax,4
		mov	word ptr GDT_32bitCS+2,ax 		; base of all 32bit* will be
		mov     word ptr GDT_32bitSS+2,ax		; PM_seg                                          :
		mov	word ptr GDT_32bitDS+2,ax
		shr	eax, 16
		mov	byte ptr GDT_32bitCS+4,al
		mov     byte ptr GDT_32bitSS+4,al
		mov     byte ptr GDT_32bitDS+4,al
; compute linear addres of GDT
		xor	eax,eax
		mov	ax,PM_seg
		shl	eax,4
		push	eax
		add	eax,offset GDT
		mov	dword ptr gdtr+2,eax
; load GDT
		lgdt	fword ptr gdtr
; compute lineal addres of IDT
		pop	eax
		add	eax,offset IDT
		mov	dword ptr idtr+2,eax
; load IDT
		lidt	fword ptr idtr
; open A20 for working with 32 - bit memory
		in	al,92h
		or	al,2
		out	92h,al
; reset interuptions
		cli
; reset NMI
		in	al,70h
		or	al,80h
		out	70h,al
; goto PM
		mov	eax,cr0
		or	al,1
		mov	cr0,eax
; load SEL_32bitCS into CS
		db	66h
		db	0EAh
		dd	offset PM_entry
		dw	SEL_32bitCS
RM_return:
; goto RM
		mov	eax,cr0
		and	al,0FEh
		mov	cr0,eax
; reset que and load CS with the real number
		db	0EAh
		dw	$+4
		dw	RM_seg
; set register for a work in real mode
		mov	ax,PM_seg
		mov	ds,ax
		mov	es,ax
		mov	ax,stack_seg
		mov	bx,stack_l
		mov	ss,ax
		mov	sp,bx
; load idtr for the real mode
		mov	ax,PM_seg
		mov	ds,ax
		lidt	fword ptr idtr_real
; start NMI
		in	al,70h
		and	al,07Fh
		out	70h,al
; start interruptions
		sti
; exit
		mov	ah,4Ch
		int	21h
RM_seg	ends
; 32 - bit segment
		PM_seg segment para public "CODE" use32
			assume cs:PM_seg
; GDT and IDT tables must be evened it is because we shall allocate then in the segments origin
	GDT label byte
		db	8 dup(0)
; 32 - bit 7 - Gb segment zero-based
	GDT_flatDS	db	0FFh,0FFh,0,0,0,10010010b,11001111b,0
; 16 - bit 64 Kb code segment  with RM_seg base
	GDT_16bitCS	db	0FFh,0FFh,0,0,0,10011010b,0,0
; 32 - bit 4 Gb code segment  with PM_seg base
	GDT_32bitCS	db	0FFh,0FFh,0,0,0,10011010b,11001111b,0
; 32 - bit 4 Gb data segment  with PM_seg base
	GDT_32bitDS	db	0FFh,0FFh,0,0,0,10010010b,11001111b,0
; 32 - bit 4 Gb stack segment  with stack_seg base
	GDT_32bitSS	db	0FFh,0FFh,0,0,0,10010010b,11001111b,0
		gdt_size = $-GDT
	gdtr	dw	gdt_size-1		; GDT limit
		dd	?		; GDT lineal addres
; selector names
	SEL_flatDS	equ	001000b
	SEL_16bitCS	equ	010000b
	SEL_32bitCS	equ	011000b
	SEL_32bitDS	equ	100000b
	SEL_32bitSS	equ	101000b
; IDT (interruptions descripters table)
	IDT	label	byte
; All this descripters have 0Eh type - 32 - bit interruption lock
;INT 00 - 07
		dw	8 dup (small offset int_handler, SEL_32bitCS, 8E00h, 0)
;INT 08
		dw	small offset irq0_7_handler, SEL_32bitCS, 8E00h, 0
;INT 09
		dw	small offset irq1_handler, SEL_32bitCS, 8E00h, 0
;INT 0Ah - 0Fh (IRQ2 - IRQ8)
		dw	6 dup (small offset irq0_7_handler, SEL_32bitCS, 8E00h, 0)
;INT 10h - 6Fh
		dw	97 dup (small offset int_handler, SEL_32bitCS, 8E00h, 0)
;INT 70h - 78h (IRQ8 - IRQ15)
		dw	8 dup (small offset irq8_15_handler, SEL_32bitCS, 8E00h, 0)
;INT 79h - FFh
		dw	135 dup(small offset int_handler, SEL_32bitCS, 8E00h, 0)
	idt_size = $ - IDT
	idtr	dw	idt_size - 1		; IDT limit
		dd	?		; IDT origin lineal addres
; IDTR contents in the real mode
	idtr_real	dw	3FFh, 0, 0

; Start error messages
	v86_msg	db	'Processor in v86 - mode. Can not swith on PM ...'
	win_msg	db	'Programm started under Windows OS. Can not swith on the zero ring'
; Table for translation OE scan - codes to ASCII
	scan2ascii	db	0, 1Bh, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', 8
	screen_addr	dd	0	; Current position on the screen
; 32 - bit safe mode entring point
PM_entry:
; Set 32 - bit stack and other registers
		mov	ax,SEL_flatDS
		mov	ds,ax
		mov	es,ax
		mov	ax,SEL_32bitSS
		mov	ebx,stack_l
		mov	ss,ax
		mov	esp,ebx
; Start interruptions
		sti
; Goto the endless cycle
		jmp short	$
; Ordinary interruption handler
int_handler:	
		iretd
; Apparate interruption IRQ0 - IRQ7 handler
irq0_7_handler:
		push    eax
		mov     al,20h
		out     20h,al
		pop     eax
		iretd
; Apparate interruption IRQ8 - IRQ15 handler
irq8_15_handler:
		push    eax
		mov     al, 20h
		out     0A1h,al
		pop     eax
		iretd
; Keyboard apparate interruption IRQ1 handler
irq1_handler:
		push    eax             ; This is an apparate interruption - save registers
		push    ebx
		push    es
		push    ds
		in      al,60h          ; Read scan - code
		cmp     al,0Eh          ; If this cod more than maximal
		ja      skip_translate  ; do not serve
		cmp     al,1            ; if this code is an <Esc> code
		je      esc_pressed     ; Switch on the real mode
		mov     bx,SEL_32bitDS  ; else:
		mov     ds,bx           ; DS:EBX - scan to ASCII translation table
		mov     ebx,offset scan2ascii   ; into ASCII
		xlatb			; Translate
		mov     bx,SEL_flatDS
		mov     es,bx           ; ES:EBX - current screen position
		mov     ebx,screen_addr ; addres
		cmp     al,8            ; if not <BackSpace>
		je      bs_pressed
		mov     es:[ebx+0B8000h],al     ; Output symbol on the screen
		add     dword ptr screen_addr,2 ; New current position on the screen
		jmp     short skip_translate
bs_pressed:   		                ; else:
		mov     al,' '          ; Output <Space>
		sub     ebx,2           ; in the preview symbol position
		mov     es:[ebx+0B8000h],al
		mov     screen_addr,ebx ; Save the preview symbol position as current
skip_translate:
; Allow keyboard working
		in      al,61h
		or      al,80h
		out     61h,al
; Send EOI to the interruptions controller
		mov     al,20h
		out     20h,al
; Pop registers and exit
		pop     ds
		pop     es
		pop     ebx
		pop     eax
		iretd
; Here processed <Esc> pressing
esc_pressed:
; Allow keyboard working and pop registers
		in      al,61h
		or      al,80h
		out     61h,al
		mov     al,20h
		out     20h,al
		pop     ds
		pop     es
		pop     ebx
		pop     eax
; Switch on the real mode
		cli
		db      0EAh
		dd      offset RM_return
		dw      SEL_16bitCS
	PM_seg ends
; Stack sement use as 16- bit in the 16 - bit programm part and
; as 32 - bit throw the SEL_32bitSS selector in the 32 - bit programm part
stack_seg segment para stack "STACK"
stack_start     db      100 dup(?)
stack_l = $-stack_start   ; Stack length for the ESP initialisation
stack_seg ends
	end start