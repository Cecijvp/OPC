TITLE *MASM Template	(TareaBJ.asm)*

; Descripcion:
; Guardar temperaturas en un arreglo, calcular e imprimir
; la menor temperatura  y su posición
; imprimir el arreglo en orden inverso 

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
arreg   DWORD 8,4,10,20,5,30
tamA    DWORD 6
tamB    DWORD 5  
ind1    DWORD 0
ind2    DWORD 1 


.CODE
; Procedimiento principal
main PROC

       mov ESI, OFFSET arreg
          mov EBX,0  
         .WHILE EBX< tamA
             mov EAX, [ESI]
             call writeInt
             add ESI, TYPE arreg
             call Crlf
             inc EBX
         .ENDW



        mov ESI, OFFSET arreg
        mov EDI, OFFSET arreg
        add EDI, TYPE arreg
        mov EBX,ind1
        
        .WHILE EBX< (tamA-1) 
              mov ECX, ind2
             .WHILE  ECX < tamA
                mov EAX, [ESI]
                mov EDX, [EDI]
                .IF EAX>EDX
                    xchg EAX,EDX
                    mov [ESI], EAX
                    mov [EDI], EDX
                .ENDIF
                inc ECX
                add EDI,TYPE arreg
             .ENDW
                inc EBX
                add ESI, TYPE arreg
                mov EDI,ESI
                add EDI, TYPE arreg
                inc ind2
        .ENDW

          mov ESI, OFFSET arreg
          mov EBX,0  
         .WHILE EBX< tamA
             mov EAX, [ESI]
             call writeInt
             add ESI, TYPE arreg
             call Crlf
             inc EBX
         .ENDW

        exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main