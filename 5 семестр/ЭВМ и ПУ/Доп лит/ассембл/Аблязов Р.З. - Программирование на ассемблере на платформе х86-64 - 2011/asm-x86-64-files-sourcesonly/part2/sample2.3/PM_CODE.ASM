PAGE_DIR_BASE_ADDRESS equ	 01A00000h
PAGE_TABLES_BASE_ADDRESS equ	 01200000h

            START_CODE:

   mov eax, START_CODE
   mov ebx, eax
   call create_PDEPTE

   mov eax, 0B8000h
   mov ebx, eax
   call create_PDEPTE

   mov eax, 0FF000000h
   mov ebx, 0B8000h
   call create_PDEPTE

   mov eax, 0EE000000h
   mov ebx, 0B8000h
   call create_PDEPTE

   mov eax, PAGE_DIR_BASE_ADDRESS
   mov cr3, eax

   mov eax, cr0
   or eax, 80000000h
   mov cr0, eax

	 ;------------------------PAGING ENABLED-------------------------
		mov esi, message1
		mov edi, 0B8000h
		mov ecx,message2-message1
		rep movsb

		mov esi, message2
		mov ecx, message3-message2
		rep movsb

		mov esi, message3
		mov ecx, end_messages-message3
		rep movsb

		jmp    $

message1 db "152535455565758595 5 5"
message2 db "A5d5r5F5F5050505050505 5"
message3 db "A5d5r5E5E5050505050505 5"
end_messages:

create_PDEPTE:
; in
; EAX page address
; EBX phys page address
    pushad

    mov edi, ebx
    mov edx, eax

    shr eax, 22
    shl eax, 2
    mov esi, PAGE_DIR_BASE_ADDRESS
    add esi, eax
    shr eax, 2

    mov ebx, eax
    shl ebx, 12

    mov eax, PAGE_TABLES_BASE_ADDRESS
    add eax, ebx
    or eax, 011b
    mov [esi], eax
    and eax, 0FFFFF000h

   .create_PTE:      ;eax = table base address
    mov esi, eax
    mov eax, edx
    shl eax, 10
    shr eax, 22
    shl eax, 2
    add esi, eax

    mov eax, edi
    or eax, 011b
    mov [esi], eax

   .end:
    popad
    ret