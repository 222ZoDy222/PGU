.MODEL	small
dseg	segment	para
	kodir	DB	27,'1234567890',0,0,0,0
		DB	12 dup(0),13,42 dup(0),'789',0,'456',0,'1230',11 dup(0)

	buf_ful	DB	10,13,'The buffer is full','$'
		
	heading	DB	'Laboratory work.',10,13,'$'
	string	DB	100 dup(?)
	per	DW	?
	segold	DW	?
	offsold	DW	?
	flag	DB	?
	anykey  DB	10,13,'Press any key...$'
dseg	ends

stseg	segment	para	stack	'stack'
	dw	40h dup(?)
stseg   ends

cseg	segment	para	public
	assume	cs:cseg,ds:dseg,ss:stseg

	buffer	DW	17 dup(?)     ;���� ����������
				  ;� ���� ���ᮢ �ணࠬ��
	buffend	DW	0	  ;㪠��⥫� �� ����� ����
	buffbeg	DW	0	  ;㪠��⥫� �� ��砫� ����
	EXIT_FLG        db      0
	LENGHT          dw      0
 	count	       db       0
	fl	       db	0


int_keyb	PROC far
	push	bx		  ;��࠭����
	push	cx		  ;�ᯮ��㥬��
	push	es		  ;ॣ���஢
	push	ds		  ;� �⥪�
	push	di
	
	in	al,60h		  ;�⥭�� ��-����
	mov	ah,al		  ;��࠭���� ��� � ah
	mov	bx,ax		  ;��࠭���� ax � bx
	in	al,61h		  ;���⢥ত����
	or	al,80h
	out	61h,al		  ;	�ਥ��
	and	al,7fh
	out	61h,al		  ;		ᨬ����

	
	 mov     ax,bx           ;; ����⠭����� ��࠭����� ���祭�� � AX.
        xor     cx,cx           ;; ������� � ES
 
        cmp     al,1            ;; �᫨ ����� ������ ESC,
        jne    translate         ;; � ��⠭����� 䫠� EXIT_FLG � 1 � ���
        mov    EXIT_FLG,1   ;; �� ��ࠡ��稪�, ���� �ந����� �����-
        jmp     quit            ;; 䨪��� � ��ࠡ��� ᨬ����.
 
    
 translate:
             
        test    al,80h    ;; �஢���� ���᪠��� �����-���� ������,
        jnz     quit            ;; �᫨ ��� �뫮 ��䨪�஢���, � ���.

     
 decod_it:
        sub     al,1h           ;; ��४���஢���
        mov     bx,seg kodir     ;;     ����㯨�訩 
        mov     ds,bx           ;;         ᪠�-���
        mov     bx,offset kodir  ;;             � ASCII-ᨬ���
        xlat    kodir            ;;

	
        mov     di,buffend       ;; DX = ���� ���� 横���᪮�� ����.
	


 cmp     fl,1       ;; �᫨ ���� �� �������� �� ����,
        jne     not_full        ;; � ��३� � not_full.
        mov     ah,9            ;; ���� �뢥��
        mov     dx,offset buf_ful ;; ᮮ�饭�� � ⮬,
        int     21h             ;; �� ���� �������� 
        jmp     quit            ;; � ��� �� ��ࠡ��稪�.



 not_full:
	
        mov     BUFFER[di],ax ;; ������� ������஢���� ᨬ��� � ����.
    	
    add     di,2            ;; �������� 㪠��⥫� ���� �� 2,
                                ;; �.�. ��襬 ᫮��.
        cmp     di,32           ;; �᫨ 㪠��⥫� != 32 (16 ᫮�),
        jne     not_end         ;; � ���室�� � not_end,
        xor     di,di           ;; ���� ��⠭�������� 㪠��⥫� ���� ����
                                ;; �� ��砫� 䨧��᪮�� ���� � �����.
	
not_end:
        mov     buffend,di       ;; �����㥬 㪠��⥫� ���� ���� � �����.
        inc     LENGHT          ;; �������� ����� ���� �� 1 (����ᠭ�
       inc count                         ;; 1 ᫮��)



quit:	pop	di
	pop	ds
	pop	es
	pop	cx
	pop	bx		  ;����⠭������� �⥪�
	push	ax
	mov	al,20h		  ;ࠧ�襭�� ���뢠���
	out	20h,al		  ;����� ������� �ਮ���
	pop	ax
	iret
int_keyb	endp





init proc near
	push	ds		  ;��࠭���� � �⥪�
	push	es		  ;	����������� ᥣ������ ॣ���஢
	mov	ax,3509h
	int	21h		  ;�⥭�� ��ண� ����� ���뢠��� 9h
	mov	segold,es
	mov	offsold,bx
	cli
	mov	ax,seg int_keyb
	mov	ds,ax
	mov	dx,offset int_keyb
	mov	ax,2509h
	int	21h		  ;��⠭���� ������ 9h-�� �����
	pop	es		  ;����⠭�������
	pop	ds		  ;	ᥣ������ ॣ���஢ �� �⥪�
	sti

        ret
init endp

shutdown proc near
       push	ds
	mov	dx,offsold
	mov	ax,segold	  ;����⠭������� ��ண� �����
	mov	ds,ax
	mov	ax,2509h	  ;���뢠��� �� ����������
	int	21h
	pop	ds

        ret                    
shutdown endp




start:	mov	ax,dseg
	mov	ds,ax		  ;������ � ds ���� ᥣ���� ������
	
	call init

	mov 	ah,0fh          ;; 
      	int	10h             ;; ������ 
       	xor	ah,ah           ;; �࠭. 
      	int	10h             ;;
	
	mov	ah,9
	mov	dx,offset heading
	int	21h

 main:
     	 mov     di,buffbeg       ;; DI = ���� ��砫� ����
  		
     	 cmp     EXIT_FLG,0      ;; �஢���� 䫠� ��室� �� �ணࠬ��,
    	 jne     endprog            ;; �᫨ ��⠭�����, ���.
    	 cmp     count,0        ;; ���� �� � ���� ���ଠ�� ��� �뢮��?
   	 je      main            ;; �᫨ ���, � ��३� � main.
  		
    	mov     ax,buffer[di]   ;; AX = ��।��� ᨬ��� �� ���� ����������.

	
      	cmp     al,13           ;; �᫨ �� �� Enter,
   	jne     not_enter       ;; � ��३� � not_enter,
   	mov     al,10           ;; ���� ��ॢ���
     	int     29h             ;; �����,
     	mov     al,13           ;; ��३� �� ����� ��ப�
      
 not_enter:
	
      	int     29h
	cmp fl,1
	je endprog

	cmp lenght,16
	jne m1
	mov fl,1
m1:
        dec     count          ;; �������� ������⢮ ᨬ�����, ��室�����
                                ;; � ����.
        inc     di              ;; ������� 㪠��⥫� 
        inc     di              ;; ��砫� ���� �� 2.
        mov     buffbeg,di       ;; ��䨪�஢��� 㪠��⥫� � �����.

   	
        jmp     main            ;; ������ �� ���� main ��� �த������� ��ࠡ�⪨

	
endprog:
	call shutdown

	mov	ah,9
	mov	dx,offset anykey
	int	21h
	
	mov	ah,7
	int	21h

	mov	ax,4c00h	  ;��室 �� �ணࠬ�� � ����� ������,
	int	21h		  ;ࠢ�� 0 - ��ଠ��� ��室

cseg	ends
end	start	




