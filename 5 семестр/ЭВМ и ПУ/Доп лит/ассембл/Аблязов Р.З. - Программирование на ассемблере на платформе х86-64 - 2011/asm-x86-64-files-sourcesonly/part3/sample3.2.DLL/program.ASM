format PE Console 4.0
entry start

include 'win32a.inc'

section '.data' data readable writeable
inputa db 'Input a ',0

InputHandle dd 0
OutputHandle dd 0

Writed dd 0
Readed dd 0

MAX_VALUE_LENGTH equ 30


cons db 'CON',0
message  db '(a+3)*6+a*(100-a)='
a_str  db MAX_VALUE_LENGTH dup (0)

DLL_name db 'DLL_sample.DLL',0
FUNC_name db 'CalcValue',0

section '.code' code executable readable writeable

start:

    invoke GetStdHandle, STD_INPUT_HANDLE
    ;invoke CreateFile, cons, GENERIC_READ, 0,0, OPEN_EXISTING,0,0
    mov [InputHandle], eax

    invoke GetStdHandle, STD_OUTPUT_HANDLE
    ;invoke CreateFile, cons, GENERIC_WRITE, 0,0, OPEN_EXISTING,0,0
    mov [OutputHandle], eax


    invoke WriteConsole, [OutputHandle], inputa, 8,Writed,0
    invoke ReadConsole, [InputHandle], a_str, MAX_VALUE_LENGTH, Readed,0

    mov edi, a_str
    call GetZSLength
    sub eax, 2
    mov ebx, eax
    add eax, a_str
    mov word [eax], 0

    mov esi, a_str
    call STR_to_DWORD_EX
    push eax

    invoke LoadLibrary, DLL_name          ; eax = DLL handle
    invoke GetProcAddress, eax, FUNC_name ; eax = func address
    mov ebx, eax                          ; ebx = eax
    pop eax                               ; eax = value 
    stdcall  ebx, eax					  ; call func			
											
    mov esi, a_str
    mov ebx, 10
    call dword_to_STR


    mov edi, message
    call GetZSLength

    invoke WriteConsole, [OutputHandle], message, eax,Writed,0
    invoke ReadConsole, [InputHandle], a_str, 1,0,0

    invoke ExitProcess, 0

GetZSLength:
; get zero-string length
;IN
;       EDI ZS offset
;OUT
;       EAX ZS length

	push ecx
	push esi
	push edi

	cld
	xor   al, al
	mov ecx, 0FFFFFFFFh
	mov esi, edi
	repne scasb
	sub edi, esi
	mov eax, edi
	dec eax

	pop edi
	pop esi
	pop ecx
	ret

dword_to_STR:
;на входе EAX число 32 бит
;         ESI указатель на строку
;         EBX разрядность результата
      pushad
      cmp ebx, 16
      ja  .end
      cmp eax, 7FFFFFFFh
      jna .sign_plus
      mov byte [esi], '-'
      inc esi
      not eax
      inc eax
     .sign_plus:
      xor ecx, ecx
      sub esp, 32

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
	    
STR_to_DWORD_EX:
; IN  ESI = pointer to ZS
; OUT EAX = result
    push esi
    push ebx
    push edi

    xor ebx, ebx
    cmp byte [esi], '-'
    jnz .sign_plus
    mov ebx, 1
    inc esi
   .sign_plus:

    mov edi, esi
    call GetZSLength
    mov edi, eax
    add edi, esi
    dec edi
    cmp byte [edi], "b"
    jnz .oct
    mov eax, 2
    xchg byte [edi], bh
    jmp .convert
   .oct:
    cmp byte [edi], "o"
    jnz .hex
    mov eax, 8
    xchg byte [edi], bh
    jmp .convert
   .hex:
    cmp byte [edi], "h"
    jnz .decim
    mov eax, 16
    xchg byte [edi], bh
    jmp .convert
   .decim:
    mov eax, 10
    mov bh, byte [edi]
   .convert:
    call STR_to_DWORD
    xchg byte [edi], bh
    xor bh, bh
    cmp ebx, 1
    jnz .end
    xor ebx, ebx
    sub ebx, eax
    mov eax, ebx
   .end:
    pop edi
    pop ebx
    pop esi
    ret
    
    
STR_to_DWORD:
; IN  ESI = pointer to ZS
;     EAX = notation
; OUT EAX = result
    push esi
    push ebx
    push edi
    push edx
    push ecx

    cmp eax, 16
    ja .error
    cmp eax, 2
    jb .error

    mov ecx, eax

    mov edi, esi
    call GetZSLength
    mov edi, eax
    add edi, esi  ; edi point to end ZS

    xor eax, eax
    xor edx, edx
    inc edx

   .rep:
    dec edi

    xor ebx, ebx
    mov bl, [edi]
    cmp bl, 30h
    jb .error
    cmp bl, 39h
    jna .digit
    cmp bl, 41h
    jb .error
   @@:
    cmp bl, 46h
    jna .sim_upcase
    cmp bl, 61h
    jb .error
   @@:
    cmp bl, 66h
    jna .sim_lowcase
    ja .error

   .digit:
    sub bl, 30h
    jmp @f
   .sim_upcase:
    sub bl, 37h
    jmp @f
   .sim_lowcase:
    sub bl, 57h
   @@:
    cmp bl, cl
    ja .error

    imul ebx, edx
    add eax, ebx
    imul edx, ecx
    cmp edi, esi
    jnz .rep
   .endrep:


    jmp @f
   .error:
    xor eax, eax
   @@:

    pop ecx
    pop edx
    pop edi
    pop ebx
    pop esi
    ret



section '.relocs' fixups readable writeable

section '.idata' import data readable writeable

  library kernel,'KERNEL32.DLL',\
	  user, 'user32.dll'

  import kernel,\
	 ExitProcess,'ExitProcess', \
	 GetStdHandle, 'GetStdHandle',\
	 ReadConsole, 'ReadConsoleA',\
	 WriteConsole, 'WriteConsoleA',\
	 WriteFile, 'WriteFile',\
	 ReadFile, 'ReadFile',\
	 CreateFile, 'CreateFileA',\
	 LoadLibrary, 'LoadLibraryA',\
	 GetProcAddress, 'GetProcAddress'

  import user,\
	 MessageBox,'MessageBoxA'