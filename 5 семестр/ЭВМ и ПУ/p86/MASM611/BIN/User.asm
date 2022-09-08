;***************************************************************************
;���� ��� ��楤�� ���짮��⥫�.
;���, �ந�����騩 ���᫥��� � �ᯮ�짮������ ������ MMX, ᫥���
;����� ����� ��楤��� MMX_proc. ���, �ந�����騩 ���᫥��� ���
;�ᯮ�짮����� ������ MMX - ����� ��楤��� Simp_proc.
;����� ��楤�� �������� �����.
;��ࠬ���� � ��楤��� ��।����� �१ �⥪:
; - �� ����� +6 �࠭���� ᬥ饭�� ����� a_vector (��⮨� �� ᫮�)
;   � ᥣ���� ������;
; - �� ����� +8 �࠭���� ᬥ饭�� ����� b_vector (��⮨� �� ᫮�)
;   � ᥣ���� ������;
; - �� ����� +10 �࠭���� ������⢮ ����⮢ � ������ (�����
;   ����������� ࠧ���).
;�������� ���᫥��� � �ᯮ�짮������ ������ MMX �����뢠���� � ���ᨢ
; Result_mmx,१����� ���᫥��� ��� �ᯮ�짮����� ������ MMX - � ����
;� Result_simp. � ��६����� NumResArray �����뢠���� ������⢮ ����⮢
;� १������饬 ���ᨢ�.
;****************************************************************************

.model MEDIUM
;�ᯮ���㥬� �����
PUBLIC  MMX_proc,Simp_proc,OffsResMmx,OffsResSimp,NumResArray

STACK   SEGMENT PARA stack 'STACK'
        db 400h dup (?)
STACK   ENDS

DATA    SEGMENT PARA USE16 PUBLIC 'DATA'
SizeOff		DW	?
NumResArray     DW      ?               ;������⢮ ����⮢ � १������饬 ���ᨢ�
Temp		DD	40 DUP(?)
Result_mmx      DD      40 DUP(?)       ;���� � ����� ��� ����� १���� ���᫥��� ��楤��� � ��������� MMX
Result_simp     DD      40 DUP(?)       ;���� � ����� ��� ����� १���� ���᫥��� ��楤��� ��� ������ MMX
OffsResMmx      DW      Result_mmx      ;ᬥ饭�� ��砫� ���ᨢ� Result_mmx
OffsResSimp     DW      Result_simp     ;ᬥ饭�� ��砫� ���ᨢ� Result_simp
count           DW      ?
DATA    ENDS

CODE    SEGMENT
        ASSUME cs:code, ds:data, ss:stack
        .586
        .mmx
;***************************************************************************
;  ��楤�� ���᫥��� ᪠��୮�� �ந�������� ����஢ � �ᯮ��. MMX    *
;***************************************************************************
MMX_proc        proc    far
        push    bp
        mov     bp,sp
        pxor    mm7,mm7
        xor     ax,ax
	xor	dx,dx
        mov     si,ax
;        mov     si,[bp+6]               ;� si ���� ����� a_vector
        mov     di,[bp+8]               ;� di ���� ����� b_vector
        mov     cx,[bp+10]              ;� cx ������⢮ ����⮢ ����஢
;        mov     [count],cx
@@Loop1:
        movq    mm0,[si+bp+6]
        movq    mm1,[di]
        paddw   mm0,mm1
	
        movd    [Temp+si],mm0
        psrlq   mm0,32
        movd    [Temp+si],mm0
        add     si,8
        add     di,8
        loop    @@Loop1

	mov	cx,40
	mov	si,0
@@Loop11:
	movq	mm0,[Temp+si]	
	movq	mm1,mm0
	pand	mm1,0FFFFh
	movd	[Result_mmx+si],mm1
	psrlq	mm0,32
	add	si,8
	movd	[Result_mmx+si],mm0
	add	si,8
	loop	@@Loop11

        emms
        mov     NumResArray,40           ;१���� - �᫮
        pop     bp
        ret     6                       ;��室 � ���⪮� �⥪�
MMx_proc        endp
;*****************************************************************************
;  ��楤�� ���᫥��� ᪠��୮�� �ந�������� ����஢ ��� �ᯮ��. MMX    *
;*****************************************************************************
Simp_proc       proc    far
        push    bp
        mov     bp,sp
        xor     ax,ax
        mov     si,ax
;        mov     si,[bp+6]
        mov     di,[bp+8]
        mov     cx,[bp+10]
;       mov     [count],cx
;        xor     bx,bx
;       xor     cx,cx
@@Loop2:
        mov     ax,[si+bp+6]
        add     ax,word ptr [di]
;       add     cx,ax
;       adc     bx,dx
        mov     word ptr [Result_simp+si],ax
        add     si,2
        add     di,2
        loop    @@Loop2
;       sub     [count],1
;       jnz     @@Loop2
;       mov     word ptr [Result_simp],cx
;       mov     word ptr [Result_simp+2],bx
        mov     NumResArray,40
        pop     bp
        ret     6
Simp_proc       endp

CODE    ENDS
        END
