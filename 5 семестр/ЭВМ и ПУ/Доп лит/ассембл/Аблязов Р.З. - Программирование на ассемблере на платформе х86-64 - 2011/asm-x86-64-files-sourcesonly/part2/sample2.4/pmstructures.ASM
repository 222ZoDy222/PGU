
IA32_SYSENTER_CS  equ 174h
IA32_SYSENTER_ESP equ 175h
IA32_SYSENTER_EIP equ 176h

 TASK_GATE_TYPE equ 10000101b	 ; DPL = 0

 INT_GATE_TYPE equ 1000111000000000b ; DPL = 0

 TSS_TYPE equ 10001001b   ; DPL = 0

struc GDTR32
      {
       .Limit dw ?
       .BaseAddress dd ?
      }


macro DEFINE_INT_GATE _address,_code_selektor
      {
       dw   _address and 0FFFFh
       dw   _code_selektor
       dw INT_GATE_TYPE
       dw _address shr 16
      }

macro DEFINE_TASK_GATE _tss_selektor
      {
       dw 0
       dw _tss_selektor
       db 0
       db TASK_GATE_TYPE
       dw 0
      }

macro DEFINE_TSS_DESCRIPTOR _base_address,_limit
      {
       dw   _limit and 0FFFFh
       dw _base_address and 0FFFFh
       db (_base_address shr 16) and 0FFh
       db TSS_TYPE
       db (_limit shr 16) and 0Fh
       db _base_address shr 24
      }

struc TSS32

  {
    .PreviousTaskLink dw ?
    .Reserved0 dw ?	   ;--4

    .ESP0      dd ?
    .SS0       dw ?
    .Reserved1 dw ?	   ;--12

    .ESP1      dd ?
    .SS1       dw ?
    .Reserved2 dw ?	   ; 20

    .ESP2      dd ?
    .SS2       dw ?
    .Reserved3 dw ?	   ; 28

    .tsCR3    dd ?
    .tsEIP    dd ?	   ; 36
    .tsEFLAGS dd ?
    .tsEAX    dd ?	  ;  44

    .tsECX    dd ?
    .tsEDX    dd ?	  ;52
    .tsEBX    dd ?
    .tsESP    dd ?	  ; 60

    .tsEBP    dd ?
    .tsESI    dd ?
    .tsEDI    dd ?	  ;72

    .tsES      dw ?
    .Reserved4 dw ?	  ; 76
    .tsCS      dw ?
    .Reserved5 dw ?
    .tsSS      dw ?
    .Reserved6 dw ?
    .tsDS      dw ?
    .Reserved7 dw ?
    .tsFS      dw ?
    .Reserved8 dw ?
    .tsGS      dw ?
    .Reserved9 dw ?

    .LDTSegmentSelector dw ?
    .Reserved10 dw ?
    .DebugByte	db ?
    .Reserved11 db ?
    .IOMapBaseAddress dw ?
  }