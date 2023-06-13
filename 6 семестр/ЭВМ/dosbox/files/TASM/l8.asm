stseg   segment para    stack
        dw      16      dup(?)
stseg   ends
dseg    segment para

Notes			dw		4571, 4072, 3626, 3418, 3043, 2711, 2420
					;���� ��, ��, ��, ��, ����, ��, ��
Num_notes 		dw      7
dseg    ends
cseg    segment para


lab7    proc    far
        assume  cs:cseg,ds:dseg,ss:stseg
        push    ds
        mov     ax,0
        push    ax
        mov     ax,dseg
        mov     ds,ax
		GATE			EQU		61h		; ����, ��� 1 - ����������� ������ ��������
		COMMAND_REG 	EQU 	43h		; ��������� �������
		CHANNEL_2 		EQU 	42h		; ����� 2 �������
		PLUS			EQU		2Bh
		MINUS			EQU		2Dh
		ESCAPE			EQU		1Bh
		
		
		lea si, Notes
		mov cx, Num_notes
		; cx - ������� ������� �������
		sub cx,1
		sal cx,1				
		
		new_note:
		call SoundStop
		
		; ��������� ����� 43
		mov al, 10110110b
		out COMMAND_REG, al
		
		mov ax, [si]
		out CHANNEL_2, al
		mov al, ah
		out CHANNEL_2, al
		
		call SoundStart
		
		; �������� ������� �������
		wait_key:
		mov ah,0
		int 16h
		
		cmp	al, ESCAPE	; ���������� ������
		je exit
		
		cmp al, PLUS	; ��������� ����
		je high_note
		
		cmp al, MINUS
		je low_note		; ���������� ����
		
		; ����������� �������
		jmp wait_key
		
		high_note:
		; ��������� �����������
		cmp si,	cx
		je wait_key ; ���� ������� ������� �������, ������ �� ������
		inc si
		inc si
		jmp new_note
		
		low_note:
		; ��������� ����������
		cmp si,0
		je wait_key
		dec si
		dec si
		jmp new_note
		
		exit:
		call SoundStop
		
		ret
lab7 endp

; ����������� ������� � ��������
SoundStart proc near
		in al, GATE
		or al, 11111111b
		out GATE, al
		ret
SoundStart endp

; ���������� ������� �� ��������
SoundStop proc near
		in al, GATE
		and al, 11111110b
		out GATE, al
		ret
SoundStop endp

cseg    ends
        end     lab7



