;
;  Long mode struct defines
;

;MSR indexes
IA32_STAR  equ 0C0000081h
IA32_LSTAR equ 0C0000082h
IA32_FMASK equ 0C0000084h
IA32_EFER  equ 0C0000080h


INTGATE64 equ 1110b
TRAPGATE64 equ 1111b
CALLGATE64 equ 1100b
TSS64_type equ 1001b

macro DEFINE_GATE64 selector, offset, IST, gate_type, DPL
{
	dd (offset and 0FFFFh) or (selector shl 16)
	dd (8000h or (DPL shl 13) or (gate_type shl 8) or IST) or ((offset shr 16) and 0FFFFh)
	dd (offset shr 32)
	dd 0
}

macro DEFINE_TSS64Descr BaseAddress, Limit
{
	dd (Limit and 0FFFFh) or ((BaseAddress and 0FFFFh) shl 16)
	dd ((BaseAddress shr 16) and 0FFh) or (TSS64_type shl 8) or (8 shl 12) or (Limit and 0F0000h) or (BaseAddress and 0FF000000h)
	dd (BaseAddress shr 32)
	dd 0
}

macro DEFINE_INTGATE64 selector, offset, IST
{
	DEFINE_GATE64 selector, offset, IST, INTGATE64, 0
}

macro DEFINE_TRAPGATE64 selector, offset, IST
{
	DEFINE_GATE64 selector, offset, IST, TRAPGATE64, 0
}

macro DEFINE_CALLGATE64 selector, offset
{
	DEFINE_GATE64 selector, offset, 0, CALLGATE64, 0
}


struc TSS64
{
  .TSSBase:
  dd ?
  .RSP0 dq ?
  .RSP1 dq ?
  .RSP2 dq ?
  dq ?
  .IST1 dq ?
  .IST2 dq ?
  .IST3 dq ?
  .IST4 dq ?
  .IST5 dq ?
  .IST6 dq ?
  .IST7 dq ?
  dq ?
  dw ?
  .IOMapBase dw $-.TSSBase
}
