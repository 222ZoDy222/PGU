; call_gate.asm
; ��������� ������������� �������������� ����� ������

        .model tiny
        .code
        .386p
        org     100h

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; ���������
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

; ���������� ����������
segment_descriptor struct
    limit_low   dw      0    ; ������� ��� ����� ���� Segment limit
    base_low    dw      0    ; ������� ��� ����� ���� Base Address
    base_high0  db      0    ; ������ ���� ���� Base Address
    type_and_permit db  0    ; �����
    flags       db      0    ; ��� ���� �����
    base_high1  db      0    ; ������� ���� ���� Base Address
segment_descriptor ends

; ���������� �����
gate_descriptor struct
    offset_low  dw      0    ; ��� ������� ����� ���� Offset
    selector    dw      0    ; ���� Segment Selector
    params      db      0    ; ���������� ���������� � �����
    type_and_permit db  0    ; �����
    offset_high dw      0    ; ������� ����� ���� Offset
gate_descriptor ends

; �������, ����������� ������� �����������
table_register struct
    limit       dw      0    ; Table Limit
    base        dd      0    ; Linear Base Address
table_register ends

;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; ���
;
;;;;;;;;;;;;;;;;;;;;;;;;;;

start:
        ; �������������� DS
        push    cs
        pop     ds

        ; � es - ������ �����������. ����� ���� ������� �� ��
        ; ����� ���������� ����������� ������, �� ��� �����
        push    0b800h
        pop     es

        ; ������������� ���������� ������� � long-jmp-to-RM
        mov     ax, cs
        mov     cs:rm_cs, ax

        ; ������� ����
        mov     eax, offset cs0_dsc
        mov     ebx, 0
        call    init_descriptor_base

        ; ��������� ����������
        call disable_interrupts
        ; �������������� GDT
        call initialize_gdt
        ; ����������� �����
        call set_PE

        ; 16-��������� ������� �������. ���������� ���������� cs �� �����������
        ; ��� ��������� ������ (�����) � ���������� ��� ����������� (��������).
        ; ������� ����� �������� �������� ��������� � cs,
        ; ������� �������� ����� ��������� �����
        db      0EAh    ; ��� ������� �������� ��������
        dw      $ + 4   ; ��������
        dw      cs0_sel ; ��������

        ; �������� � ����
        mov    eax, 255
        push   eax

        ; ����� ������� ����� ����
        db 9Ah
        dw 0
        dw call_sel

        ; ������� � RM
        call clear_PE

        ; �� � �������� ������, �������� ����������� ��������� �������� cs 

        ; 16-��������� ������� �������. ���������� ���������� cs �� �����������
        ; ��� ���������� ������ (��������) � ���������� ��� �������� (�����).
        ; ����� �������� ����������� � ������������� �� ����� ����������.
        db      0EAh   ; ��� ������� �������� ��������
        dw      $ + 4  ; ��������
rm_cs   dw      0      ; �������

        call enable_interrupts
        ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; ��������� �������
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; ���������� ���� ������������� ��������.
; �������� �� ������, ��������� �������� ��������� � ��������� ���� ��������
call_handler:

        ; ��������� ����� � ������ ������:
        ; [esp]      � eip
        ; [esp + 4]  � cs
        ; [esp + 8]  � ��������

        ; �������� �������� � ebx
        mov ebx, [esp + 8]

        push   eax
        push   ecx

        mov    eax, 0         ; ������� ������
        mov    ecx, 80 * 25   ; ����������� �������� �� ������

        ; �������� �� ������, ����������� �������� ���� ��������

screen_loop1:
        inc    eax
        add    byte ptr es:[eax], bl          ; ������ �������
        inc    eax
        loop   screen_loop1

        pop    ecx
        pop    eax

        ; 32-� ��������� ����� � �������� �����
        db 66h
        retf 4

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; ������
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; ���������� ������� ������������
GDT          label   byte
             ; ������� ����������
             segment_descriptor <>
             ; ���������� ����� ������
             gate_descriptor <call_handler, cs0_sel, 1, 11101100b, 0>
             ; ���������� �������� ���� � ���������� ������������
cs0_dsc      segment_descriptor <0ffffh, 0, 0, 10011010b, 0, 0>

; ������ ��� �������� � GDTR
gdtr      table_register <$ - GDT - 1, 0>

; ���������
call_sel     equ 00001000b    ; �������� ����� ������
cs0_sel      equ 00010000b    ; ������� ���������� ����

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; ��������� �������
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; ������������� ���� ����������� ��������
;    � eax ��������� ����� ��������� segment_descriptor
;    � ebx ��������� �������� ���� ������������ cs
init_descriptor_base:
        push   ecx

        ; �������� ����
        mov     ecx, 0
        mov     cx, cs
        shl     ecx, 4
        add     ecx, ebx

        ; ����������� � � ����������
        mov     (segment_descriptor ptr [eax]).base_low, cx
        shr     ecx, 16
        mov     (segment_descriptor ptr [eax]).base_high0, cl

        pop     ecx
        ret

; �������������� GDT
initialize_gdt:
        ; ��������� �������� ����� ������ ������� ������������
        call    cs_to_eax
        add     eax, offset GDT
        ; ���������� ��� � ���������
        mov     dword ptr gdtr.base, eax

        ; ��������� GDTR
        lgdt    fword ptr gdtr
        ret

; ��������� ����������� � ������������� ����������
disable_interrupts:
        cli              ; ��������� ����������
        in      al, 70h  ; ��������� ���� CMOS
        or      al, 80h  ; ��������� ���� 7 � ��� ��������� NMI
        out     70h, al
        ret

; ��������� ����������� � ������������� ����������
enable_interrupts:
        in      al, 70h  ; ��������� ���� CMOS
        and     al, 7Fh  ; ����� ���� 7 �������� ������������ NMI
        out     70h, al
        sti              ; ��������� ����������
        ret

; ������������� ���� PE
set_PE:
        mov     eax, cr0 ; ��������� ������� CR0
        or      al, 1    ; ���������� ��� PE,
        mov     cr0, eax ; � ����� ������� �� � ���������� ������
        ret

; ���������� ���� PE
clear_PE:
        mov     eax, cr0 ; ��������� CR0
        and     al, 0FEh ; �������� ��� PE
        mov     cr0, eax ; � ����� ������� �� � �������� ������
        ret

; ��������� �������� ����� ������ �������� ����
cs_to_eax:
        mov     eax, 0
        mov     ax, cs
        shl     eax, 4
        ret

        end     start
