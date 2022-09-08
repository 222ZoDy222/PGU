format PE64 GUI 5.0
entry start

include 'win64a.inc'

section '.data' data readable writeable

   text  db 'Hello world!',0

section '.code' code readable executable

start:
	sub rsp, 32
	mov rcx, 0
	mov rdx, text
	mov r8,  text
	mov r9, 0
	call [MessageBox]

	xor rcx, rcx
	call [ExitProcess]


section '.idata' import data readable writeable

  library kernel32,'KERNEL32.DLL',\
	  user32,'USER32.DLL'

  import kernel32,\
	 ExitProcess, 'ExitProcess'

  import user32,\
	 MessageBox,'MessageBoxA'
