stseg   segment para    stack
        dw      16      dup(?)
stseg   ends
dseg    segment para
a       dw      10
b       dw      20
c       dw      25
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
        mov     ax,a
        add     ax,b
        sub     ax,c
        mov     y,ax
        ret
lab1    endp
cseg    ends
        end     lab1



