; Author : rpy3uH
;
; E-mail: ahilles1806[a]rambler.ru
;
; last update 4.07.2010


; macro for static UNICODE_STRING definition 
macro UNICODE_STRING_define name,string
{
    _us_#name du #string
    _us_#name_len = ($ - _us_#name)
    dw 0
    #name _UNICODE_STRING _us_#name_len,(_us_#name_len+2),_us_#name
}

macro fastcall func, p1, p2, [px]
{
    if ~ px eq
      reverse push px
    end if
    if ~ p1 eq
      mov ecx,p1
    end if
    if ~ p2 eq
      mov edx,p2
    end if
    call [func]
}
