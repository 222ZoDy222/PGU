;---------------------------
; Porcessor in long mode
; stack pointer = 08000h
; avail virtual memory 0h-200000h
;---------------------------

LM_CODE_START:
	mov rsi, message2
	mov rdi, 0B8000h
	mov rcx, mess2end-message2
	rep movsb
	jmp $

message2 db "W5e5 5i5n5 5l5o5n5g5 5m5o5d5e5!5"
mess2end: