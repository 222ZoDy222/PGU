stseg   segment para    stack
        dw      16      dup(?)
stseg   ends
dseg    segment para
dseg    ends
cseg    segment para

lab6    proc    far
        assume  cs:cseg,ds:dseg,ss:stseg
        push    ds
        mov     ax,0
        push    ax
        mov     ax,dseg
        mov     ds,ax
		
		mov ah, 0fh
		int 10h
		mov cl, al ; ��������� ����������
		
		; 2 �������� ���������� �������
		;mov ah, 00h
		;int 16h
		;mov bl, al ; ��������� ������
		mov ah, 01h
		int 21h
		mov bl, al
				
		; ����� �����
		mov ah, 00h
		mov al, 7
		int 10h
		
		; ����� �� ������
		mov al, bl
		mov ah, 0eh
		int 10h
		
		; ����� ��� ��������� ����������, ����� ������� �����
		mov ah, 00h
		int 16h
		
		; ������������ ����������
		mov ah, 00h
		mov al, cl
		int 10h
	  	ret
lab6    endp
cseg    ends
        end     lab6
