sseg segment para stack 'stack'
     dw      10h dup(?)
sseg ends

dseg segment para public 'data'
     message  db   'Laboratory work. Printer',10,13,'$'
     no_paper   db   'Error!!! NO PAPER!',10,13,'$'
     offline   db   'Error!!! PRINTER IS OFLINE!',10,13,'$'
     iserr    db   0
dseg ends

cseg segment para public 'code'
assume cs:cseg,ds:dseg,ss:sseg
start:

       mov      ax,dseg          ;
       mov      ds,ax            ; �����⨬ ����� ��ப� message � bx
       mov      bx,offset message ;

       xor      ax,ax        ; 0 -> ax
       mov      es,ax        ; 0 -> es
       mov      dx,es:[408h] ; � dx ����� ���� ���. ॣ���� LPT1 (bios)
       inc      dx           ; � dx - ����� ���� �����

err1:  in       al,dx     ; ����砥� � al ����� �ਭ�� �� ⥪��. ������
       ;test     al,01000b ; ������ ��� �訡�� 3. �᫨ �� = 0, � �訡��
       ;jz err2              ; �᫨ �訡��, ���室�� � �� ��ࠡ�⪥ - err2,err3...
       ;jmp ok             ; ���� - ���뫠�� ᫥���騩 ᨬ��� �� �����

err2:  test     al,10h  ; �஢�ਬ ��� N5. ��� 5 = 1 - ��� �㬠��
       jnz       err3      ; �᫨ �㬠�� ���������, ���室�� � ᫥�. �㭪��
       mov      dx,offset no_paper  ; �뢮� ᮮ�饭�� �� �騡�� � ⮬, ��
       mov      ah,09h              ; ������ �����������
       int      21h                 ;   �� ��࠭
       jmp      ext                 ; ��室 �� �ணࠬ��

err3:  test     al,20h  ; �஢�ਬ ��� N4. ��� 4 = 0 - �ਭ�� �몫�祭
       jz      ok      ; �᫨ �ਭ�� ����祭, �த������ �����
       mov      dx,offset offline  ; �뢮� ᮮ�饭�� �� �騡�� � ⮬, ��
       mov      ah,09h              ; ���H��� �������H (H�� ����H��)
       int      21h                 ;   �� ��࠭
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
       jmp      err1      ; ���室 ��� �஢�ન �� �訡�� � ���쭥�襣�
                        ;   �뢮�� ᫥���饣� ᨬ����

ext:   mov      ax,4C00h  ; ��室
       int      21h

cseg ends
end start
 