sseg segment para stack 'stack'
     dw      10h dup(?)
sseg ends

dseg segment para public 'data'
     header  db   '   Lab N2 Hello, world!',13,10,'$'
     offline   db   '* Printer error',13,10,'$'
     iserr    db   0
dseg ends

cseg segment para public 'code'
assume cs:cseg,ds:dseg,ss:sseg
start:

       mov      ax,dseg          ;
       mov      ds,ax            ; Поместим первую строку header в bx
       mov      bx,offset header ;

       xor      ax,ax        ; 0 -> ax
       mov      es,ax        ; 0 -> es
       mov      dx,es:[408h] ; В dx номер порта вых. регистра LPT1 (bios)
       
       ;reset printer
       xor      ax,ax  
       inc      dx           ; В dx - номер порта статуса
       inc      dx
       in       al, dx
       or       al, 00001000b
       and      al, 11111011b
       out      dx, al

        mov      di, 1000
loop1: 
       dec      di
       cmp      di, 0
       jne      loop1   
    
       or       al, 00000100b
       out      dx, al   
       dec      dx           ; В dx - номер порта статуса 

       xor      ax,ax

e1:    in       al,dx     ; Получаем в al статус принтера на текущ. момент
       test     al,01000b ; Анализ бита ошибки 3. Если он = 0, то ошибка
       jz e2              ; Если ошибка, переходим к ее обработке - e2,e3...
       jmp ok             ; Иначе - посылаем следующий символ на печать

e2:    mov      dx,offset offline   ; 
       mov      ah,09h              ;
       int      21h                 ; 
       jmp      ext                 ; Выход из программы

ok:    dec      dx         ; В dx номер порта выходного регистра
       mov      al,[bx]    ; В al передается очередной символ
       inc      bx         ; Выбор следующего символа в строке
       cmp      al,'$'     ; Проверка: если символ $, то завершение EXT
       je       ext

       out      dx,al      ; Символ al пересылается в порт
       inc      dx         ; К dx дважды прибавляется 1 и теперь
       inc      dx         ;   в dx номер порта регистра управления

       mov      al,0Dh     ; В al код для стробирующего импульса
       out      dx,al      ; Выдача в порт стробирующего импульса
       mov      al,0Ch     ; В al код отмены стробы
       out      dx,al      ; Отмена стробирующего импульса
       dec      dx         ; В dx номер порта регистра статуса

no:    in       al,dx   ; Чтение состояния регистра статуса
       test     al,80h  ; Ожидание готовности принтера (анализ бита 7
       jz       no      ;   в регистре статуса)
       jmp      e1      ; Переход для проверки на ошибки и дальнейшего
                        ;   вывода следующего символа

ext:   mov      ax,4C00h  ; Выход
       int      21h

cseg ends
end start
