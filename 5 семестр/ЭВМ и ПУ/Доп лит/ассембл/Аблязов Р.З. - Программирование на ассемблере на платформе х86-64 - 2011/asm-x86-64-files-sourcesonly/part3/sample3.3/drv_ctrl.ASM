format PE GUI 4.0

include 'win32a.inc'
include 'DDK\scm.inc'
include 'DDK\ntddk.inc'
include 'DDK\advmacro.inc'
include 'DDK\ntdefs.inc'

entry start

IOCTL_DEFINE_EX IOCTL_DUMP_GDT, FILE_ANY_ACCESS, 1, METHOD_BUFFERED

section '.data' data readable writeable

DriverFileName db 'E:\FASM\PROJECTS\drivers\gdtdump.sys',0
DriverServiceName db 'gdtdump',0
DeviceName db '\\.\GDTDump',0
DriverDisplayName db 'GDT dumper',0

DumpFileName db 'gdt.dat',0

MsgSuccess db 'Driver successful loaded!',0
MsgFail db 'Driver load failed!',0

hSCManager dd ?
hService   dd ?
hDevice    dd ?
Readed	   dd ?

temp SERVICE_STATUS

inputData:
    .Offset dd ?
    .Size  dd ?

FS_Descriptor dq ?

DescriptorInfo:
   db 'Base address : '
.BaseAddr db '        '
	  db 13, 10
   db 'Limit : '
.Limit	  db '        '
	  db 13, 10
   db 'DPL : '
.DPL	  db '    ',0


align 10h
Buffer db 10000h dup (?)
BufferSize = $-Buffer

section '.code' code readable executable

dword_to_STR:
;IN       EAX number
;         ESI pointer to string
;         EBX разрядность результата
      pushad
      cmp ebx, 16
      ja  .end

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

      add esp ,32
    .end:
      popad
      ret

DecodeDescriptor:
;IN
;    ESI - Pointer to descriptor
;OUT
;    EBX - Descriptor base
;    ECX - Limit
;    EAX - DPL
	push edx
	mov ebx, [esi]
	shr ebx, 16
	mov edx, [esi+4]
	and edx, 0FFh
	shl edx, 16
	or ebx, edx
	mov edx, [esi+4]
	shr edx, 24
	shl edx, 24
	or ebx, edx	;ebx = descriptor base

	mov ecx, [esi]
	and ecx, 0FFFFh
	mov edx, [esi+4]
	and edx, 0F0000h
	or ecx, edx	; ecx = descriptor limit

	mov edx, [esi+4]
	and edx, 0800000h
	jz @f
	shl ecx, 12	; ecx = descriptor limit with granularity bit
       @@:

	mov eax, [esi+4]
	shr eax, 13
	and eax, 011b
	pop edx
	ret


LoadDriver:
	invoke OpenSCManager, 0, 0, SC_MANAGER_ALL_ACCESS
	cmp eax, 0
	jz @f
	mov [hSCManager], eax

	invoke CreateService, eax, DriverServiceName, DriverDisplayName, SERVICE_START + SERVICE_STOP + DELETE, SERVICE_KERNEL_DRIVER, \
	 SERVICE_DEMAND_START, SERVICE_ERROR_IGNORE, DriverFileName, 0, 0, 0, 0, 0
	cmp eax, 0
	jz @f
	mov [hService], eax

	invoke StartService, [hService], 0, 0
       @@:
	ret

UnLoadDriver:
	invoke ControlService, [hService], SERVICE_CONTROL_STOP, temp
	invoke DeleteService, [hService]
	invoke CloseServiceHandle, [hService]
	invoke CloseServiceHandle, [hSCManager]

	ret

start:

	call LoadDriver
	cmp eax, 0
	jnz @f

	invoke MessageBox,0,MsgFail,DriverDisplayName,0
	jmp .exit
       @@:
	invoke MessageBox,0,MsgSuccess,DriverDisplayName,0

	invoke CreateFile, DeviceName, GENERIC_READ + GENERIC_WRITE, FILE_SHARE_READ, 0, OPEN_EXISTING, 0, 0
	mov [hDevice], eax

	invoke DeviceIoControl, eax, IOCTL_DUMP_GDT, 0, 0, Buffer, BufferSize, Readed, 0


	invoke CreateFile, DumpFileName, GENERIC_WRITE, FILE_SHARE_READ, 0, CREATE_ALWAYS, 0, 0
	push eax
	invoke WriteFile, eax, Buffer, [Readed], Readed, 0
	pop eax
	invoke CloseHandle, eax

	xor eax, eax
	mov ax, fs
	and al, 11111000b
	mov [inputData.Offset], eax
	mov [inputData.Size], 8
	invoke DeviceIoControl, [hDevice], IOCTL_DUMP_GDT, inputData, 8, FS_Descriptor, 8, Readed, 0

	mov esi, FS_Descriptor
	call DecodeDescriptor

	push eax
	push ecx

	mov eax, ebx
	mov ebx, 16
	mov esi, DescriptorInfo.BaseAddr
	call dword_to_STR

	pop eax
	mov ebx, 16
	mov esi, DescriptorInfo.Limit
	call dword_to_STR

	pop eax
	mov ebx, 16
	mov esi, DescriptorInfo.DPL
	call dword_to_STR

	invoke MessageBox, 0, DescriptorInfo, DriverDisplayName, 0

	invoke CloseHandle, [hDevice]

       .exit:
	call UnLoadDriver
	push 0
	call [ExitProcess]

section '.relocs' fixups readable writeable

section '.idata' import data readable writeable

  library kernel,'KERNEL32.DLL',\
	  user,'USER32.DLL',\
	  advapi, 'advapi32.dll'

  import kernel,\
	 ExitProcess,'ExitProcess',\
	 CreateFile, 'CreateFileA',\
	 DeviceIoControl, 'DeviceIoControl',\
	 CloseHandle, 'CloseHandle',\
	 WriteFile, 'WriteFile'

  import user,\
	 MessageBox,'MessageBoxA'

  import advapi,\
	 OpenSCManager, 'OpenSCManagerA',\
	 CreateService, 'CreateServiceA',\
	 DeleteService, 'DeleteService',\
	 CloseServiceHandle, 'CloseServiceHandle',\
	 StartService, 'StartServiceA',\
	 ControlService, 'ControlService'