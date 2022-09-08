
; DLL creation example

format PE GUI 4.0 DLL
entry DllEntryPoint

include 'win32a.inc'

section '.code' code readable executable

proc DllEntryPoint hinstDLL,fdwReason,lpvReserved
	mov	eax, TRUE
	ret
endp

proc CalcValue Value
	push ebx
	push edx

	push eax
	add eax, 3
	imul eax, 6
	mov ebx, eax  ; ebx = (a+3)*6

	mov edx, 100  ;
	pop eax
	sub edx, eax
	imul eax, edx ; eax = a*(100-a)

	add eax, ebx  ; eax = res

	pop edx
	pop ebx
	ret
endp

section '.edata' export data readable

  export 'DLL_sample.DLL',\
	 CalcValue,'CalcValue'

section '.reloc' fixups data discardable
