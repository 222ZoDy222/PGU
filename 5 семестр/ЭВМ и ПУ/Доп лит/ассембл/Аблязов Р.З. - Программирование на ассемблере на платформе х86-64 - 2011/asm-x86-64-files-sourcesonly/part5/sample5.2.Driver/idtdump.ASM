format PE64 native 5.02

include 'win64w.inc'
include 'DDK64\ntstatus.inc'
include 'DDK64\ntdefs.inc'
include 'DDK64\ntddk.inc'
include 'DDK64\macros.inc'
include 'DDK64\advmacro.inc'

entry DriverEntry

section '.code' code readable writeable executable

IOCTL_DEFINE_EX IOCTL_DUMP_IDT, FILE_ANY_ACCESS, 1, METHOD_BUFFERED

UNICODE_STRING_define DeviceName, "\Device\devIDTDump"
UNICODE_STRING_define SymbolicLinkName, "\??\IDTDump"

DeviceObject dq 0

IDTR:
  .Limit    dw ?
  .Address  dq ?

proc DispatchControl pDeviceObject, pIrp

local status:DWORD

     push rdi
     push rsi
     push rbx
     sub rsp, 8       ; for align stack

     mov [status], STATUS_DEVICE_CONFIGURATION_ERROR

     virtual at rdx	; rdx = pIRP
      .rdx IRP
     end virtual

     mov rsi, [.rdx.Tail.Overlay.CurrentStackLocation]
     virtual at rsi
      .rsi IO_STACK_LOCATION
     end virtual

     cmp [.rsi.Parameters.DeviceIoControl.IoControlCode], IOCTL_DUMP_IDT
     jz .IOCTL_DUMP
     jmp .next
    .IOCTL_DUMP:
     sidt tword [IDTR]
     xor rcx, rcx
     mov cx, [IDTR.Limit]
     inc rcx	; ecx = IDT size

     xor rax, rax
     xor rbx, rbx
     mov ebx, [.rsi.Parameters.DeviceIoControl.InputBufferLength]
     cmp ebx, 8
     jnz .copydata
     mov rax, [.rdx.AssociatedIrp.SystemBuffer]
     mov ebx, [rax+4]	 ; ebx = needed data size
     mov eax, [rax]	 ; eax = start offset in GDT

     add rbx, rax
     cmp rbx, rcx
     jna @f
     mov rbx, rcx
    @@:
     sub rbx, rax	 ; ebx = fact data size
     cmp rbx, 7FFFFFFFh
     jna @f
     mov rbx, 0
    @@:
     mov rcx, rbx
    .copydata:
     mov [status], STATUS_BUFFER_TOO_SMALL
     cmp ecx, [.rsi.Parameters.DeviceIoControl.OutputBufferLength]
     ja .error

     mov rbx, rcx		  ;  save rcx in rbx, rbx = data size
     mov rsi, [IDTR.Address]
     add rsi, rax
     mov rdi, [.rdx.AssociatedIrp.SystemBuffer]
     rep movsb

     mov [.rdx.IoStatus.Information], rbx  ; IoStatus.Information = copied data size

     mov [status], STATUS_SUCCESS
     jmp .exit

    .next:

     jmp .exit
    .error:
     mov [.rdx.IoStatus.Information], 0

    .exit:
     mov eax, [status]
     mov  [.rdx.IoStatus.Status], eax

     invoke IofCompleteRequest, rdx, IO_NO_INCREMENT
     mov eax, [status]

     add rsp ,8
     pop rbx
     pop rsi
     pop rdi
     ret

endp


proc DispatchCreate pDeviceObject, pIrp

    virtual at rdx
     .rdx IRP
    end virtual

    mov [.rdx.IoStatus.Status], STATUS_SUCCESS
    and [.rdx.IoStatus.Information], 0

    sub rsp, 32
    mov rcx, rdx
    mov rdx, IO_NO_INCREMENT
    call [IofCompleteRequest]
    add rsp, 32

    mov eax, STATUS_SUCCESS
    ret

endp

proc DispatchClose pDeviceObject, pIrp

    virtual at rdx
     .rdx IRP
    end virtual

    mov [.rdx.IoStatus.Status], STATUS_SUCCESS
    and [.rdx.IoStatus.Information], 0

    sub rsp, 32
    mov rcx, rdx
    mov rdx, IO_NO_INCREMENT
    call [IofCompleteRequest]
    add rsp, 32

    mov eax, STATUS_SUCCESS
    ret

endp



proc DriverUnloadHandler pDriverObject

    invoke IoDeleteSymbolicLink, SymbolicLinkName
    invoke IoDeleteDevice, [DeviceObject]
    ret
endp


proc DriverEntry pDriverObject, pusRegistryPath

local status:DWORD

    mov [pDriverObject], rcx
    mov [status], STATUS_DEVICE_CONFIGURATION_ERROR

    invoke IoCreateDevice, [pDriverObject], 0, DeviceName, FILE_DEVICE_UNKNOWN, 0, FALSE, DeviceObject

    cmp eax, STATUS_SUCCESS
    jnz .END
    invoke IoCreateSymbolicLink, SymbolicLinkName, DeviceName
    cmp eax, STATUS_SUCCESS
    jnz .simlinkfail
    mov rax, [pDriverObject]
    virtual at rax
     .rax DRIVER_OBJECT
    end virtual

    mov rdx, DispatchCreate
    mov [.rax.MajorFunction+IRP_MJ_CREATE*8], rdx
    mov rdx, DispatchClose
    mov [.rax.MajorFunction+IRP_MJ_CLOSE*8], rdx
    mov rdx, DispatchControl
    mov [.rax.MajorFunction+IRP_MJ_DEVICE_CONTROL*8], rdx
    mov rdx,  DriverUnloadHandler
    mov [.rax.DriverUnload], rdx

    mov [status], STATUS_SUCCESS
    jmp .END
   .simlinkfail:
    invoke IoDeleteDevice, [DeviceObject]
   .END:

    mov eax, [status]
    ret

endp

section '.relocs' fixups readable writeable discardable

section '.idata' import readable writeable

  library ntoskrnl,'ntoskrnl.exe'

  import ntoskrnl,\
	 IoCreateDevice, 'IoCreateDevice',\
	 IoCreateSymbolicLink, 'IoCreateSymbolicLink',\
	 IoDeleteDevice, 'IoDeleteDevice',\
	 IoDeleteSymbolicLink, 'IoDeleteSymbolicLink',\
	 IofCompleteRequest, 'IofCompleteRequest'
