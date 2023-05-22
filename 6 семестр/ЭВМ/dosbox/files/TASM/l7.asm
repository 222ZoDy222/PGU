stseg   segment para    stack
        dw      16      dup(?)

		

stseg   ends
dseg    segment para

 
		secondNameString    db 10, 13,'Set second Name: $'
		mes_1    db 10,13, 'Vvedi chislo: $'
		mes_2    db 10,13, 'Resultat: $'
		buf      db  80 dup ('$')                   ; буфер для строки
		buff     db   6 dup (?)                     ; буфер для числа
		Result   db ?
        stroka	DB	'Hello, World!!!$'  ;Строка для вывода	


dseg    ends
cseg    segment para

lab6    proc    far
        assume  cs:cseg,ds:dseg,ss:stseg
        push    ds
        mov     ax,0
        push    ax
        mov     ax,dseg
        mov     ds,ax

        mov ah, 0h
        mov al,3h
        int 10h

          
          mov bx, 0Fh
		  int 16h;
          mov ah, 0Eh
          int 10h;
          int 16h



          ; ---------------------------------------------------------------




          ;-------------------------------------------------------------------
 exit:
          mov ah, 04Ch
          int 21h
          ret 
lab6    endp
cseg    ends
        end     lab6
