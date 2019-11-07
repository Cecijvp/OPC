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
arr1 SDWORD 11, 10, 12, 14,13,10,12
arr2 SDWORD 209,-131,-96,160,-221,85,-49
tamArr SDWORD 7
dirRet  SDWORD 0
suma SDWORD    0
total SDWORD 0
msjS    BYTE "Suma: ",0
bye    BYTE "ADIOS.",0

.CODE
; Procedimiento principal
main PROC
    mov ESI, OFFSET arr1
    mov EDI, OFFSET arr2
    push ESI
    push EDI
    push tamArr
    call sumaMulti

    pop total
    mov EDX, OFFSET msjS
    call writeString
    mov EAX, total
    call writeInt
    call Crlf
    mov EDX, OFFSET bye
    call writeString
    
    exit
            
main ENDP
    

sumaMulti PROC
    pop dirRet
    pop EBX
    pop EDI
    pop ESI

    mov ECX,0
    .WHILE ECX< EBX
        mov EAX, [ESI]
        mov EDX, [EDI]
        imul EDX
        call writeInt
        call crlf
        add suma, EAX        
        add ESI, TYPE arr1
        add EDI, TYPE arr2
        inc ECX
    .ENDW
    push suma
    push dirRet
  RET
sumaMulti ENDP

; Termina el procedimiento principal
END main
; Termina el area de Ensamble
