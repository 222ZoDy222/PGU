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
;� १������饬 ���ᨢ�. � ��६����� ElemSize �����뢠���� ࠧ��� (0 - ����,
;1 - ᫮��, 2 - ������� ᫮��) ����� १������饣� ���ᨢ�.
;****************************************************************************

.model MEDIUM
;�ᯮ���㥬� �����
PUBLIC  MMX_proc,Simp_proc,OffsResMmx,OffsResSimp,NumResArray,ElemSize

STACK   SEGMENT PARA stack 'STACK'
        db 400h dup (?)
STACK   ENDS

DATA    SEGMENT PARA USE16 PUBLIC 'DATA'
NumResArray     DW      ?               ;������⢮ ����⮢ � १������饬 ���ᨢ�
ElemSize        DB      0FFh
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
;          ��楤�� ���᫥��� �㬬� ���� ����஢ � �ᯮ��. MMX         *
;***************************************************************************
MMX_proc        proc    far
        push    bp
        mov     bp,sp
        pxor    mm7,mm7
        mov     si,[bp+6]               ;� si ���� ����� a_vector
        mov     di,[bp+8]               ;� di ���� ����� b_vector
        mov     cx,[bp+10]              ;� cx ������⢮ ����⮢ ����஢
@@Loop1:
        movq    mm0,[si]
        movq    mm1,[di]
        paddw   mm0,mm1
        movq    qword ptr [Result_mmx+si],mm0
        add     si,8
        add     di,8
        loop    @@Loop1
        emms
        mov     NumResArray,40          ;१���� - �᫮ (���� ����� ���ᨢ�)
        mov     ElemSize,1              ;ࠧ��� ����� ���ᨢ� - ������� ᫮��
        pop     bp
        ret     6                       ;��室 � ���⪮� �⥪�
MMX_proc        endp
;*****************************************************************************
;           ��楤�� ���᫥��� �㬬� ���� ����஢ ��� �ᯮ��. MMX        *
;*****************************************************************************
Simp_proc       proc    far
        push    bp
        mov     bp,sp
        mov     si,[bp+6]
        mov     di,[bp+8]
        mov     cx,[bp+10]
@@Loop2:
        mov     ax,word ptr[si]
        add     ax,word ptr [di]
        mov     word ptr [Result_simp+si],ax
        add     si,2
        add     di,2
        loop    @@Loop2
        mov     NumResArray,40
        mov     ElemSize,1
        pop     bp
        ret     6
Simp_proc       endp

CODE    ENDS
        END
