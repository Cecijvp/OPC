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
A   DWORD 5
B   DWORD 3
C1   DWORD 7
D   DWORD 1
msj BYTE "Números: "
 


.CODE
; Procedimiento principal
main PROC
    push A
    push B
    push C1
    push D
    call aux

    mov EDX, OFFSET msj
    call Crlf
    pop EAX
    call writeInt
    call Crlf
    pop EAX
    call writeInt
    call Crlf
    pop EAX
    call writeInt
    call Crlf
    pop EAX
    call writeInt
    call Crlf
        
main ENDP

aux PROC
    pop ESI 
    pop EDX
    pop ECX
    pop EBX
    pop EAX

    inc EAX
    inc EBX
    inc ECX
    inc EDX

    push EAX
    push EBX
    push ECX
    push EDX
    push ESI
        RET
aux ENDP
; Termina el procedimiento principal
END main
; Termina el area de Ensamble
