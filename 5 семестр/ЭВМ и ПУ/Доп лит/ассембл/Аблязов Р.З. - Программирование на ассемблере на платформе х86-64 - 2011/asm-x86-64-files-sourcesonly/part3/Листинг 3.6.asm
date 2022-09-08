section '.code' code readable executable

proc ConcatStrings str1, str2, str3
   push esi
   push edi
   invoke lstrlen, [str1]
   mov ecx, eax
   mov esi, [str1]
   mov edi, [str3]
   rep movsb

   invoke lstrlen, [str2]
   mov ecx, eax
   mov esi, [str2]
   rep movsb

   pop edi
   pop esi
   ret
endp

proc StdcallProcSample str1, str2

local buff:DWORD
local hProcHeap:DWORD

  invoke lstrlen, [str1]
   mov [buff], eax
   invoke lstrlen, [str2]
   add [buff], eax
   inc dword [buff]

   invoke GetProcessHeap
   mov [hProcHeap], eax
   invoke HeapAlloc, eax, HEAP_ZERO_MEMORY, [buff]
   mov [buff], eax

   stdcall ConcatStrings, [strl], [str2], [buff]

   invoke MessageBox, 0 , [buff], [str2], 0
   invoke HeapFree, [hProcHeap], 0, [buff]

   ret
endp

start:
   stdcall StdcallProcSample, Message, caption

   invoke ExitProcess, 0
stdcall [MessageBox],0, Message, caption,0 ;fghjdxzahjkkkkkkkkkkkkkkkkkkkkkkkkkkkk˚˚˚˚˚˚˚˚‚‚‚‚‚‚‚‚‚‡Ë
invoke MessageBox,0, Message, caption,0

struct EXCEPTION_RECORD
ExceptionCode dd ?
ExceptionFlags dd ?
ExceptionRecord dd ?
ExceptionAddress dd ?
NumberParameters dd ?
ExceptionInformation dd EXCEPTION_MAXIMUM_PARAMETERS dup (?)
ends

section '.code' code readable executable

proc ConcatStrings str1, str2, str3
   push esi
   push edi
   invoke lstrlen, [str1]
   mov ecx, eax
   mov esi, [str1]
   mov edi, [str3]
   rep movsb

   invoke lstrlen, [str2]
   mov ecx, eax
   mov esi, [str2]
   rep movsb

   pop edi
   pop esi
   ret
endp

proc StdcallProcSample str1, str2

local buff:DWORD
local hProcHeap:DWORD

  invoke lstrlen, [str1]
   mov [buff], eax
   invoke lstrlen, [str2]
   add [buff], eax
   inc dword [buff]

   invoke GetProcessHeap
   mov [hProcHeap], eax
   invoke HeapAlloc, eax, HEAP_ZERO_MEMORY, [buff]
   mov [buff], eax

   stdcall ConcatStrings, [strl], [str2], [buff]

   invoke MessageBox, 0 , [buff], [str2], 0
   invoke HeapFree, [hProcHeap], 0, [buff]

   ret
endp

start:
   stdcall StdcallProcSample, Message, caption

   invoke ExitProcess, 0
stdcall [MessageBox],0, Message, caption,0
invoke MessageBox,0, Message, caption,0

struct EXCEPTION_RECORD
ExceptionCode dd ?
ExceptionFlags dd ?
ExceptionRecord dd ?
ExceptionAddress dd ?
NumberParameters dd ?
Exceptionlnformation dd EXCEPTION_MAXIMUM_PARAMETERS dup (?)
ends


#KEYWORD=ApiWordType
NULL
TRUE

#KEYWORD=APIStructKeyword
ABC
ABCFLOAT

#KEYWORD=Register
AH
AL

#KEYWORD=MsvcrtAndMasm32
crt__CIacos
crt__CIasin

#KEYWORD=Commands
AAA
AAD

#KEYWORD=API
ArgCl
ArgClC

#KEYWORD=KmdKitConst
STATUS_SUCCESS
FACILITY_USB_ERROR_CODE

#KEYWORD=KmdKitAPI
CcInitializeCacheManager
CcHasInactiveViews

#KEYWORD=StandardType
0FFFF

push		exception_handler
push		dword [FS:0]
mov		[FS:0],esp

-----------------------------------------------------------------------------------------

proc WndProc hwnd, wmsg, wparam, lparam

	pushad
	cmp	[wmsg], WM_DESTROY
	je	.wmdestroy
	cmp	[wmsg], WM_COMMAND
	jne	.default
	mov	eax, [wparam]
	shr	eax, 16
	cmp	eax, BN_CLICKED
	jne	.default
	mov	eax, [lparam]
	cmp	eax, [AboutBtnHandle]
	je	.about
	cmp	eax, [ExitBtnHandle]
	je	.wmdestroy

.default:
	invoke	DefWindowProc, [hwnd],[wmsg],[wparam], [lparam]
	jmp	.finish

.about:
	invoke MessageBox, 0, AboutText, szTitleName,0
	jmp .finish

.wmdestroy:
	invoke	ExitProcess,0
.finish:
	mov [esp+28], eax
	popad
	ret
endp









