;***************************************************************************
;Файл для процедур пользователя.
;Код, производящий вычисления с использованием команд MMX, следует
;писать внутри процедуры MMX_proc. Код, производящий вычисления без
;использования команд MMX - внутри процедуры Simp_proc.
;Имена процедур изменять нельзя.
;Параметры в процедуры передаются через стек:
; - по адресу +6 хранится смещение вектора a_vector (состоит из слов)
;   в сегменте данных;
; - по адресу +8 хранится смещение вектора b_vector (состоит из слов)
;   в сегменте данных;
; - по адресу +10 хранится количество элементов в векторах (вектора
;   одинакового размера).
;Результаты вычислений с использованием команд MMX записываются в массив
; Result_mmx,результаты вычислений без использования команд MMX - в масси
;в Result_simp. В переменную NumResArray записывается количество элементов
;в результирующем массиве.
;****************************************************************************

.model MEDIUM
;экспорторуемые данные
PUBLIC  MMX_proc,Simp_proc,OffsResMmx,OffsResSimp,NumResArray

STACK   SEGMENT PARA stack 'STACK'
        db 400h dup (?)
STACK   ENDS

DATA    SEGMENT PARA USE16 PUBLIC 'DATA'
SizeOff		DW	?
NumResArray     DW      ?               ;количество элементов в результирующем массиве
Temp		DD	40 DUP(?)
Result_mmx      DD      40 DUP(?)       ;место в памяти для записи результата вычислений процедуры с командами MMX
Result_simp     DD      40 DUP(?)       ;место в памяти для записи результата вычислений процедуры без команд MMX
OffsResMmx      DW      Result_mmx      ;смещение начала массива Result_mmx
OffsResSimp     DW      Result_simp     ;смещение начала массива Result_simp
count           DW      ?
DATA    ENDS

CODE    SEGMENT
        ASSUME cs:code, ds:data, ss:stack
        .586
        .mmx
;***************************************************************************
;  Процедура вычисления скалярного произведения векторов с использ. MMX    *
;***************************************************************************
MMX_proc        proc    far
        push    bp
        mov     bp,sp
        pxor    mm7,mm7
        xor     ax,ax
	xor	dx,dx
        mov     si,ax
;        mov     si,[bp+6]               ;в si адрес вектора a_vector
        mov     di,[bp+8]               ;в di адрес вектора b_vector
        mov     cx,[bp+10]              ;в cx количество элементов векторов
;        mov     [count],cx
@@Loop1:
        movq    mm0,[si+bp+6]
        movq    mm1,[di]
        paddw   mm0,mm1
	
        movd    [Temp+si],mm0
        psrlq   mm0,32
        movd    [Temp+si],mm0
        add     si,8
        add     di,8
        loop    @@Loop1

	mov	cx,40
	mov	si,0
@@Loop11:
	movq	mm0,[Temp+si]	
	movq	mm1,mm0
	pand	mm1,0FFFFh
	movd	[Result_mmx+si],mm1
	psrlq	mm0,32
	add	si,8
	movd	[Result_mmx+si],mm0
	add	si,8
	loop	@@Loop11

        emms
        mov     NumResArray,40           ;результат - число
        pop     bp
        ret     6                       ;выход с очисткой стека
MMx_proc        endp
;*****************************************************************************
;  Процедура вычисления скалярного произведения векторов без использ. MMX    *
;*****************************************************************************
Simp_proc       proc    far
        push    bp
        mov     bp,sp
        xor     ax,ax
        mov     si,ax
;        mov     si,[bp+6]
        mov     di,[bp+8]
        mov     cx,[bp+10]
;       mov     [count],cx
;        xor     bx,bx
;       xor     cx,cx
@@Loop2:
        mov     ax,[si+bp+6]
        add     ax,word ptr [di]
;       add     cx,ax
;       adc     bx,dx
        mov     word ptr [Result_simp+si],ax
        add     si,2
        add     di,2
        loop    @@Loop2
;       sub     [count],1
;       jnz     @@Loop2
;       mov     word ptr [Result_simp],cx
;       mov     word ptr [Result_simp+2],bx
        mov     NumResArray,40
        pop     bp
        ret     6
Simp_proc       endp

CODE    ENDS
        END
