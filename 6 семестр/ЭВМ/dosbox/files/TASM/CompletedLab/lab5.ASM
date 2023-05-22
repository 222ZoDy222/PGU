stseg   segment para    stack
        dw      16      dup(?)
stseg   ends
dseg    segment para

array dw 2,8,3,4,1,6,7,5

a       dw      2

index	dw		0

y       dw      ?

old_adress	dw	2 dup (?) ; Область сохранения старого вектора

dseg    ends
cseg    segment para
; --- Команда для компилятора --- ;
assume  cs:cseg,ds:dseg,ss:stseg
; -------------------------------- 
		; -------------------------------------------- M A I N --------------------------------------------
		main proc far

		; --- Обнуление регистров --- ;
		;------------------------------------------
        push    ds
        mov     ax,0
        push    ax
        mov     ax,dseg
        mov     ds,ax
		;------------------------------------------
		; --- Начало программы --- ;

		; --- Все для прерываний --- ;
		;------------------------------------------
        
		push ES
		mov AH,35H ; вызов функции DOS для получения
		mov AL,0FEH ; старого значения вектора
		int 21H ; прерывания
		mov old_adress,ES ; сохранение старого
		mov old_adress+2,BX ; значения вектора
		push DS
		mov DX,offset Func ; вызов функции DOS
		mov AX,seg Func ; для записи адреса
		mov DS,AX ; пользовательской
		mov AH,25H ; программы обработки
		mov AL, 0FEH ; прерывания в область
		int 21H ; векторов прерываний
		pop DS

		; Передача параметров 
		mov cx, 8    
		lea si, array		
		; --------------------
		
		int 0FEH ; вызов прерывания
		
		mov y, bx

		push DS
		mov DX,old_adress+2 ; вызов функции DOS
		mov AX,old_adress ; для восстановления
		mov DS,AX ; старого адреса
		mov AH,25H ; в области векторов
		mov AL,0FEH ; прерываний
		int 21H ;
		pop DS
		pop ES
		
		ret ; Выход из main

		main endp
		; -------------------------------------------- E N D	M A I N -----------------------------------


		; -------------------------------------------- F U N C --------------------------------------------
		Func proc far

		mov bx, [si]

		StartLoop:
		
		mov ax, [si]

		cmp ax, bx
		jge Continue
		mov bx, [si]
		
		Continue:
		inc si
		inc si
		loop StartLoop

		jmp EndProg

		Count:
			

		EndProg:
		 ;ret ; Выход из процедуры
		 iret ; Выход из прерывания

		Func endp
		; -------------------------------------------- E N D   F U N C ------------------------------------


		
		; -------------------------------------------- E N D ----------------------------------------------

		
		
		
		
		;---------------------
        ret

cseg    ends
       end main



