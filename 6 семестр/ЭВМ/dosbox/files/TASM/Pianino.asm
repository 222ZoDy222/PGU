.model tiny
.code
org 100h

main: jmp start
;
stor dw 0            ;our memory location storage
;
            ; Turn the cursor off.
;
start:
call curs_off             ;go turn off cursor
;
     ; Get a keypress from the user, and act accordingly.
     ; (We're checking U.S. keyboard scan codes here.)
;
get_key:
mov ah,0              ;function 0 - wait for keypress
int 16h              ;call ROM BIOS keyboard services
cmp ah,1               ;ESC key pressed?
je exit             ;yes, so go exit
cmp ah,02h
je tone_1
cmp ah,03h
je tone_2
cmp ah,04h
je tone_3
cmp ah,05h
je tone_4
cmp ah,06h
je tone_5
cmp ah,07h
je tone_6
cmp ah,08h
je tone_7
cmp ah,09h
je tone_8
cmp ah,0ah
je tone_9
cmp ah,0bh
je tone_0
;
jmp get_key            ;go get another keypress
;
exit:
call curs_on             ;go turn cursor on
int 20h          ;exit to DOS
;
tone_1:
mov ax, 272
mov stor, ax
call sounder                  ;go generate the tone
jmp get_key              ;go get another keypress
tone_2:
mov ax, 294
mov stor, ax
call sounder              ;go generate the tone
jmp get_key              ;go get another keypress
tone_3:
mov ax, 314
mov stor, ax
call sounder               ;go generate the tone
jmp get_key               ;go get another keypress
tone_4:
mov ax, 330
mov stor, ax
call sounder              ;go generate the tone
jmp get_key              ;go get another keypress
tone_5:
mov ax, 350
mov stor, ax
call sounder            ;go generate the tone
jmp get_key             ;go get another keypress
tone_6:
mov ax, 370
mov stor, ax
call sounder               ;go generate the tone
jmp get_key             ;go get another keypress
tone_7:
mov ax, 392
mov stor, ax
call sounder               ;go generate the tone
jmp get_key             ;go get another keypress
tone_8:
mov ax, 419
mov stor, ax
call sounder           ;go generate the tone
jmp get_key              ;go get another keypress
tone_9:
mov ax, 440
mov stor, ax
call sounder               ;go generate the tone
jmp get_key             ;go get another keypress
tone_0:
mov ax, 475
mov stor, ax
call sounder               ;go generate the tone
jmp get_key             ;go get another keypress



;
;****************************************
; Our sub-routines start here.
;****************************************
;
; Turn cursor off.
;
curs_off:
mov ch,10h     ;set bits to turn cursor off
mov ah,1              ;function 1 - cursor control
int 10h               ;call ROM BIOS video services
ret             ;return to caller
;
     ; Turn cursor on.
;
curs_on:
mov cx,0506h              ;set bits to turn cursor on
mov ah,1              ;function 1 - cursor control
int 10h              ;call ROM BIOS video services
ret               ;return to caller
;
     ; Generate sound through the PC speaker.
;

sounder:
mov al,10110110b         ;load control word
out 43h,al             ;send it
mov ax,stor              ;tone frequency
out 42h,al    ;send LSB
mov al,ah    ;move MSB to AL
out 42h,al    ;save it
in al,61h               ;get port 61 state
or al,00000011b           ;turn on speaker
out 61h,al    ;speaker on now
call delay    ;go pause a little bit
and al,11111100b            ;clear speaker enable
out 61h,al    ;speaker off now
call clr_keyb            ;go clear the keyboard buffer
ret               ;return to caller

delay:
mov ah,00h    ;function 0 - get system timer tick
int 01Ah             ;call ROM BIOS time-of-day services
add dx,4             ;add our delay value to DX
mov bx,dx    ;store result in BX
pozz:
int 01Ah            ;call ROM BIOS time-of-day services
cmp dx,bx    ;has the delay duration passed?
jl pozz            ;no, so go check again
ret            ;return to caller
;
     ; Clear the keyboard buffer.
;
clr_keyb:
push es            ;preserve ES
push di             ;preserve DI
mov ax,40h    ;BIOS segment in AX
mov es,ax    ;transfer to ES
mov ax,1Ah    ;keyboard head pointer in AX
mov di,ax    ;transfer to DI
mov ax,1Eh    ;keyboard buffer start in AX
mov es: word ptr [di],ax ;transfer to head pointer
inc di     ;bump pointer to...
inc di     ;...keyboard tail pointer
mov es: word ptr [di],ax ;transfer to tail pointer
pop di     ;restore DI
pop es     ;restore ES
ret             ;return to caller
;
end main
end