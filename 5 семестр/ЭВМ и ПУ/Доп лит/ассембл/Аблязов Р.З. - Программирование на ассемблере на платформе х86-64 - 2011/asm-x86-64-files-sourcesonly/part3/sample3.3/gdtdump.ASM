format PE Native 4.0

include 'win32w.inc'
include 'DDK\ntstatus.inc'
include 'DDK\ntdefs.inc'
include 'DDK\ntddk.inc'
include 'DDK\macros.inc'
include 'DDK\advmacro.inc'

entry DriverEntry

section '.code' code readable writeable executable

IOCTL_DEFINE_EX IOCTL_DUMP_GDT, FILE_ANY_ACCESS, 1, METHOD_BUFFERED

UNICODE_STRING_define DeviceName, "\Device\devGDTDump"
UNICODE_STRING_define SymbolicLinkName, "\??\GDTDump"

DeviceObject dd 0

GDTR:
  .Limit    dw ?
  .Address  dd ?

proc DispatchControl pDeviceObject, pIrp

local status:DWORD

     push edi
     push esi
     push ecx
     push edx

     mov [status], STATUS_DEVICE_CONFIGURATION_ERROR

     mov edi, [pIrp]
     virtual at edi
      .edi IRP
     end virtual

     mov esi, [.edi.Tail.Overlay.CurrentStackLocation]
     virtual at esi
      .esi IO_STACK_LOCATION
     end virtual

     cmp [.esi.Parameters.DeviceIoControl.IoControlCode], IOCTL_DUMP_GDT
     jz .IOCTL_DUMP
     jmp .next
    .IOCTL_DUMP:
     ;int3
     sgdt fword [GDTR]
     xor ecx, ecx
     mov cx, [GDTR.Limit]
     inc ecx	; ecx = GDT size

     xor eax, eax
     mov edx, [.esi.Parameters.DeviceIoControl.InputBufferLength]
     cmp edx, 8
     jnz .copydata
     mov eax, [.edi.AssociatedIrp.SystemBuffer]
     mov edx, [eax+4]	 ; edx = needed data size
     mov eax, [eax]	 ; eax = start offset in GDT

     add edx, eax
     cmp edx, ecx
     jna @f
     mov edx, ecx
    @@:
     sub edx, eax	 ; edx = fact data size
     cmp edx, 7FFFFFFFh
     jna @f
     mov edx, 0
    @@:
     mov ecx, edx
    .copydata:
     mov [status], STATUS_BUFFER_TOO_SMALL
     cmp ecx, [.esi.Parameters.DeviceIoControl.OutputBufferLength]
     ja .error

     push ecx
     mov esi, [GDTR.Address]
     add esi, eax
     mov edx, edi      ; save EDI in EDX
     mov edi, [.edi.AssociatedIrp.SystemBuffer]
     rep movsb
     mov edi , edx     ; restore EDI

     pop [.edi.IoStatus.Information]

     mov [status], STATUS_SUCCESS
     jmp .exit

    .next:

     jmp .exit
    .error:
     mov [.edi.IoStatus.Information], 0
     jmp .exit

    .exit:
     push [status]
     pop [.edi.IoStatus.Status]

     fastcall IofCompleteRequest, edi, IO_NO_INCREMENT
     mov eax, [status]

     pop edx
     pop ecx
     pop esi
     pop edi
     ret

endp


proc DispatchCreate pDeviceObject, pIrp

    mov eax, [pIrp]
    virtual at eax
     .eax IRP
    end virtual

    mov [.eax.IoStatus.Status], STATUS_SUCCESS
    and [.eax.IoStatus.Information], 0

    mov ecx, [pIrp]
    mov edx, IO_NO_INCREMENT
    call [IofCompleteRequest]

    mov eax, STATUS_SUCCESS
    ret

endp

proc DispatchClose pDeviceObject, pIrp

    mov eax, [pIrp]
    virtual at eax
     .eax IRP
    end virtual

    mov [.eax.IoStatus.Status], STATUS_SUCCESS
    and [.eax.IoStatus.Information], 0

    mov ecx, [pIrp]
    mov edx, IO_NO_INCREMENT
    call [IofCompleteRequest]

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

    ;int3
    mov [status], STATUS_DEVICE_CONFIGURATION_ERROR

    invoke IoCreateDevice, [pDriverObject], 0, DeviceName, FILE_DEVICE_UNKNOWN, 0, FALSE, DeviceObject

    cmp eax, STATUS_SUCCESS
    jnz .END
    invoke IoCreateSymbolicLink, SymbolicLinkName, DeviceName
    cmp eax, STATUS_SUCCESS
    jnz .simlinkfail
    mov eax, [pDriverObject]
    virtual at eax
     .eax DRIVER_OBJECT
    end virtual

    mov [.eax.MajorFunction+IRP_MJ_CREATE*4], DispatchCreate
    mov [.eax.MajorFunction+IRP_MJ_CLOSE*4], DispatchClose
    mov [.eax.MajorFunction+IRP_MJ_DEVICE_CONTROL*4], DispatchControl
    mov [.eax.DriverUnload],  DriverUnloadHandler

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
