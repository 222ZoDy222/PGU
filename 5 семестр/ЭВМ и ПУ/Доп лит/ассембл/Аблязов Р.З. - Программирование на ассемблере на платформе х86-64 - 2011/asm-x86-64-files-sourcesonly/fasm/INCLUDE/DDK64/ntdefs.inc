; Windows NT defines for win64
;
; Converted to Native FASM syntax by rpy3uH
;
; LAST UPDATE:      22.07.2010
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
  .LowPart  dq ?
  .HighPart dq ?
 }

struc LIST_ENTRY
 {
    .Flink dq ?
    .Blink dq ?
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



