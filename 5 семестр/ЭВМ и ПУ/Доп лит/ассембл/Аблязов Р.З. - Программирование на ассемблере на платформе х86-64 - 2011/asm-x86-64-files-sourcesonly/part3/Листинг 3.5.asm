proc MyFunc param1, param2
local lvar1:DWORD
local lvar2:DWORD

        mov eax, [param1] ; mov eax, [ebp+8]
        mov ebx, [param2] ; mov ebx, [ebp+12]
        mov [lvar1], eax  ; mov [ebp-4], eax
        mov [lvar2], ebx  ; mov [ebp-8], ebx
        ret
endp



