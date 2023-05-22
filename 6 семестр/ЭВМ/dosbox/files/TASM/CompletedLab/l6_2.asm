stseg   segment para    stack
        dw      16      dup(?)
stseg   ends
dseg    segment para
numSymb  dw  640  ; ��� ����� ����� ��������� ����� 640 ��������
mas     db  'Gorbunov Isaev'
masLen	dw 14
x		dw 	80
y		dw	25
dseg    ends
cseg    segment para


lab6    proc    far
        assume  cs:cseg,ds:dseg,ss:stseg
        push    ds
        mov     ax,0
        push    ax
        mov     ax,dseg
        mov     ds,ax
		
		
		; ����� ����� - 3 (������� ����� 80*25)
		mov ah, 00h
		mov al, 3
		int 10h
		
		mov dh,0
		mov cx, numSymb
		mov bl, 0h
		call printLine
		
		mov dh, 8
		mov cx, numSymb
		mov bl, 40h
		call printLine

		mov dh, 16
		mov cx, numSymb
		add cx, 80
		mov bl, 60h
		call printLine
		
		
		; ��������� ������ �� ��������
		mov ah, 02h
		mov bh, 0
		mov dh, 12
		mov dl,30
		int 10h
		
		; ����� �����
		lea si, mas
		mov ah, 0eh
		mov cx, masLen
		
		printName:
		mov al, [si]
		int 10h
		inc si
		loop printName
		
		
		; ����� ��� ��������� ����������, ����� ������� �����
		mov ah, 00h
		int 16h
		
	  
		ret
lab6    endp

; ��������� - dh - ������, � ������� ���������� �����, bl - ���� ��������, cx- ����� ��������
printLine proc near

		; ��������� ������� �������
		mov ah, 02h
		mov bh, 0
		mov dl,0
		int 10h
		
		mov ah, 9
		mov al, 20h	; ������
		mov bh, 0	; �������������
		int 10h
		ret

printLine endp 

cseg    ends
        end     lab6



