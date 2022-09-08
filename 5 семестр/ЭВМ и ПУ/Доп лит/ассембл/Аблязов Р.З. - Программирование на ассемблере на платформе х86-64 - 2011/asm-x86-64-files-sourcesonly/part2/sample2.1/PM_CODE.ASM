	mov	       ESI, message	
	mov	       EDI, 0B8000h		   
	mov	       ECX,18		

	rep	       movsb			
	jmp	       $		

message: db "152535455565758595"
