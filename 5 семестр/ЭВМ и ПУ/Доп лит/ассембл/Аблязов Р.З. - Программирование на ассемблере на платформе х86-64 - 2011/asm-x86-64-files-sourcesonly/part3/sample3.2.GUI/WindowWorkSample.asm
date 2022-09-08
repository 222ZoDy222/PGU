format PE GUI 4.0
entry start

include 'win32a.inc'

section '.code' code executable readable writeable


main_hwnd	  dd 0
msg		MSG
wc		WNDCLASS
	
hInst		dd 00000000h
szTitleName	db 'Window work sample',0
szClassName	db 'ASMCLASS32',0

button_class	db 'BUTTON',0
AboutTitle	db 'About',0
AboutText	db 'First window program',0;
ExitTitle	db 'Exit',0

AboutBtnHandle	dd ?
ExitBtnHandle	dd ?


start:	
   
	invoke	GetModuleHandle,0

	mov	[hInst], eax
	mov	[wc.style], CS_HREDRAW + CS_VREDRAW + CS_GLOBALCLASS
	mov	[wc.lpfnWndProc],  WndProc
	mov	[wc.cbClsExtra], 0
	mov	[wc.cbWndExtra], 0
	mov	[wc.hInstance], eax

	invoke	LoadIcon,0,IDI_APPLICATION
	mov	[wc.hIcon], eax

	invoke	LoadCursor,0, IDC_ARROW
	mov	[wc.hCursor], eax

	mov	[wc.hbrBackground], COLOR_BACKGROUND+1
	mov	dword [wc.lpszMenuName], 0
	mov	dword [wc.lpszClassName], szClassName

	invoke	RegisterClass, wc

	invoke CreateWindowEx,0,szClassName,szTitleName,\
	       WS_OVERLAPPEDWINDOW, 50,50, 300, 250,\
	       0,0,[hInst],0
	mov	[main_hwnd], eax

	invoke CreateWindowEx, 0, button_class, AboutTitle,\
	       WS_CHILD, 50, 50, 200, 50, [main_hwnd],0,[hInst],0
	mov	[AboutBtnHandle], eax

	invoke CreateWindowEx, 0, button_class, ExitTitle,\
	       WS_CHILD, 50, 150, 200, 50, [main_hwnd],0,[hInst],0
	mov	[ExitBtnHandle], eax

	invoke	  ShowWindow,[main_hwnd],SW_SHOWNORMAL
	invoke	  UpdateWindow,[main_hwnd]
	invoke	  ShowWindow, [AboutBtnHandle],SW_SHOWNORMAL
	invoke	  ShowWindow, [ExitBtnHandle],SW_SHOWNORMAL

msg_loop:
	invoke	 GetMessage, msg,0,0,0

	cmp  eax, 0
	je   end_loop

	invoke	 TranslateMessage, msg
	invoke	 DispatchMessage, msg

	jmp	 msg_loop

end_loop:

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

section '.relocs' fixups readable writeable

section '.idata' import data readable writeable

  library kernel,'KERNEL32.DLL',\
	  user,'USER32.DLL'

  import kernel,\
	 GetModuleHandle,'GetModuleHandleA',\
	 ExitProcess,'ExitProcess'

  import user,\
	 RegisterClass,'RegisterClassA',\
	 CreateWindowEx,'CreateWindowExA',\
	 DefWindowProc,'DefWindowProcA',\
	 GetMessage,'GetMessageA',\
	 TranslateMessage,'TranslateMessage',\
	 DispatchMessage,'DispatchMessageA',\
	 LoadCursor,'LoadCursorA',\
	 LoadIcon,'LoadIconA',\
	 SetWindowPos,'SetWindowPos',\
	 ShowWindow,'ShowWindow',\
	 UpdateWindow,'UpdateWindow',\
	 EnableWindow,'EnableWindow',\
	 SetWindowText,'SetWindowTextA',\
	 MessageBox,'MessageBoxA'



