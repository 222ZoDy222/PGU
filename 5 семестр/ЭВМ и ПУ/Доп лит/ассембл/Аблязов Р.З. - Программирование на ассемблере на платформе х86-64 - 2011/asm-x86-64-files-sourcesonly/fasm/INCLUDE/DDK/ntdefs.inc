; Converted to Native FASM syntax by rpy3uH
;
; LAST UPDATE:      14.07.2010
;
; E-mail:     gruzino.abhaz[a]gmail.com
;-------------------------------------------------------------------------------

MAXIMUM_SUPPORTED_EXTENSION	 = 512
SIZE_OF_80387_REGISTERS 	 = 80
EXCEPTION_MAXIMUM_PARAMETERS  = 15

EXCEPTION_BREAKPOINT   equ     STATUS_BREAKPOINT
EXCEPTION_ACCESS_VIOLATION equ STATUS_ACCESS_VIOLATION
EXCEPTION_INT_DIVIDE_BY_ZERO equ STATUS_INTEGER_DIVIDE_BY_ZERO
EXCEPTION_IN_PAGE_ERROR equ STATUS_IN_PAGE_ERROR
EXCEPTION_ILLEGAL_INSTRUCTION equ STATUS_ILLEGAL_INSTRUCTION
EXCEPTION_NONCONTINUABLE_EXCEPTION equ STATUS_NONCONTINUABLE_EXCEPTION
EXCEPTION_PRIV_INSTRUCTION equ STATUS_PRIVILEGED_INSTRUCTION
EXCEPTION_SINGLE_STEP equ STATUS_SINGLE_STEP
EXCEPTION_STACK_OVERFLOW equ STATUS_STACK_OVERFLOW

ExceptionContinueExecution equ 0
ExceptionContinueSearch    equ 1
ExceptionNestedException   equ 2
ExceptionCollidedUnwind    equ 3     

EH_NONCONTINUABLE   equ 0x01
EH_UNWINDING        equ 0x02
EH_EXIT_UNWIND      equ 0x04
EH_STACK_INVALID    equ 0x08
EH_NESTED_CALL      equ 0x10
EXCEPTION_CONTINUABLE        equ 0
EXCEPTION_NONCONTINUABLE     equ EH_NONCONTINUABLE

struc LARGE_INTEGER
 {
  .LowPart dd ?
  .HighPart dd ?
 }

struc LIST_ENTRY
 {
    .Flink dd ?
    .Blink dd ?
 }

struc SERVICE_STATUS 
 {
  .dwServiceType	 	dd ?
  .dwCurrentState        	dd ? 
  .dwControlsAccepted    	dd ?  
  .dwWin32ExitCode       	dd ?  
  .dwServiceSpecificExitCode 	dd ?  
  .dwCheckPoint	       		dd ? 
  .dwWaitHint	       		dd ?
 }

struc FLOATING_SAVE_AREA
 {
  .ControlWord	dd	?
  .StatusWord	dd	?
  .TagWord	dd	?
  .ErrorOffset	dd	?
  .ErrorSelector dd	?
  .DataOffset	dd	?
  .DataSelector	dd	?
  .RegisterArea	db  SIZE_OF_80387_REGISTERS dup(?)
  .Cr0NpxState	dd	?
 }

struc EXCEPTION_RECORD
{
  .ExceptionCode dd ?
  .ExceptionFlags dd ?
  .ExceptionRecord dd ?
  .ExceptionAddress dd ?
  .NumberParameters dd ?
  .ExceptionInformation dd EXCEPTION_MAXIMUM_PARAMETERS dup (?) 
}

struc CONTEXT
 {
  .ContextFlags	dd	?
  .iDr0		dd	?
  .iDr1		dd	?
  .iDr2		dd	?
  .iDr3		dd	?
  .iDr6		dd	?
  .iDr7		dd	?
  .FloatSave	FLOATING_SAVE_AREA
  .regGs 	dd	?
  .regFs 	dd	?
  .regEs 	dd	?
  .regDs 	dd	?
  .regEdi	dd	?
  .regEsi	dd	?
  .regEbx	dd	?
  .regEdx	dd	?
  .regEcx	dd	?
  .regEax	dd	?
  .regEbp	dd	?
  .regEip	dd	?
  .regCs 	dd	?
  .regFlag	dd	?
  .regEsp	dd	?
  .regSs 	dd	?
  .ExtendedRegisters db MAXIMUM_SUPPORTED_EXTENSION dup(?)
 }