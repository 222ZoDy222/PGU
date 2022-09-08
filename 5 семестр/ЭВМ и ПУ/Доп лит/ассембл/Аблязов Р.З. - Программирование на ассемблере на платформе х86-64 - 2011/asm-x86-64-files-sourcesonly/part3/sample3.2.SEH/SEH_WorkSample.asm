format PE GUI 4.0

include 'win32a.inc'
include 'DDK\ntstatus.inc'
include 'DDK\ntdefs.inc'

entry start

section '.data' data readable writeable

szTitle db 'SEH work sample',0
szAccessViolationError db 'Access violation!',0
szDivideByZeroError db 'Divide by zero!',0
szMessage db 'Exceptions handled!',0

section '.code' code readable executable

proc ExceptionHandler c ExceptionRecord, EstablisherFrame, ContextRecord, DispatcherContext

     push ebx
     push esi

     mov  ebx, [ExceptionRecord]
     virtual at ebx
      .ebx EXCEPTION_RECORD
     end virtual

     mov     esi, [ContextRecord]
     virtual at esi
      .esi CONTEXT
     end virtual

     cmp     [.ebx.ExceptionCode], EXCEPTION_ACCESS_VIOLATION
     je      .AccessViolation
     cmp     [.ebx.ExceptionCode], EXCEPTION_INT_DIVIDE_BY_ZERO
     je      .DivideError

    .ContinueSearch:
     mov     eax, ExceptionContinueSearch
     jmp .exit
    
    .AccessViolation:
     invoke MessageBox, 0, szAccessViolationError, szTitle, 0
     add [.esi.regEip], 2
     mov eax, ExceptionContinueExecution
     jmp .exit

    .DivideError:
     invoke MessageBox, 0, szDivideByZeroError, szTitle, 0
     add [.esi.regEip], 2
     mov eax, ExceptionContinueExecution

    .exit:
     pop esi
     pop ebx
     ret
endp

start:
	push	ExceptionHandler
	push	dword [fs:0000h]
	mov	dword [fs:0000h], esp

	xor eax, eax
	div eax

	xor eax, eax
	mov eax, [eax]

	pop eax
	mov [fs:0000h], eax
	pop eax

	invoke MessageBox, 0, szMessage, szTitle, 0
	invoke ExitProcess, 0

section '.relocs' fixups readable writeable

section '.idata' import data readable writeable


  library kernel,'KERNEL32.DLL',\
	  user,'USER32.DLL'

  import kernel,\
	 ExitProcess,'ExitProcess'

  import user,\
	 MessageBox,'MessageBoxA'