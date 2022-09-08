format PE64 GUI 5.0

include 'win64a.inc'
include 'DDK64\scm.inc'
include 'DDK64\ntddk.inc'
include 'DDK64\advmacro.inc'
include 'DDK64\ntdefs.inc'

entry start

IOCTL_DEFINE_EX IOCTL_DUMP_IDT, FILE_ANY_ACCESS, 1, METHOD_BUFFERED

section '.data' data readable writeable

DriverFileName db 'E:\FASMW166\projects\DriverWin64\idtdump.sys',0
DriverServiceName db 'idtdump',0
DeviceName db '\\.\IDTDump',0
DriverDisplayName db 'IDT dumper',0

DumpFileName db 'idt.dat',0

MsgSuccess db 'Driver successful loaded!',0
MsgFail db 'Driver load failed!',0

hSCManager dq ?
hService   dq ?
hDevice    dq ?
Readed	   dq ?

temp SERVICE_STATUS

inputData:
    .Offset dd ?
    .Size  dd ?

GateDescriptor dq ?
	       dq ?

DescriptorInfo:
   db 'Address : '
.Address db '                '
	  db 13, 10
   db 'Segment selector : '
.Segment    db '    '
	  db 13, 10
   db 'Gate type : '
.GateType     db '      ',0


align 10h
Buffer db 10000h dup (?)
BufferSize = $-Buffer

section '.code' code readable executable

qword_to_STR:
;IN       RAX number
;         RSI pointer to string
;         EBX разрядность результата
      push rbx
      push rcx
      push rdi
      push rsi
      push rdx
      push rax

      cmp ebx, 16
      ja  .end

      xor rcx, rcx
      sub rsp, 32

    .repeat:
      xor rdx, rdx
      div rbx
      mov rdi, rax
      mov al, dl
      cmp al, 10
      jnb .hex
      add al, 30h
      jmp @f
     .hex:
      add al, 55
     @@:
      mov byte [rsp+rcx], al
      mov rax, rdi

      inc rcx
      cmp rax, 0
      jz .endrep
      jmp .repeat
    .endrep:
      mov rdi, rsp
      add rdi, rcx
    .copyrep:
      dec rdi
      mov dl, byte [rdi]
      mov byte [rsi], dl
      inc rsi
      loop .copyrep

      add rsp ,32
    .end:
      pop rax
      pop rdx
      pop rsi
      pop rdi
      pop rcx
      pop rbx
      ret

DecodeDescriptor:
;IN
;    RSI - Pointer to descriptor
;OUT
;    RBX - Address
;    ECX - segment selector
;    EAX - Gate type
	push rdx

	mov ebx, [rsi]
	and ebx, 0FFFFh
	mov edx, [rsi+4]
	and edx, 0FFFF0000h
	or ebx, edx
	mov edx, [rsi+8]
	shl rdx, 32
	or rbx, rdx	;rbx = descriptor address

	mov ecx, [rsi]
	shr ecx , 16	; ecx = segment selector

	mov eax, [rsi+4]
	shr eax, 8
	and eax, 0Fh	; eax = gate type

	pop rdx
	ret


LoadDriver:
	invoke OpenSCManager, 0, 0, SC_MANAGER_ALL_ACCESS
	cmp rax, 0
	jz @f
	mov [hSCManager], rax

	invoke CreateService, eax, DriverServiceName, DriverDisplayName, SERVICE_START + SERVICE_STOP + DELETE, SERVICE_KERNEL_DRIVER, \
	 SERVICE_DEMAND_START, SERVICE_ERROR_IGNORE, DriverFileName, 0, 0, 0, 0, 0
	cmp eax, 0
	jz @f
	mov [hService], rax

	invoke StartService, [hService], 0, 0
       @@:
	ret

UnLoadDriver:	; stack not aligned!!!
	sub rsp, 8    ; align stack
	invoke ControlService, [hService], SERVICE_CONTROL_STOP, temp
	invoke DeleteService, [hService]
	invoke CloseServiceHandle, [hService]
	invoke CloseServiceHandle, [hSCManager]
	add rsp, 8
	ret

start:
	sub rsp, 8 ; align stack

	call LoadDriver
	cmp eax, 0
	jnz @f

	invoke MessageBox, 0, MsgFail, DriverDisplayName, 0
	jmp .exit
       @@:
	invoke MessageBox, 0, MsgSuccess, DriverDisplayName, 0

	invoke CreateFile, DeviceName, GENERIC_READ + GENERIC_WRITE, FILE_SHARE_READ, 0, OPEN_EXISTING, 0, 0
	mov [hDevice], rax

	invoke DeviceIoControl, rax, IOCTL_DUMP_IDT, 0, 0, Buffer, BufferSize, Readed, 0


	invoke CreateFile, DumpFileName, GENERIC_WRITE, FILE_SHARE_READ, 0, CREATE_ALWAYS, 0, 0
	push rax
	invoke WriteFile, rax, Buffer, [Readed], Readed, 0
	pop rax
	invoke CloseHandle, rax

	mov [inputData.Offset], 14*16
	mov [inputData.Size], 16
	invoke DeviceIoControl, [hDevice], IOCTL_DUMP_IDT, inputData, 8, GateDescriptor, 16, Readed, 0

	mov rsi, GateDescriptor
	call DecodeDescriptor

	push rax
	push rcx

	mov rax, rbx
	mov rbx, 16
	mov rsi, DescriptorInfo.Address
	call qword_to_STR

	pop rax
	mov ebx, 16
	mov rsi, DescriptorInfo.Segment
	call qword_to_STR

	pop rax
	mov ebx, 2
	mov rsi, DescriptorInfo.GateType
	call qword_to_STR

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