ORG 100h

include 'pmstructures.asm'

     STACK_BASE_ADDRESS 	 equ 200000h
     USER_PM_CODE_BASE_ADDRESS	 equ 400000h
     USER_PM_CODE_SIZE equ USER_PM_CODE_END - USER_PM_CODE_BASE_ADDRESS

     CODE_SELEKTOR  equ 8h
     DATA_SELEKTOR  equ 10h
     VIDEO_SELEKTOR equ 18h

     CODE_BASE_ADDRESS equ 8000h

     INIT_IPI_command	 equ 000C4500h
     STARTUP_IPI_command equ 000C4600h or (CODE_BASE_ADDRESS shr 12)

		mov ax,3
		int 10h

		mov si, CODE_START
		xor ax, ax
		mov es, ax
		mov di, CODE_BASE_ADDRESS
		mov cx, PROGRAM_END-PROGRAM_START
		rep movsb

		mov ds, ax
		mov ss, ax
		mov es, ax
		jmp 0000:CODE_BASE_ADDRESS


CODE_START:
ORG CODE_BASE_ADDRESS
PROGRAM_START:
		in		al,92h
		or		al,2
		out		92h,al

		lgdt		fword [GDTR]

		cli
		in		al,70h
		or		al,80h
		out		70h,al

		mov		eax,cr0
		or		al,1
		mov		cr0,eax

		jmp CODE_SELEKTOR:PROTECTED_MODE_ENTRY_POINT

align 8
GDT:
	NULL_descr	db		8 dup(0)
	DEFINE_CODE_DESCRIPTOR 0,0FFFFFh
	DEFINE_DATA_DESCRIPTOR 0,0FFFFFh
	DEFINE_DATA_DESCRIPTOR 0B8000h,0FFFFh
	GDT_size	equ		$-GDT

label GDTR fword
		dw		GDT_size-1		
		dd		GDT

include 'APIC_Defs.asm'

use32

PROTECTED_MODE_ENTRY_POINT:
	mov ax, DATA_SELEKTOR
	mov ds, ax
	mov es, ax
	mov ss, ax

@@:
	bt	dword [SEMAPHORE], 0
	jnc	@b
	lock btr dword [SEMAPHORE], 0
	jnc	@b
;---------------------
	inc dword [CPU_Count]
	mov esp, [CPU_Count]
	mov ebp, esp		     ; save current CPU Count in ebp
	shl esp, 12
	add esp, STACK_BASE_ADDRESS
;---------------------
	lock bts dword [SEMAPHORE], 0


	mov esi, message1
	mov al, 0
	mov ah, 0
	mov bl, "5"
	call OutText

;enable APIC
	mov ecx, IA32_APIC_BASE
	rdmsr
	bts eax, 11
	wrmsr

	mov edx, eax

	mov eax, [LOCAL_APIC_ID_REG_DEF]
	shr eax, 24

	mov esi, LAPICID
	mov ebx, 16
	call dword_to_STR

	mov esi, message2
	mov al, 0
	mov ebx, ebp
	mov ah, bl
	mov bl, "5"
	call OutText

	;jmp .END
	mov ecx, IA32_APIC_BASE
	rdmsr
	bt eax, 8
	jnc .END

;boorstrap code
	mov  eax, INIT_IPI_command
	mov [APIC_ICR_low_DEF], eax
      @@:
	bt  dword [APIC_ICR_low_DEF],12
	jc  @b
	mov eax, 10000
	call delay


	mov  eax, STARTUP_IPI_command
	mov [APIC_ICR_low_DEF], eax
      @@:
	bt  dword [APIC_ICR_low_DEF],12
	jc  @b

	mov eax, 200
	call delay

	mov  eax, STARTUP_IPI_command
	mov [APIC_ICR_low_DEF], eax
      @@:
	bt  dword [APIC_ICR_low_DEF],12
	jc  @b

	mov eax, 50000
	call delay


	mov eax, [CPU_Count]
	mov esi, CPU_Count_Str
	mov ebx, 10
	call dword_to_STR

	mov esi, message3
	mov ebx, eax
	inc ebx
	mov al, 0
	mov ah, bl
	mov bl, "5"
	call OutText

.END:
	jmp $

message1 db "We in protected mode!",0
message2 db "Local APIC ID : "
 LAPICID db 8 dup (0)

message3 db "Total CPU count : "
CPU_Count_Str db 6 dup (0)

SEMAPHORE  dd 1
CPU_Count  dd 0


delay:
; input
;       EAX - microseconds

	pushad

	mov	ecx, eax
	mov	eax, 1000000
	xor	edx, edx
	div	ecx
	
	mov	ecx, eax
	mov	eax, 1193182
	xor	edx, edx
	div	ecx

	out	42h, al
	xchg	al, ah
	out	42h, al

.rep:
	in	al,0x61
	test	al, 20h
	jz	.rep
	
	popad
	ret

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
      sub esp, 32   ; резурвируем место в стеке под временную строку
 
    .repeat:
      xor edx, edx
      div ebx
      mov edi, eax
      mov al, dl
      cmp al, 10
      sbb al, 69h
      das
      mov byte [esp+ecx], al
      mov eax, edi
 
      inc ecx
      cmp eax, 0
      jz .endrep
      jmp .repeat
    .endrep:
      mov edi, esp
      add edi, ecx
    .copyrep:
      dec edi
      mov dl, byte [edi]
      mov byte [esi], dl
      inc esi
 
      loop .copyrep
      add esp, 32
    .end:
      popad
      ret
PROGRAM_END: