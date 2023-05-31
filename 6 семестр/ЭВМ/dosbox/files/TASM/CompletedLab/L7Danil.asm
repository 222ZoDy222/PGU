stseg segment para stack
dw 16 dup(?)
stseg ends
dseg segment para
dseg ends
cseg segment para

L7Danil proc far
assume cs:cseg,ds:dseg,ss:stseg
mov ah,0h ;функция установки режима
mov al,3h ;номер режима
int 10h ;прерывание

mov bx,0Fh
m1: xor ax,ax
int 16h
mov ah,0Eh
int 10h
cmp al, 27
pushf
call hexen
mov al,20h
int 29h
popf
jne m1

mov ah,4ch
int 21h
hexen proc near
aam 16
mov dx,ax
xchg ah,al
call nibble
mov ax,dx
hexen endp
nibble proc near
and al, 0Fh
Add Al, 90h
Daa
Adc Al, 40h
Daa
int 29h
ret
nibble endp
L7Danil endp
cseg ends
end L7Danil