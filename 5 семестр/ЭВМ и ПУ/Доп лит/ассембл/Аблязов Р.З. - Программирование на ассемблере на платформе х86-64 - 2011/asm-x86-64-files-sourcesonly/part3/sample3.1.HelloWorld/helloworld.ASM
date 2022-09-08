format PE GUI 4.0

include 'win32a.inc'

entry start

section '.data' data readable writeable

caption db 'First Win32 program',0
Message db 'Hello World!',0

section '.code' code readable executable

start:
	push 0
	push caption
	push Message
	push 0
	call [MessageBox]

	push 0
	call [ExitProcess]

section '.relocs' fixups readable writeable

section '.idata' import data readable writeable


  library kernel,'KERNEL32.DLL',\
	  user,'USER32.DLL'

  import kernel,\
	 ExitProcess,'ExitProcess'

  import user,\
	 MessageBox,'MessageBoxA'

