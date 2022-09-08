; call_gate.asm
; Программа демонстрирует изспользование шлюза вызова

        .model tiny
        .code
        .386p
        org     100h

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Структуры
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Сегментный дескриптор
segment_descriptor struct
    limit_low   dw      0    ; Младшие два байта поля Segment limit
    base_low    dw      0    ; Младшие два байта поля Base Address
    base_high0  db      0    ; Второй байт поля Base Address
    type_and_permit db  0    ; Флаги
    flags       db      0    ; Ещё одни флаги
    base_high1  db      0    ; Старший байт поля Base Address
segment_descriptor ends

; Дескриптор шлюза
gate_descriptor struct
    offset_low  dw      0    ; Два младших байта поля Offset
    selector    dw      0    ; Поле Segment Selector
    params      db      0    ; Количество параметров в стеке
    type_and_permit db  0    ; Флаги
    offset_high dw      0    ; Старшие байты поля Offset
gate_descriptor ends

; Регистр, описывающий таблицу дескриптров
table_register struct
    limit       dw      0    ; Table Limit
    base        dd      0    ; Linear Base Address
table_register ends

;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Код
;
;;;;;;;;;;;;;;;;;;;;;;;;;;

start:
        ; Подготавливаем DS
        push    cs
        pop     ds

        ; В es - начало видеобуфера. Можно было сделать то же
        ; самое средствами защищённого режима, но так проще
        push    0b800h
        pop     es

        ; Устанавливаем правильный сегмент в long-jmp-to-RM
        mov     ax, cs
        mov     cs:rm_cs, ax

        ; Сегмент кода
        mov     eax, offset cs0_dsc
        mov     ebx, 0
        call    init_descriptor_base

        ; Запрещаем прерывания
        call disable_interrupts
        ; Инициализируем GDT
        call initialize_gdt
        ; Переключаем режим
        call set_PE

        ; 16-разрядный дальний переход. Перключает содержимое cs из нормального
        ; для реального режима (адрес) в нормальное для защищённого (селектор).
        ; Базовый адрес целевого сегмента совпадает с cs,
        ; поэтому смещение можно прописать сразу
        db      0EAh    ; код команды дальнего перехода
        dw      $ + 4   ; смещение
        dw      cs0_sel ; селектор

        ; параметр в стек
        mov    eax, 255
        push   eax

        ; вызов функции через шлюз
        db 9Ah
        dw 0
        dw call_sel

        ; Обратно в RM
        call clear_PE

        ; Мы в реальном режиме, осталось разобраться значением регистра cs 

        ; 16-разрядный дальний переход. Перключает содержимое cs из нормального
        ; для защищённог режима (селектор) в нормальное для реальног (адрес).
        ; Адрес сегмента вычисляется и прописывается во время выполнения.
        db      0EAh   ; код команды дальнего перехода
        dw      $ + 4  ; смещение
rm_cs   dw      0      ; сегмент

        call enable_interrupts
        ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Системная функция
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Приниммает один четырёхбайтный параметр.
; проходит по экрану, добавляет значение параметра к атрибутам всех символов
call_handler:

        ; Состояние стека в данный момент:
        ; [esp]      – eip
        ; [esp + 4]  – cs
        ; [esp + 8]  – параметр

        ; Помещаем параметр в ebx
        mov ebx, [esp + 8]

        push   eax
        push   ecx

        mov    eax, 0         ; Текущий символ
        mov    ecx, 80 * 25   ; Колическтво символов на экране

        ; проходит по экрану, увеличивает атрибуты всех символов

screen_loop1:
        inc    eax
        add    byte ptr es:[eax], bl          ; Меняем атрибут
        inc    eax
        loop   screen_loop1

        pop    ecx
        pop    eax

        ; 32-х разрядный выход с очисткой стека
        db 66h
        retf 4

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Данные
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Глобальная таблица дескрипторов
GDT          label   byte
             ; Нулевой дескриптор
             segment_descriptor <>
             ; Дескриптор шлюза вызова
             gate_descriptor <call_handler, cs0_sel, 1, 11101100b, 0>
             ; Дескриптор сегмента кода с системными привелегиями
cs0_dsc      segment_descriptor <0ffffh, 0, 0, 10011010b, 0, 0>

; Данные для загрузки в GDTR
gdtr      table_register <$ - GDT - 1, 0>

; Селекторы
call_sel     equ 00001000b    ; селектор шлюза вызова
cs0_sel      equ 00010000b    ; сегмент системного кода

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Служебные функции
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Устанавливает базу дескриптора сегмента
;    в eax передаётся адрес структуры segment_descriptor
;    в ebx передаётся смещение базы относительно cs
init_descriptor_base:
        push   ecx

        ; Получаем базу
        mov     ecx, 0
        mov     cx, cs
        shl     ecx, 4
        add     ecx, ebx

        ; Прописываем её в дескриптор
        mov     (segment_descriptor ptr [eax]).base_low, cx
        shr     ecx, 16
        mov     (segment_descriptor ptr [eax]).base_high0, cl

        pop     ecx
        ret

; Инициализирует GDT
initialize_gdt:
        ; Вычисляем линейный адрес начала массива дескрипторов
        call    cs_to_eax
        add     eax, offset GDT
        ; Записываем его в структуру
        mov     dword ptr gdtr.base, eax

        ; Загружаем GDTR
        lgdt    fword ptr gdtr
        ret

; Запрещает маскируемые и немаскируемые прерывания
disable_interrupts:
        cli              ; запретить прерывания
        in      al, 70h  ; индексный порт CMOS
        or      al, 80h  ; установка бита 7 в нем запрещает NMI
        out     70h, al
        ret

; Разрешает маскируемые и немаскируемые прерывания
enable_interrupts:
        in      al, 70h  ; индексный порт CMOS
        and     al, 7Fh  ; сброс бита 7 отменяет блокирование NMI
        out     70h, al
        sti              ; разрешить прерывания
        ret

; Устанавливает флаг PE
set_PE:
        mov     eax, cr0 ; прочитать регистр CR0
        or      al, 1    ; установить бит PE,
        mov     cr0, eax ; с этого момента мы в защищенном режиме
        ret

; Сбрасывает флаг PE
clear_PE:
        mov     eax, cr0 ; прочитать CR0
        and     al, 0FEh ; сбросить бит PE
        mov     cr0, eax ; с этого момента мы в реальном режиме
        ret

; Вычисляет линейный адрес начала сегмента кода
cs_to_eax:
        mov     eax, 0
        mov     ax, cs
        shl     eax, 4
        ret

        end     start
