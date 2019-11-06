TITLE *MASM Template	(TareaBC1.asm)*

; Descripcion:
; imprimir los dos vectores Svector y Cvector.
; Producto del primer elemento de Svector por el primer elemento de Cvector

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
Svector  WORD 2002h, 4004h, 6006h, 8008h
Cvector  SWORD  -2, -4, -6, -8
msg1     BYTE "Svector",0
msg2     BYTE "Cvector",0
msg3     BYTE "Producto: ",0

.CODE
; Procedimiento principal
main PROC

   
    ;imprimir con DumpRegs
    mov EDX, OFFSET msg1        
    call WriteString
    call CrLf
    
    movzx EAX, Svector
    movzx EBX, Svector+1
    movzx ECX, Svector+2
    movzx EDX, Svector+3
    call DumpRegs

    mov EDX, OFFSET msg2       
    call WriteString
    call CrLf
    
    movsx EAX, Cvector
    movsx EBX, Cvector+1
    movsx ECX, Cvector+2
    movsx EDX, Cvector+3
    call DumpRegs

    ; producto Svector x Cvector
    movzx EAX, Svector
    movsx EBX, Cvector
    imul  EBX
    mov EDX, OFFSET msg3      
    call WriteString
    call writeHex
    
    
    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main