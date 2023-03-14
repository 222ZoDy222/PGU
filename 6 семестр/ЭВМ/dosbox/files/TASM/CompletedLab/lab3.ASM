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
lab1    proc    far
        assume  cs:cseg,ds:dseg,ss:stseg
        push    ds
        mov     ax,0
        push    ax
        mov     ax,dseg
        mov     ds,ax
		;---------------------
		mov cx, 8    
		lea si, array
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
		mov y, bx
		;---------------------
        ret
lab1    endp
cseg    ends
        end     lab1



