sseg segment para stack 'stack'
     dw      10h dup(?)
sseg ends

dseg segment para public 'data'
     header  db   '   Lab N2 Hello, world!',13,10,'$'
     offline   db   '* Printer error',13,10,'$'
     iserr    db   0
dseg ends

cseg segment para public 'code'
assume cs:cseg,ds:dseg,ss:sseg
start:

       mov      ax,dseg          ;
       mov      ds,ax            ; �����⨬ ����� ��ப� header � bx
       mov      bx,offset header ;

       xor      ax,ax        ; 0 -> ax
       mov      es,ax        ; 0 -> es
       mov      dx,es:[408h] ; � dx ����� ���� ���. ॣ���� LPT1 (bios)
       
       ;reset printer
       xor      ax,ax  
       inc      dx           ; � dx - ����� ���� �����
       inc      dx
       in       al, dx
       or       al, 00001000b
       and      al, 11111011b
       out      dx, al

        mov      di, 1000
loop1: 
       dec      di
       cmp      di, 0
       jne      loop1   
    
       or       al, 00000100b
       out      dx, al   
       dec      dx           ; � dx - ����� ���� ����� 

       xor      ax,ax

e1:    in       al,dx     ; ����砥� � al ����� �ਭ�� �� ⥪��. ������
       test     al,01000b ; ������ ��� �訡�� 3. �᫨ �� = 0, � �訡��
       jz e2              ; �᫨ �訡��, ���室�� � �� ��ࠡ�⪥ - e2,e3...
       jmp ok             ; ���� - ���뫠�� ᫥���騩 ᨬ��� �� �����

e2:    mov      dx,offset offline   ; 
       mov      ah,09h              ;
       int      21h                 ; 
       jmp      ext                 ; ��室 �� �ணࠬ��

ok:    dec      dx         ; � dx ����� ���� ��室���� ॣ����
       mov      al,[bx]    ; � al ��।����� ��।��� ᨬ���
       inc      bx         ; �롮� ᫥���饣� ᨬ���� � ��ப�
       cmp      al,'$'     ; �஢�ઠ: �᫨ ᨬ��� $, � �����襭�� EXT
       je       ext

       out      dx,al      ; ������ al ����뫠���� � ����
       inc      dx         ; � dx ������ �ਡ������� 1 � ⥯���
       inc      dx         ;   � dx ����� ���� ॣ���� �ࠢ�����

       mov      al,0Dh     ; � al ��� ��� ��஡����饣� ������
       out      dx,al      ; �뤠� � ���� ��஡����饣� ������
       mov      al,0Ch     ; � al ��� �⬥�� ��஡�
       out      dx,al      ; �⬥�� ��஡����饣� ������
       dec      dx         ; � dx ����� ���� ॣ���� �����

no:    in       al,dx   ; �⥭�� ���ﭨ� ॣ���� �����
       test     al,80h  ; �������� ��⮢���� �ਭ�� (������ ��� 7
       jz       no      ;   � ॣ���� �����)
       jmp      e1      ; ���室 ��� �஢�ન �� �訡�� � ���쭥�襣�
                        ;   �뢮�� ᫥���饣� ᨬ����

ext:   mov      ax,4C00h  ; ��室
       int      21h

cseg ends
end start
