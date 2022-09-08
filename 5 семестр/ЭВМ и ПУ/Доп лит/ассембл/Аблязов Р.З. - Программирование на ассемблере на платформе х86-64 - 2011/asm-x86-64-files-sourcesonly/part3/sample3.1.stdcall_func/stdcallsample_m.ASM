format PE GUI 4.0

include 'win32a.inc'

entry start

section '.data' data readable writeable


caption db 'First Win32 program',0
Message db 'Hello World!',0

counter dd 10
timerID dd ?
msg MSG

section '.code' code readable executable

proc ConcatStrings str1, str2, str3
     push esi
     push edi
     invoke lstrlen, [str1]
     mov ecx, eax
     mov esi, [str1]
     mov edi, [str3]
     rep movsb

     invoke lstrlen ,[str2]
     mov ecx, eax
     mov esi, [str2]
     rep movsb

     pop edi
     pop esi
     ret
endp

proc StdcallProcSample str1, str2

local buff:DWORD
local hProcHeap:DWORD

     invoke lstrlen, [str1]
     mov [buff], eax
     invoke lstrlen, [str2]
     add [buff], eax
     inc dword [buff]

     invoke GetProcessHeap
     mov [hProcHeap], eax
     invoke HeapAlloc, eax, HEAP_ZERO_MEMORY, [buff]
     mov [buff], eax

     stdcall ConcatStrings, [str1], [str2], [buff]

     invoke MessageBox, 0 , [buff], [str2], 0
     invoke HeapFree, [hProcHeap], 0, [buff]

     ret
endp

start:
	stdcall StdcallProcSample, Message, caption

	invoke ExitProcess, 0

section '.relocs' fixups readable writeable

section '.idata' import data readable writeable


  library kernel,'KERNEL32.DLL',\
	  user,'USER32.DLL'

  import kernel,\
	 ExitProcess,'ExitProcess',\
	 GetProcessHeap, 'GetProcessHeap',\
	 HeapAlloc,'HeapAlloc',\
	 HeapFree,'HeapFree',\
	 lstrlen, 'lstrlenA'

  import user,\
	 MessageBox,'MessageBoxA'