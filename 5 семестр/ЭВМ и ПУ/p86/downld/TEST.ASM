;****************************************
;  Главный модуль  test.asm
;****************************************
.model MEDIUM
;мнемонические обозначения цветов
BLACK		EQU	0 ;черный
BLUE		EQU	1 ;темно-синий
GREEN		EQU	2 ;темно-зеленый
CYAN		EQU	3 ;бирюзовый (циан)
RED		EQU	4 ;темно-красный
MAGENTA		EQU	5 ;темно-фиолетовый
BROWN		EQU	6 ;коричневый
LIGHTGREY	EQU	7 ;серый
DARKGREY	EQU	8 ;темно-серый
LIGHTBLUE	EQU	9 ;синий
LIGHTGREEN	EQU	10 ;зеленый
LIGHTCYAN	EQU	11 ;голубой
LIGHTRED	EQU	12 ;красный
LIGHTMAGENTA	EQU	13 ;фиолетовый
YELLOW		EQU	14 ;желтый
WHITE		EQU	15 ;белый

;импортируемые данные
EXTRN	MMX_proc:far,Simp_proc:far,OffsResMmx:word,OffsResSimp:word,NumResArray:word,ElemSize:byte

STACK	SEGMENT PARA stack 'STACK'
	DB 400h DUP (?)
STACK	ENDS

DATA	SEGMENT PARA USE16 PUBLIC 'DATA'
;************************************************
;*        Данные для тестируемого кода          *
;************************************************
a_vector	DW	40 DUP(?)
b_vector	DW	40 DUP(?)
counter		DD	?
;************************************************
X		DB	0
Y		DB	6
String		DB	16 DUP(?)
ScreenString	DW	?
ScreenColumn	DW	?
Data_Int32   	DD	?
Data_BCD	DT	?
Data_String	DB	32 DUP (?)
OutD_String	DB	34 DUP (?)
stTics1		DD	?
mlTics1		DD	?
stTics2		DD	?
mlTics2		DD	?
Tics		DD	?
Overhead	EQU	95
init_val	DD	-1
rand_a		DD	48271
rand_m		DD	9999
Var1		DB	20
Var22		DB	28
Var21		DB	26
Var20		DB	20
FileName	DB	"result.txt",0
iden		DW	?
StrData		DB	"Исходные данные:",13,10
StrVecA		DB	"Вектор A:",13,10
StrVecB		DB	13,10,"Вектор B:",13,10
StrRes1		DB	13,10,"Результат вычислений с использованием команд MMX:",13,10
StrRes2		DB	13,10,"Результат вычислений без использования команд MMX:",13,10
NumAr		DW	?
TextColorAndBackground	DB	0Fh

Text1		DB	LIGHTGREEN,0,20
		DB	"Учебная программа по MMX технологии",0
		DB	LIGHTGREEN,1,0
		DB	"********************************************************************************",0
		DB	YELLOW,2,0,"Производитель процессора:",0
		DB	YELLOW,3,0,"Семейство               :",0
		DB	YELLOW,4,0,"Поддержка технологии MMX:",0
		DB	LIGHTGREEN,5,0
		DB	"********************************************************************************",0
		DB	LIGHTRED,24,20,"Ждите, идёт тестирование процессора",0
MMX_found	DB	LIGHTRED,4,30,"набор команд MMX поддерживается   ",0
MMX_nfound	DB	LIGHTRED,4,30,"набор команд MMX не поддерживается",0
HelpMessage	DB	LIGHTBLUE,7,29,"Команды программы",0
		DB	LIGHTCYAN,10,25,"h(help)     - помощь",0
		DB	LIGHTCYAN,11,25,"e(exit)     - выход",0
		DB	LIGHTCYAN,12,25,"t(test)     - тестировать",0
		DB	LIGHTCYAN,13,25,"r(results)  - просмотр результатов",0
		DB	LIGHTCYAN,14,25,"d(data)     - исходные данные",0
		DB	LIGHTCYAN,15,25,"c(continue) - следующая команда",0
		DB	LIGHTCYAN,16,25,"w(write)    - запись результатов в файл",0
InputMsg	DB	LIGHTGREEN,24,0,"                   Введите команду ('h' - помощь, 'e' - выход)              ",0
ExitMessage	DB	LIGHTGREEN,24,0,"                       Для выхода нажмите любую клавишу                     ",0
NextMsg		DB	LIGHTGREEN,24,0,"                    Для ввода следующей команды нажмите 'c'                 ",0			
TicsMsg		DB	LIGHTBLUE,7,28,"Измерение производительности",0
		DB	LIGHTCYAN,9,33,"Код с командами MMX",0
		DB	LIGHTCYAN,11,0,"Количество тактов исполнения кода :",0
		DB	LIGHTCYAN,13,33,"Код без команд MMX",0
		DB	LIGHTCYAN,15,0,"Количество тактов исполнения кода :",0
ResultsMsg	DB	LIGHTBLUE,7,33,"Результаты вычислений",0
		DB	LIGHTCYAN,8,30,"С использованием команд MMX  :",0
		DB	LIGHTCYAN,16,30,"Без использования команд MMX :",0
DataMsg		DB	LIGHTBLUE,7,30,"Исходные данные",0
		DB	LIGHTCYAN,9,0,"Вектор A:",0
		DB	LIGHTCYAN,15,0,"Вектор B:",0
NoResult	DB	LIGHTRED,12,20,"Результат не сформирован (NumResArray<=0)",0
NoElemSize	DB	LIGHTRED,12,20,"Не указан размер элемента массива (ElemSize)",0
WriteOK		DB	LIGHTRED,12,12,"Исходные данные и результаты записаны в файл result.txt",0
DATA	ENDS

CODE	SEGMENT
	ASSUME cs:code, ds:data, ss:stack
	.586	
	.mmx
;если ассемблер не поддерживает набор команд MMX
;	INCLUDE pmmx.inc

start:
	mov  ax, data
	mov  ds, ax

;установить текстовый режим, очистить экран
	mov ax,3
	int 10h

;скрыть курсор
        mov     Y,25
        mov     X,0
        call    SetCursorPosition

;вывод шаблона текста на экран
	mov	cx,6
	mov	si,offset Text1
@@NStr:
	call	ShowColorString
	loop	@@NStr

;определяем производителя процессора
        mov	eax,0
	cpuid
	mov	[String][0],LIGHTRED
	mov	[String][1],2
	mov	[String][2],30
	mov	dword ptr [String][3],ebx
	mov	dword ptr [String][7],edx
	mov	dword ptr [String][11],ecx
	mov	[String][15],0
	mov	si,offset String
	call	ShowColorString

;определяем семейство процессора
	mov	eax,1
	cpuid
	and	eax,00000f00h
	shr	eax,8
        mov     [ScreenString],3
        mov     [ScreenColumn],30
	mov	[TextColorAndBackground],LIGHTRED
        mov     [Data_Int32],eax
        call    Int32_to_String
        call    ShowDataString

;определяем поддержку команд MMX
	and	edx,800000h
	jnz	@@MMXfound
	mov	si,offset MMX_nfound
	call	ShowColorString
	jmp	@@EndPrg

@@MMXfound:
	mov	si,offset MMX_found
	call	ShowColorString

;заполнение вектора a_vector случайными числами
	mov	bx,offset a_vector
	xor	si,si
@@SetVal1:
	call	Rand
	mov	[bx][si],ax
	inc	si
	inc	si
	cmp	si,80
	jne	@@SetVal1 	

;заполнение вектора b_vector случайными числами
	mov	bx,offset b_vector
	xor	si,si
@@SetVal2:
	call	Rand
	mov	[bx][si],ax
	inc	si
	inc	si
	cmp	si,80
	jne	@@SetVal2 	

;*********************************************
;*  Макрос для осуществления записи в файл   *
;********************************************* 
WriteFile	macro	pString,NumBytes
	push	bx
	xor	dx,dx
	xor	cx,cx
	mov	ah,40h
	mov	bx,iden
	mov	cx,NumBytes
	mov	dx,pString
	int	21h
	pop	bx
	endm

;*************************************
;*    Приём и исполнение команд      *
;*************************************
@@Begin:
	mov	si,offset InputMsg
	call	ShowColorString
	call	ClearScreen
	mov	Y,6
	mov	X,0
	call	Prompt
	cmp	ah,1
	je	@@Help
	cmp	ah,2
	je	@@EndPrg
	cmp	ah,3
	je	@@Test
	cmp	ah,4
	je	@@Data
	cmp	ah,5
	je	@@Results
	cmp	ah,6
	je	@@Write

;************************************************
;вывод справочной информации
;************************************************
@@Help:
	mov	cx,8
	mov	si,offset HelpMessage
@@mH1:	call	ShowColorString
	loop	@@mH1
	mov	si,offset NextMsg
	call	ShowColorString
@@mH2:	call	GetChar
	cmp	al,63h
	jne	@@mH2
	jmp	@@Begin

;***********************************************
;тестирование кодов с командами MMX и без них.
;***********************************************
@@Test:

;запись в стек параметров для процедуры MMX_proc
	mov	ax,40
	push	ax
	push	offset b_vector
	push	offset a_vector

;засечь количество тактов
	xor eax,eax
	cpuid
	rdtsc
	mov	[stTics1],edx
	mov	[mlTics1],eax
	cld
rept	8
	nop
endm	
;**********************     Тестируемый код (с MMX)      **************
	call	MMX_proc
;**********************************************************************
	clc
	rdtsc

	mov	[stTics2],edx
	sub	eax,Overhead
	mov	[mlTics2],eax
	sub	eax,[mlTics1]
	mov	[Tics],eax

;вывод шаблона
	mov	cx,5
	mov	si,offset TicsMsg
@@mT1:	call	ShowColorString
	loop	@@mT1

;*****************************************
;  Макрос вывода информации о тесте      *
;*****************************************
TestOutput	macro y1,x1
;;вывод количества тактов процессора, за которые выполнен тестируемый код
	mov	eax,[Tics]
        mov     [ScreenString],y1
        mov     [ScreenColumn],x1
	mov	[TextColorAndBackground],LIGHTRED
        mov     [Data_Int32],eax
        call    Int32_to_String
        call    ShowDataString
	endm
	
	TestOutput 11,50

;запись в стек параметров процедуры Simp_proc 
	mov	ax,40
	push	ax
	push	offset b_vector
	push	offset a_vector

;засечь количество тактов
	xor eax,eax
	cpuid
	rdtsc
	mov	[stTics1],edx
	mov	[mlTics1],eax
	cld
rept	8
	nop
endm	
;******************   Тестируемый код (без MMX)    ***************
	call	Simp_proc
;*****************************************************************
	clc
	rdtsc

	mov	[stTics2],edx
	sub	eax,Overhead
	mov	[mlTics2],eax
	sub	eax,[mlTics1]
	mov	[Tics],eax

	TestOutput 15,50

;ждать ввода символа 'c'
	mov	si,offset NextMsg
	call	ShowColorString
@@mT2:	call	GetChar
	cmp	al,63h
	jne	@@mT2
	jmp	@@Begin

;***********************************************
;запись исходных данных и результатов в файл
;***********************************************
@@Write:
;открыть файл для записи результатов
	mov	ah,3Ch
	mov	cx,0
	mov	dx,offset FileName
	int	21h
	mov	iden,ax

	WriteFile offset StrData,18
	WriteFile offset StrVecA,11

;вывод в файл вектора a_vector
	xor	si,si
	xor	ebx,ebx
	mov	bx,offset a_vector
@@OutputA:
	xor	eax,eax
	mov	ax,[bx][si]
        mov     [Data_Int32],eax
	mov	dword ptr [Data_String+2],0
        call    Int32_to_String
	WriteFile offset Data_String,6
	inc	si
	inc	si
	cmp	si,80
	jne	@@OutputA

	WriteFile offset StrVecB,13

;вывод в файл вектора b_vector
	xor	si,si
	mov	bx,offset b_vector
@@OutputB:
	xor	eax,eax
	mov	ax,[bx][si]
        mov     [Data_Int32],eax
	mov	dword ptr [Data_String+2],0
        call    Int32_to_String
	WriteFile offset Data_String,6
	inc	si
	inc	si
	cmp	si,80
	jne	@@OutputB

;запись результатов вычислений
	cmp	NumResArray,0
	jg	@@WResIsGen		;если NnmResArray больше 0, то результат сформирован
	mov	si,offset NoResult
	call	ShowColorString
	jmp	@@mWnext
@@WResIsGen:
	cmp	ElemSize,0
	je	@@WResOK
	cmp	ElemSize,1
	je	@@WResOK
	cmp	ElemSize,2
	je	@@WResOK
	mov	si,offset NoElemSize
	call	ShowColorString
	jmp	@@mWnext	
@@WResOK:
	mov	ax,NumResArray
	mov	cl,ElemSize
	shl	ax,cl
	mov	NumAr,ax

;вывод в файл результата, сформированного с помощью команд MMX
	WriteFile offset StrRes1,53
	xor	si,si
	mov	bx,[OffsResMmx]
	cmp	ElemSize,0
	je	@@mWResM0
	cmp	ElemSize,1
	je	@@mWResM1
	cmp	ElemSize,2
	je	@@mWResM2
	jmp	@@mWnext

@@mWResM0:
	mov	al,[bx][si]
	cbw
	cwde
	mov	[Data_Int32],eax
	mov	dword ptr [Data_String],0
	call	Int32_to_String
	WriteFile offset Data_String,4
	inc	si
	cmp	si,NumAr
	jne	@@mWResM0
	jmp	@@mWResS

@@mWResM1:
	mov	ax,[bx][si]
	cwde
	mov	[Data_Int32],eax
	mov	dword ptr [Data_String+2],0
	call	Int32_to_String
	WriteFile offset Data_String,6
	inc	si
	inc	si
	cmp	si,NumAr
	jne	@@mWResM1
	jmp	@@mWResS
	
@@mWResM2:
	mov	eax,[bx][si]
	mov	[Data_Int32],eax
	mov	dword ptr [Data_String],0
	mov	dword ptr [Data_String+4],0
	mov	dword ptr [Data_String+8],0
	call	Int32_to_String
	WriteFile offset Data_String,11
	add	si,4
	cmp	si,NumAr
	jne	@@mWResM2

@@mWResS:
;вывод в файл результата, сформированного без использования команд MMX
	WriteFile offset StrRes2,54
	xor	si,si
	mov	bx,[OffsResSimp]
	cmp	ElemSize,0
	je	@@mWResS0
	cmp	ElemSize,1
	je	@@mWResS1
	cmp	ElemSize,2
	je	@@mWResS2
	jmp	@@mWnext

@@mWResS0:
	mov	al,[bx][si]
	cbw
	cwde
	mov	[Data_Int32],eax
	mov	dword ptr [Data_String],0
	call	Int32_to_String
	WriteFile offset Data_String,4
	inc	si
	cmp	si,NumAr
	jne	@@mWResS0
	jmp	@@mWOK

@@mWResS1:
	mov	ax,[bx][si]
	cwde
	mov	[Data_Int32],eax
	mov	dword ptr [Data_String+2],0
	call	Int32_to_String
	WriteFile offset Data_String,6
	inc	si
	inc	si
	cmp	si,NumAr
	jne	@@mWResS1
	jmp	@@mWOK
	
@@mWResS2:
	mov	eax,[bx][si]
	mov	[Data_Int32],eax
	mov	dword ptr [Data_String],0
	mov	dword ptr [Data_String+4],0
	mov	dword ptr [Data_String+8],0
	call	Int32_to_String
	WriteFile offset Data_String,11
	add	si,4
	cmp	si,NumAr
	jne	@@mWResS2

@@mWOK:
	mov	si,offset WriteOK
	call	ShowColorString

@@mWnext:
;закрыть файл
	mov	ah,3Eh
	mov	bx,iden
	int	21h

;ждать ввода символа 'c'
	mov	si,offset NextMsg
	call	ShowColorString
@@mW:	call	GetChar
	cmp	al,63h
	jne	@@mW
	jmp	@@Begin

;***********************************************
;вывод исходных данных на экран
;***********************************************
@@Data:
	mov	cx,3
	mov	si,offset DataMsg
@@mD1:	call	ShowColorString
	loop	@@mD1

;вывод вектора a_vector
	mov	[ScreenString],0
	mov	[ScreenColumn],0
	mov	bx,offset a_vector
	xor	si,si
	mov	dh,10
	mov	dl,10
@@mD2:	xor	eax,eax
	mov	ax,[bx][si]
        mov     byte ptr [ScreenString],dh
        mov     byte ptr [ScreenColumn],dl
	mov	[TextColorAndBackground],LIGHTRED
        mov     [Data_Int32],eax
        call    Int32_to_String
        call    ShowDataString
	inc	si
	inc	si
	mov	ax,si
	div	Var1
	cmp	ah,0
	jne	@@mD3
	inc	dh
	mov	dl,10
	jmp	@@mD4
@@mD3:	add	dl,6
@@mD4:	cmp	si,80
	jne	@@mD2
	
;вывод вектора b_vector
	mov	[ScreenString],0
	mov	[ScreenColumn],0
	mov	bx,offset b_vector
	xor	si,si
	mov	dh,16
	mov	dl,10
@@mD5:	xor	eax,eax
	mov	ax,[bx][si]
        mov     byte ptr [ScreenString],dh
        mov     byte ptr [ScreenColumn],dl
	mov	[TextColorAndBackground],LIGHTRED
        mov     [Data_Int32],eax
        call    Int32_to_String
        call    ShowDataString
	inc	si
	inc	si
	mov	ax,si
	div	Var1
	cmp	ah,0
	jne	@@mD6
	inc	dh
	mov	dl,10
	jmp	@@mD7
@@mD6:	add	dl,6
@@mD7:	cmp	si,80
	jne	@@mD5

	mov	si,offset NextMsg
	call	ShowColorString
@@mD8:	call	GetChar
	cmp	al,63h
	jne	@@mD8
	jmp	@@Begin

;********************************************************
;вывод результатов вычислений на экран
;********************************************************
@@Results:
	cmp	NumResArray,0
	jg	@@ResIsGen		;если NnmResArray больше 0, то результат сформирован
	mov	si,offset NoResult
	call	ShowColorString
	jmp	@@mRnext
@@ResIsGen:
	cmp	ElemSize,0
	je	@@ResOK
	cmp	ElemSize,1
	je	@@ResOK
	cmp	ElemSize,2
	je	@@ResOK
	mov	si,offset NoElemSize
	call	ShowColorString
	jmp	@@mRnext	
@@ResOK:
	mov	ax,NumResArray
	mov	cl,ElemSize
	shl	ax,cl
	mov	NumAr,ax
	mov	cx,3
	mov	si,offset ResultsMsg
@@mR1:	call	ShowColorString
	loop	@@mR1

;вывод результатов вычислений, проведённых с использованием команд MMX
	mov	[ScreenString],0
	mov	[ScreenColumn],0
	mov	bx,[OffsResMmx]
	xor	si,si
	mov	dh,9
	mov	dl,0
	cmp	ElemSize,0
	je	@@mRESm0
	cmp	ElemSize,1
	je	@@mRESm1
	cmp	ElemSize,2
	je	@@mRESm2
	jmp	@@mRnext

@@mRESm0:
	mov	al,[bx][si]
	cbw
	cwde
	inc	si
	mov     byte ptr [ScreenString],dh
	mov     byte ptr [ScreenColumn],dl
	mov	[TextColorAndBackground],LIGHTRED
        mov     [Data_Int32],eax
        call    Int32_to_String
        call    ShowDataString
	mov	ax,si
	div	Var20
	cmp	ah,0
	jne	@@mR30
	inc	dh
	mov	dl,0
	jmp	@@mR40
@@mR30:	add	dl,4
@@mR40:	cmp	si,NumAr
	jl	@@mRESm0
	jmp	@@mRSimp

@@mRESm1:
	mov	ax,[bx][si]
	cwde
	inc	si
	inc	si
	mov     byte ptr [ScreenString],dh
	mov     byte ptr [ScreenColumn],dl
	mov	[TextColorAndBackground],LIGHTRED
        mov     [Data_Int32],eax
        call    Int32_to_String
        call    ShowDataString
	mov	ax,si
	div	Var21
	cmp	ah,0
	jne	@@mR31
	inc	dh
	mov	dl,0
	jmp	@@mR41
@@mR31:	add	dl,6
@@mR41:	cmp	si,NumAr
	jl	@@mRESm1
	jmp	@@mRSimp

@@mRESm2:
	mov	eax,[bx][si]
	add	si,4
	mov     byte ptr [ScreenString],dh
	mov     byte ptr [ScreenColumn],dl
	mov	[TextColorAndBackground],LIGHTRED
        mov     [Data_Int32],eax
        call    Int32_to_String
        call    ShowDataString
	mov	ax,si
	div	Var22
	cmp	ah,0
	jne	@@mR32
	inc	dh
	mov	dl,0
	jmp	@@mR42
@@mR32:	add	dl,11
@@mR42:	cmp	si,NumAr
	jl	@@mRESm2

;вывод результатов вычислений без использования команд MMX
@@mRSimp:
	mov	[ScreenString],0
	mov	[ScreenColumn],0
	mov	bx,[OffsResSimp]
	xor	si,si
	mov	dh,17
	mov	dl,0
	cmp	ElemSize,0
	je	@@mRESs0
	cmp	ElemSize,1
	je	@@mRESs1
	cmp	ElemSize,2
	je	@@mRESs2
	jmp	@@mRnext

@@mRESs0:
	mov	al,[bx][si]
	cbw	
	cwde
	inc	si
	mov     byte ptr [ScreenString],dh
	mov	byte ptr [ScreenColumn],dl
	mov	[TextColorAndBackground],LIGHTRED
        mov     [Data_Int32],eax
        call    Int32_to_String
        call    ShowDataString
	mov	ax,si
	div	Var20
	cmp	ah,0
	jne	@@mR60
	inc	dh
	mov	dl,0
	jmp	@@mR70
@@mR60:	add	dl,4
@@mR70:	cmp	si,NumAr
	jne	@@mRESs0
	jmp	@@mRnext

@@mRESs1:
	mov	ax,[bx][si]
	cwde
	inc	si
	inc	si
	mov     byte ptr [ScreenString],dh
	mov	byte ptr [ScreenColumn],dl
	mov	[TextColorAndBackground],LIGHTRED
        mov     [Data_Int32],eax
        call    Int32_to_String
        call    ShowDataString
	mov	ax,si
	div	Var21
	cmp	ah,0
	jne	@@mR61
	inc	dh
	mov	dl,0
	jmp	@@mR71
@@mR61:	add	dl,6
@@mR71:	cmp	si,NumAr
	jne	@@mRESs1
	jmp	@@mRnext

@@mRESs2:
	mov	eax,[bx][si]
	add	si,4
	mov     byte ptr [ScreenString],dh
	mov	byte ptr [ScreenColumn],dl
	mov	[TextColorAndBackground],LIGHTRED
        mov     [Data_Int32],eax
        call    Int32_to_String
        call    ShowDataString
	mov	ax,si
	div	Var22
	cmp	ah,0
	jne	@@mR62
	inc	dh
	mov	dl,0
	jmp	@@mR72
@@mR62:	add	dl,11
@@mR72:	cmp	si,NumAr
	jne	@@mRESs2

@@mRnext:
	mov	si,offset NextMsg
	call	ShowColorString
@@mR8:	call	GetChar
	cmp	al,63h
	jne	@@mR8
	jmp	@@Begin
	
@@EndPrg:

	mov	si,offset ExitMessage
	call	ShowColorString
	call	GetChar
	mov	ax,3
	int	10h
	mov	ax, 4C00h	 ; возвpат в DOS
	int	21h

;********************************************
;* Функция - приглашение ко вводу команды   *
;* Возвращает в ah номер введённой команды: *
;*      1 - помощь                          *
;*	2 - выход                           *
;*	3 - тестировать                     *
;*	4 - исходные данные                 *
;*	5 - результаты                      *
;*	6 - запись результатов в файл       *
;********************************************
Prompt	proc	near
;ждём ввода символа
	call	SetCursorPosition
	mov	bh,0
	mov	al,3Eh
	mov	cx,1
	mov	bl,0Ah
	mov	ah,09
	int	10h
	inc	X
	call	SetCursorPosition
@@GetCh:
	call    GetChar
	mov	ah,09
	mov	cx,1
	mov	bl,0Ah
	cmp	al,68h
	je	@@Hlp
	cmp	al,65h
	je	@@Exit
	cmp	al,74h
	je	@@Tst
	cmp	al,64h
	je	@@Dat
	cmp	al,72h
	je	@@Res
	cmp	al,77h
	je	@@Wrt
	jmp	@@GetCh
@@Hlp:	
	int	10h
	mov	ah,1
	jmp	@@EndProc
@@Exit:
	int	10h
	mov	ah,2
	jmp	@@EndProc
@@Tst:
	int	10h
	mov	ah,3
	jmp	@@EndProc
@@Dat:
	int	10h
	mov	ah,4
	jmp	@@EndProc
@@Res:
	int	10h
	mov	ah,5
	jmp	@@EndProc
@@Wrt:
	int	10h
	mov	ah,6
@@EndProc:
	inc	X
	call	SetCursorPosition
	ret
Prompt	endp

;***********************************************
;*  Установка курсора в заданную позицию       *
;***********************************************
SetCursorPosition proc near
 	push	ax
	push	bx
	push	dx
	mov	ah,02
	mov	dh,Y
	mov	dl,X
	mov	bh,0
	int	10h
	pop	dx 
	pop	bx
	pop	ax
        ret
SetCursorPosition endp

;**************************************************
;           Вывод строки в цвете                  *
;**************************************************
ShowColorString proc near
        push    AX
        mov     AL,[TextColorAndBackground]
        push    AX
        cld
        lodsb
        mov     [TextColorAndBackground],AL
        call    ShowString
        pop     AX
        mov     [TextColorAndBackground],AL
        pop     AX
        ret
ShowColorString endp

;************************************************
;                Вывод строки                   *
;************************************************
ShowString proc near
        push    AX
        push    BX
        push    DI
        push    ES
        mov     AX,DGROUP
        mov     ES,AX
        mov     BL,[ES:TextColorAndBackground]
        mov     AX,0B800h
        mov     ES,AX    
        cld
        lodsb
        cmp     AL,24  
        ja      @@Error
        mov     AH,160
        mul     AH
        mov     DI,AX
	lodsb
        cmp     AL,79
        ja      @@Error
        mov     BH,AL
        xor     AH,AH
        add     DI,AX
        add     DI,AX
        mov     AH,BL
@@L1:
        lodsb
        and     AL,AL  
        jz      @@L2
        cmp     BH,79
        ja      @@Error
        stosw
        inc     BH
        jmp     @@L1
@@L2:   pop     ES
        pop     DI
        pop     BX
        pop     AX
        ret
@@Error:
        mov     AH,4Ch
        int     21h
	ret
ShowString endp

;************************************************
;   Перевод 32-разрядного числа в строку        *
;************************************************
Int32_to_String proc near
        pushad  
        push    DS
        push    ES
        mov     AX,DGROUP
        mov     DS,AX
        mov     ES,AX
        cld
        fninit
        fild    [Data_Int32]
        fbstp   [Data_BCD]
        mov     DI,offset Data_String
        call    BCD_to_ASCII
        xor     AL,AL
        stosb
        pop     ES
        pop     DS
        popad
        ret
Int32_to_String endp

;************************************************
;   Отображение числа в коде ASCII на экран     *
;************************************************
ShowDataString proc near
        pusha
        push    ES
        mov     AX,DGROUP
        mov     ES,AX
        cld
        mov     DI,offset OutD_String
        mov     AX,[ScreenString]
        stosb
        mov     AX,[ScreenColumn]
        stosb
        mov     SI,offset Data_String
        mov     CX,31
        rep     movsb
        mov     AL,0
        stosb
        mov     SI,offset OutD_String
        call    ShowString
        pop     ES
        popa
        ret
ShowDataString endp

;************************************************
;   Перевод числа из BCD-формата в код ASCII    *
;************************************************
BCD_to_ASCII proc near
        push si
	mov	BX,offset Data_BCD
	mov     AL,[BX][9]
        and     AL,AL
        jz      @@n0
        mov     AL,'-'
        stosb
@@n0:   mov     BX,8
        mov     CX,9
@@n1:
	mov	si,offset Data_BCD
	mov	al,[bx][si]
	cmp     al,0
        jne     @@n2
        dec     BX
        loop    @@n1
        mov     AL,'0'
	stosb
        jmp short @@End
@@n2:
        mov si,offset Data_BCD
	mov     AL,[BX][si]
        mov     AH,AL
        shr     AL,4
        cmp     AL,0
        je      @@n3
        add     AL,'0'
        stosb
@@n3:   mov     AL,AH
        and     AL,0Fh
        add     AL,'0'
        stosb
        dec     BX
        dec     CX
        jz      @@End
@@n4:
        mov si,offset Data_BCD
	mov     AL,[BX][si]
        mov     AH,AL
        shr     AL,4
        add     AL,'0'
        stosb
        mov     AL,AH
        and     AL,0Fh
        add     AL,'0'
	stosb
        dec     BX
        loop    @@n4
@@End:
        pop si
	ret
BCD_to_ASCII endp

;************************************
;   Ввод символа                    *
;************************************
GetChar proc near
        mov     AX,0
        int     16h
        and     AL,AL
        jnz     @@Get1
        ret
@@Get1: cmp     AL,32
        jnb     @@Get2
        xchg    AL,AH 
        mov     AL,0
        ret
@@Get2: mov     AH,0
        ret
GetChar endp

;*************************************
;*           Очистка экрана          *
;*************************************
ClearScreen	proc	near
        pusha
        push    ES
; Настроить ES:DI на "текстовую" область видеопамяти
        mov     AX,0B800h
	add	AX,60 
        mov     ES,AX     
        cld
        mov     DI,0
; Вывести 1440 "пустых" символов (ASCII-код 0) с
; атрибутом "белый цвет, черный фон"
        mov     CX,1440
        mov     AX,0F00H
        rep     stosw
        pop     ES
        popa
        ret
ClearScreen	endp

;*********************************************
;*  Генерация случайного числа по формуле:   *
;*  I(j+1)=( rand_a*I(j)+c ) mod(rand_m)     *
;*  Возвращает в eax случайное положительное *  
;*  число в зависимости от значения rand_m   *
;*********************************************
Rand	proc	near
	push	edx
	mov	eax,init_val
	test	eax,eax			;если ф-ия ни разу не вызывалась,
	js	@@CreateInitval		;создать начальное значение
;получение случайного числа
@@Randomize:
	mul	dword ptr rand_a
	div	dword ptr rand_m
	mov	eax,edx
	mov	dword ptr init_val,eax
	pop	edx
	ret
;создание начального значения (двойное слово из 0040:006C - текущее число
;тактов таймера)
@@CreateInitval:
	push	ds
	push	0040h
	pop	ds
	mov	eax,dword ptr ds:006Ch
	pop	ds
	jmp	short @@Randomize
Rand	endp

CODE    ENDS
	END  Start