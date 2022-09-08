ORG 100h

     STACK_BASE_ADDRESS     equ 08000h
     PM_CODE_BASE_ADDRESS   equ 0100h
     PM_CODE_SIZE equ PM_CODE_END - PM_CODE_BASE_ADDRESS

     CODE_SELEKTOR  equ 8h
     DATA_SELEKTOR  equ 10h
     CODE64_SELEKTOR equ 18h

     PML4_addr equ 1FC000h
     PDPE_addr equ 1FD000h
     PDE_addr  equ 1FE000h

start:
     mov ax,3
     int 10h

     in  al,92h
     or  al,2
     out 92h,al

     xor eax, eax
     mov ax, cs
     shl eax,4
     add eax, PROTECTED_MODE_ENTRY_POINT
     mov [ENTRY_OFF],eax

     xor eax, eax
     mov ax,cs
     shl eax,4
     add eax, GDT

     mov dword [GDTR+2],eax
     lgdt fword [GDTR]

     cli
     in  AL,70h
     or  AL,80h
     out 70h,AL

     mov eax, cr0
     or  al,1
     mov cr0, eax

     db  66h
     db  0EAh
ENTRY_OFF dd PROTECTED_MODE_ENTRY_POINT
     dw  CODE_SELEKTOR

align 8
GDT:
	NULL_descr	db		8 dup(0)
	CODE32_descr	db		0FFh,0FFh,00h,00h,00h,10011010b,11001111b,00h
	DATA_descr	db		0FFh,0FFh,00h,00h,00h,10010010b,11001111b,00h
	CODE64_descr	db		00h, 00h,00h,00h, 00h,10011000b,00100000b,00h
	GDT_size	equ		$-GDT

label GDTR fword
		dw		GDT_size-1		
		dd		?

use32
PROTECTED_MODE_ENTRY_POINT:
	mov ax, DATA_SELEKTOR
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov esp, STACK_BASE_ADDRESS

	call delta
   delta:
	pop ebx
	add ebx, PM_CODE_START-delta

	mov esi, ebx
	mov edi, PM_CODE_BASE_ADDRESS
	mov ecx, PM_CODE_SIZE
	rep movsb


	mov eax,PM_CODE_BASE_ADDRESS
	jmp eax


PM_CODE_START:
ORG PM_CODE_BASE_ADDRESS

	mov eax, cr4
	bts eax, 5   ; PAE = 1
	mov cr4, eax

	mov dword [PDE_addr], 010000011b	; PS or Present or Write
	mov dword [PDE_addr+4], 0
	mov dword [PDPE_addr], PDE_addr or 3	; Present or Write
	mov dword [PDPE_addr+4], 0
	mov dword [PML4_addr], PDPE_addr or 3	; Present or Write
	mov dword [PML4_addr+4], 0

	mov eax, PML4_addr
	mov cr3, eax

	mov ecx, 0xC0000080 ; EFER
	rdmsr
	bts eax,8  ; EFER.LME = 1
	wrmsr

	mov eax, cr0
	bts eax, 31 ; PG = 1
	mov cr0, eax

	jmp CODE64_SELEKTOR:LONG_MODE_ENTRY_POINT
use64
LONG_MODE_ENTRY_POINT:
	mov ax, ds  ; reload all segment registers
	mov ds, ax
	mov ss, ax
	mov es, ax

include 'LM_CODE.ASM'
PM_CODE_END: