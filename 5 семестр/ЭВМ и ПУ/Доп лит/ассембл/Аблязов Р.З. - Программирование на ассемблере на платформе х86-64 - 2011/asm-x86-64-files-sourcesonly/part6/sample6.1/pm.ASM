ORG 100h

     STACK_BASE_ADDRESS 	 equ 200000h
     USER_PM_CODE_BASE_ADDRESS	 equ 400000h
     USER_PM_CODE_SIZE equ USER_PM_CODE_END - USER_PM_CODE_BASE_ADDRESS

     CODE_SELEKTOR  equ 8h
     DATA_SELEKTOR  equ 10h
     VIDEO_SELEKTOR equ 18h

start:
		mov		ax,3
		int		10h

		in		al,92h
		or		al,2
		out		92h,al

		xor		eax,eax
		mov		ax, cs
		shl		eax,4
		add		eax, PROTECTED_MODE_ENTRY_POINT
		mov		[ENTRY_OFF],eax

		xor		eax,eax
		mov		ax,cs
		shl		eax,4
		add		ax, GDT

		mov		dword [GDTR+2],eax
		lgdt		fword [GDTR]

		cli
		in		al,70h
		or		al,80h
		out		70h,al

		mov		eax,cr0
		or		al,1
		mov		cr0,eax

		db		66h
		db		0EAh			
ENTRY_OFF	dd		PROTECTED_MODE_ENTRY_POINT		      
		dw		CODE_SELEKTOR

align 8
GDT:
	NULL_descr	db		8 dup(0)
	CODE_descr	db		0FFh,0FFh,00h,00h,00h,10011010b,11001111b,00h
	DATA_descr	db		0FFh,0FFh,00h,00h,00h,10010010b,11001111b,00h
	VIDEO_descr	db		0FFh,0FFh,00h,80h,0Bh,10010010b,01000000b,00h
	GDT_size	equ		$-GDT

label GDTR fword
		dw		GDT_size-1		
		dd		?		

use32

PROTECTED_MODE_ENTRY_POINT:
		mov	       ax, DATA_SELEKTOR
		mov	       ds, ax
		mov	       es, ax
		mov	       ss, ax
		mov	       esp, STACK_BASE_ADDRESS

		call delta
         delta:
		pop ebx
		add ebx, USER_PM_CODE_START-delta

		mov	       esi, ebx
		mov	       edi, USER_PM_CODE_BASE_ADDRESS
		mov	       ecx, USER_PM_CODE_SIZE
		rep	       movsb


		mov	       eax,USER_PM_CODE_BASE_ADDRESS
		jmp	       eax

USER_PM_CODE_START:
ORG USER_PM_CODE_BASE_ADDRESS

		include 'PM_CODE.ASM';

USER_PM_CODE_END: