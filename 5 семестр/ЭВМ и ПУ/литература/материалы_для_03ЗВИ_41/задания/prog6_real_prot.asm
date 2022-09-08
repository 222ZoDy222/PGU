;  prog6.asm
; �ணࠬ�� ���室� � ���饭�� ०��
; � ���⭮

.486P		;ࠧ�襭�� ������権 ���饭���� ०���
.MODEL	large

                ;������� ��� ���ᠭ�� ���ਯ�஢ ᥣ���⮢

descr	STRUC       ; ���ਯ�� ᮤ�ন� ��ᥬ� ����

limit	dw	0
base_1	dw	0
base_2	db	0
attr	db	0
lim_atr	db	0
base_3	db	0
         ENDS

                ; ����� ���樠����樨 ���ਯ�஢
                ; ��� ���������� ����� ���� � ࠧ��� ᥣ����
load_descr	MACRO	des,seg_addr,seg_size
 	mov	des.limit,seg_size
 	xor	eax,eax
 	mov	ax,seg_addr
 	shl	eax,4
 	mov	des.base_1,ax
 	rol	eax,16
 	mov	des.base_2,al
        	ENDM


;������� ��� ����㧪� ॣ���� gdtr
point	STRUC
lim	dw	0
adr	dd	0
	ENDS

   ;   ��砫� ᥣ���� �⥪� �ணࠬ��

stk	segment	stack 'stack' use16
	db	256 dup (0)
stk	ends

    ;  ⠡��� ��������� ���ਯ�஢

gdt_seg	segment	para public 'data' use16
gdt_0	        descr	<0,0,0,0,0,0>	        ; ���⮩ ���ਯ��
gdt_gdt_8	descr	<0,0,0,92h,0,0> ; ���ਯ�� ᠬ�� GDT ��� ᥣ����
gdt_ldt_10	descr	<0,0,0,0,0,0>   ; �� �ᯮ��㥬 
gdt_ds_18	descr	<0,0,0,92h,0,0> ; ���ਯ�� ᥣ���� ������
gdt_es_vbf_20	descr	<0,0,0,92h,0,0>	; ���������
gdt_ss_28	descr	<0,0,0,92h,0,0>	; ᥣ���� �⥪�
gdt_cs_30	descr	<0,0,0,9ah,0,0>	; ᥣ���� ����
gdt_size=$-gdt_0-1              	; ࠧ��� GDT ����� 1
                  GDT_SEG ENDS

               ;����� �ணࠬ��
data	segment	para public 'data' use16	;ᥣ���� ������
point_gdt	point	<gdt_size,0>
stroka_1	db "�ணࠬ�� ���諠 � ���饭�� ०�� ࠡ��� ������"
dlina=$-stroka_1
stroka_2        db      '᭮�� ���室 � ॠ��� ०��','$'
data_size=$-point_gdt-1
data	ends

               ; ������ ᥣ���� �ணࠬ��
code	segment	byte public 'code' use16
;ᥣ���� ���� � 16-ࠧ�來� ०���� ����樨
assume	cs:code,ss:stk
main	proc
	mov	ax,stk
	mov	ss,ax
;������塞 ⠡���� ��������� ���ਯ�஢
assume	ds:gdt_seg
	mov	ax,gdt_seg
	mov	ds,ax
	load_descr	gdt_gdt_8,GDT_SEG,gdt_size ; GDT_SEG - ���� GDT
                                                   ; gdt_size - ࠧ��� gdt
	load_descr	gdt_ds_18,DATA,data_size   ; DATA - ���� ᥣ���� 
                                                   ; ������, data_size -
                                                   ; ࠧ��� ᥣ���� ������ 
	load_descr	gdt_es_vbf_20,0b800h,3999  ; 0b800h - ���� ���������
                                                   ; � ⥪�⮢�� ०���
                                                   ; 3999 - ����� � �����
	load_descr	gdt_ss_28,STK,255          ; ࠧ��� �⥪� - 255
	load_descr	gdt_cs_30,CODE,0ffffh	   ; ࠧ��� �������� ᥣ����
                                                   ; ���� 64 �����
assume	ds:data
	mov	ax,data
	mov	ds,ax
;����㦠�� gdtr
	xor	eax,eax
	mov	ax,gdt_seg
	shl	eax,4
	mov	point_gdt.adr,eax
	lgdt	point_gdt
;����頥� ���뢠���
	cli
	mov	al,80h
	out	70h,al
;��४��砥��� � ���饭�� ०��
	mov	eax,cr0
	or	al,1
	mov	cr0,eax
;����ࠨ���� ॣ�����
	db	0eah	;��設�� ��� ������� jmp
	dw	offset protect	;ᬥ饭�� ��⪨ ���室�
			;� ᥣ���� ������
	dw	30h	;ᥫ���� ᥣ���� ����
			;� ⠡��� GDT
protect:
;����㧨�� ᥫ����� ��� ��⠫��� ���ਯ�஢
	mov	ax,18h  ; 18h - �� ᬥ饭��(index) ᥣ���� ������ � GDT
	mov	ds,ax   ; ��� � ॣ���� ds
	mov	ax,20h  ; 20h - �� ᬥ饭��(index) ᥣ���� ��������� 
	mov	es,ax   ; ��� � ॣ���� es
	mov	ax,28h  ; 28h - �� ᬥ饭��(index) ᥣ���� �⥪� � GDT
	mov	ss,ax   ; ��� � ॣ���� ss
;ࠡ�⠥� � ���饭��� ०���:
;�뢮��� ��ப� � ���������
	mov	cx,dlina	;����� ᮮ�饭��
	mov	si,offset stroka_1	;���� ��ப� ᮮ�饭��
	mov	di,1920	;��砫�� ���� ��������� ��� �뢮��
	mov	ah,07h	;��ਡ�� �뢮����� ᨬ�����

outstr:
	mov	al,[si]
	mov	es:[di],ax
	inc	si
	inc	di
	inc	di
	loop	outstr

;�ନ஢���� ���ਯ�஢ ��� ॠ�쭮�� ०���
; 㬥��蠥� ࠧ���� �� ���� ॠ�쭮�� ०��� - 0ffffh=64 �����
	assume	ds:gdt_seg
	mov	ax,8h
	mov	ds,ax
	mov	gdt_ds_18.limit,0ffffh
	mov	gdt_es_vbf_20.limit,0ffffh
	mov	gdt_ss_28.limit,0ffffh
	mov	gdt_cs_30.limit,0ffffh
assume	ds:data
;᭮�� ����㧪� ॣ���஢ ���ਯ�஢
	mov	ax,18h
	mov	ds,ax
	mov	ax,20h
	mov	es,ax
	mov	ax,28h
	mov	ss,ax

	db	0eah         ; ᭮�� ������� JMP
	dw	offset jump
	dw	30h
jump:
	mov	eax,cr0      ; ��४��祭�� � ॠ��� ०�� 
	and	al,0feh      
	mov	cr0,eax
	db	0eah         ; � �� ������� JMP
	dw	offset r_mode
	dw	code
r_mode:
	mov	ax,data
	mov	ds,ax
	mov	ax,stk
	mov	ss,ax
;ࠧ�蠥� ���뢠���
	sti
	xor	al,al
	out	70h,al
;����砭�� ࠡ��� �ணࠬ��
        mov     ah,09h
        lea     dx,stroka_2
        int     21h
	mov	ax,4c00h
	int	21h
main	endp
code	ends
	end	main
