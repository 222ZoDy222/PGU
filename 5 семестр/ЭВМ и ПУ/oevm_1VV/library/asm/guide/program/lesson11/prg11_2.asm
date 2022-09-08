;prg_11_2.asm
MODEL	small
STACK	256
.data
match	db	0ah,0dh,'��ப� ᮢ������.','$'
failed	db	0ah,0dh,'��ப� �� ᮢ������','$'
string1	db	'0123456789',0ah,0dh,'$';��᫥�㥬� ��ப�
string2	db	'0123406789','$'
.code
ASSUME	ds:@data,es:@data	;�ਢ離� DS � ES � ᥣ����� ������
main:
	mov	ax,@data	;����㧪� ᥣ������ ॣ���஢
	mov	ds,ax
	mov	es,ax	;����ன�� ES �� DS
;�뢮� �� ��࠭ ��室��� ��ப string1 � string2
	mov	ah,09h
	lea	dx,string1
	int	21h
	lea	dx,string2
	int	21h
;��� 䫠�� DF - �ࠢ����� � ���ࠢ����� �����⠭�� ���ᮢ
	cld		
	lea	si,string1	;����㧪� � si ᬥ饭�� string1
	lea	di,string2	;����㧪� � di ᬥ饭�� string2
	mov	cx,10	;����� ��ப� ��� ��䨪� repe
;�ࠢ����� ��ப (���� �ࠢ������� �������� ��ப ࠢ��)
;��室 �� �����㦥��� �� ᮢ���襣� �������
cycl:
	repe	cmps	string1,string2
	jcxz	equal	;cx=0, � ���� ��ப� ᮢ������
	jne	not_match	;�᫨ �� ࠢ�� - ���室 �� not_match
equal:			;����, �᫨ ᮢ������, �
	mov	ah,09h	;�뢮� ᮮ�饭��
	lea	dx,match
	int	21h
	jmp	exit		;��室
not_match:			;�� ᮢ����
	mov	ah,09h
	lea	dx,failed
	int	21h	;�뢮� ᮮ�饭��
;⥯���, �⮡� ��ࠡ���� �� ᮢ���訩 ������� � ��ப�, ����室���  㬥����� ���祭�� ॣ���஢ si � di
	dec	si
	dec	di
;ᥩ�� � ds:si � es:di ���� ��ᮢ����� ������⮢
;����� ��⠢��� ��� �� ��ࠡ�⪥ ��ᮢ���襣� �������
��᫥ �⮣� �த������ ���� � ��ப�:
	inc	si
	inc	di
	jmp	cycl
exit:			;��室
	mov	ax,4c00h
	int	21h
end	main		;����� �ணࠬ��

