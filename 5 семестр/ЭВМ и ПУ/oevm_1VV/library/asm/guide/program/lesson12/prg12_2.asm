;prg_12_2.asm
MASM
MODEL	small
STACK	256
.data			;��砫� ᥣ���� ������
;⥪��� ᮮ�饭��:
mes1	db	'�� ࠢ�� 0!$',0ah,0dh
mes2	db	'ࠢ�� 0!$',0ah,0dh
mes3	db	0ah,0dh,'������� $'
mas	dw	2,7,0,0,1,9,3,6,0,8	;��室�� ���ᨢ
.code
.486			;�� ��易⥫쭮
main:
	mov	ax,@data
	mov	ds,ax	;�離� ds � ᥣ���⮬ ������
	xor	ax,ax	;���㫥��� ax
prepare:
	mov	cx,10	;���祭�� ���稪� 横�� � cx
	mov	esi,0	;������ � esi
compare:
	mov	dx,mas[esi*2]	;���� ������� ���ᨢ� � dx
	cmp	dx,0	;�ࠢ����� dx c 0
	je	equal	;���室, �᫨ ࠢ��
not_equal:		;�� ࠢ��
	mov	ah,09h	;�뢮� ᮮ�饭�� �� ��࠭
	lea	dx,mes3
	int	21h
	mov	ah,02h	;�뢮� ����� ������� ���ᨢ� �� ��࠭
	mov	dx,si
	add	dl,30h
	int	21h
	mov	ah,09h
	lea	dx,mes1
	int	21h
	inc	esi	;�� ᫥���騩 �������
	dec	cx	;�᫮��� ��� ��室� �� 横��
	jcxz	exit	;cx=0? �᫨ �� - �� ��室
	jmp	compare	;��� - ������� 横�
equal:		;ࠢ�� 0
	mov	ah,09h	;�뢮� ᮮ�饭�� mes3 �� ��࠭
	lea	dx,mes3
	int	21h
	mov	ah,02h
	mov	dx,si
	add	dl,30h
	int	21h
	mov	ah,09h	;�뢮� ᮮ�饭�� mes2 �� ��࠭
	lea	dx,mes2
	int	21h
	inc	esi	;�� ᫥���騩 �������
	dec	cx	;�� �������� ��ࠡ�⠭�?
	jcxz	exit
	jmp	compare
exit:
	mov	ax,4c00h	;�⠭����� ��室
	int	21h
end	main	;����� �ணࠬ��

