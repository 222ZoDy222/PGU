stseg   segment para    stack
        dw      16      dup(?)
stseg   ends
dseg    segment para
array dw 2,8,3,4,1,6,7,5
a       dw      2

index	dw		0

y       dw      ?
dseg    ends
cseg    segment para
; --- Команда для компилятора --- ;
assume  cs:cseg,ds:dseg,ss:stseg
; -------------------------------- 
		; -------------------------------------------- F U N C --------------------------------------------
		Func proc near

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
		 ret ; Выход из процедуры

		Func endp
		; -------------------------------------------- E N D   F U N C ------------------------------------


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

		mov cx, 8    
		lea si, array
		

		call Func ; Вызов процедуры алгоритма

		mov y, bx
		
		ret ; Выход из main

		main endp
		; -------------------------------------------- E N D	M A I N -----------------------------------



		
		; -------------------------------------------- E N D ----------------------------------------------

		
		
		
		
		;---------------------
        ret

cseg    ends
       end main



