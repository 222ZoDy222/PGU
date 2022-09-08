include 'pmstructures.asm';

Ring0Stack	    equ  200000h
Ring3Stack	    equ  180000h

CS_r0  equ 8h
DS_r0  equ 10h

DS_r3  equ 20h
VIDEO_SELEKTOR equ 18h

   START_CODE:

	mov esi, message1
	mov al, 0
	mov ah, 0
	mov bl, "5"
	call OutText

	sgdt [GDTR_Image]
	mov eax, NewGDT
	mov [GDTR_Image.BaseAddress], eax
	mov ax, NewGDTEnd - NewGDT - 1
	mov [GDTR_Image.Limit], ax

	lgdt [GDTR_Image]

	jmp  CS_r0:@f
       @@:
	mov ax, DS_r0
	mov ds, ax
	mov ss, ax

	mov esi, message2
	mov al, 0
	mov ah, 1
	mov bl, "5"
	call OutText

	xor edx, edx

	mov ecx, IA32_SYSENTER_CS
	mov eax, CS_r0
	wrmsr

	mov ecx, IA32_SYSENTER_CS
	mov eax, CS_r0
	wrmsr

	mov ecx, IA32_SYSENTER_EIP
	mov eax, Ring0Code
	wrmsr

	mov ecx, IA32_SYSENTER_ESP
	mov eax, Ring0Stack
	wrmsr

	mov esi, message3
	mov al, 0
	mov ah, 2
	mov bl, "5"
	call OutText


	mov edx, Ring3Code
	mov ecx, Ring3Stack
	sysexit


Ring3Code:
	mov ax, DS_r3
	mov ds, ax

	mov esi, message4
	mov al, 0
	mov ah, 3
	mov bl, "5"
	call OutText

      @@:
	inc [counter]
	mov edx, esp
	sysenter

     sysenter_ret:
	jmp @b

Ring0Code:

	mov esi, message5
	mov al, 0
	mov ah, 4
	mov bl, "5"
	call OutText

	mov ecx, edx
	mov edx,sysenter_ret
	sysexit



message1 db "We in protected mode!",0
message2 db "The GDT is updated",0
message3 db "SYSENTER/SYSEXIT mechanism was initialized",0
message4 db "Ring 3 code now run",0

message5 db "Message "
counter  dd 1
	 db 0


align 8
NewGDT:
			db		8 dup(0)
	CODE_descr_r0	db		0FFh,0FFh,00h,00h,00h,10011010b,11001111b,00h
	DATA_descr_r0	db		0FFh,0FFh,00h,00h,00h,10010010b,11001111b,00h

	CODE_descr_r3	db		0FFh,0FFh,00h,00h,00h,11111010b,11001111b,00h
	DATA_descr_r3	db		0FFh,0FFh,00h,00h,00h,11110010b,11001111b,00h
NewGDTEnd:

GDTR_Image  GDTR32

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
