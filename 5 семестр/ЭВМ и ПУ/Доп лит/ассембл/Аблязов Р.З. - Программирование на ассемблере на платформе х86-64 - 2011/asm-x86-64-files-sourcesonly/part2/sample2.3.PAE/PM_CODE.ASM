PAGE_DIRECTORIES_POINTERS_TABLE_BASE_ADDRESS equ  01A00000h
PAGE_DIRECTORIES_TABLE_BASE_ADDRESS	     equ  01A01000h
PAGE_TABLES_BASE_ADDRESS		     equ  01A10000h

TABLES_END				     equ  02210000h

            START_CODE:

   xor eax, eax
   mov edi, PAGE_DIRECTORIES_POINTERS_TABLE_BASE_ADDRESS
   mov ecx, (TABLES_END - PAGE_DIRECTORIES_POINTERS_TABLE_BASE_ADDRESS)/4
   rep stosd

   mov eax, START_CODE
   mov ebx, eax
   call create_VirtAddressPAE
   ;call map_addr

   mov eax, 0B8000h
   mov ebx, eax
   call create_VirtAddressPAE
   ;call map_addr

   mov eax, 0FF000000h
   mov ebx, 0B8000h
   call create_VirtAddressPAE
   ;call map_addr

   mov eax, 0EE000000h
   mov ebx, 0B8000h
   call create_VirtAddressPAE


   mov eax, PAGE_DIRECTORIES_POINTERS_TABLE_BASE_ADDRESS
   mov cr3, eax


   mov eax, cr4
   or eax, 32
   mov cr4, eax

   mov eax, cr0
   or eax, 80000000h
   mov cr0, eax

	 ;--------------------PAE PAGING ENABLED-------------------------
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

message1 db "152535455565758595 5"
message2 db "A5d5r5F5F5050505050505 5"
message3 db "A5d5r5E5E5050505050505 5"
end_messages:


create_VirtAddressPAE:
; in
; EAX page address
; EBX phys page address
    pushad

    and eax, 0FFFFF000h
    and ebx, 0FFFFF000h

    mov edi, eax
    mov esi, ebx

    shr eax, 30
    mov ebx, eax
    mov ecx, eax     ;ebx, ecx, eax index in Page Directories Table
    shl eax, 3	     ; eax = eax*8
    add eax, PAGE_DIRECTORIES_POINTERS_TABLE_BASE_ADDRESS
		     ; eax point to entry of Page Directories Table

    shl ebx, 12
    add ebx, PAGE_DIRECTORIES_TABLE_BASE_ADDRESS
		     ; ebx point to Page Directory

    push ebx	; save ebx  !!!!!!
    or ebx, 1	; set present flag !!!!!!
    mov [eax], ebx
    pop ebx	; backup ebx !!!!!!!!!


    mov eax, edi
    shl eax, 2
    shr eax, 23
    mov edx, eax    ; edx, eax index in page dir
    shl eax, 3	    ; eax = eax*8
    add eax, ebx    ; eax point to page dir entry

    imul edx, ecx
    shl edx, 12
    add edx, PAGE_TABLES_BASE_ADDRESS
		    ; edx point to page table

    push edx	    ; save edx !!!!!
    or edx, 3	    ; set present, write, supervisor flags
    mov [eax], edx
    pop edx	    ; backup edx !!!!!!!!!


    mov ebx, edi
    shl ebx, 11
    shr ebx, 23     ; ebx index in page table
    shl ebx, 3	    ; ebx = ebx*8
    add ebx, edx    ; ebx point to page table entry

    or esi, 3
    mov [ebx], esi
   .end:
    popad
    ret