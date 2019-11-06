TITLE *MASM Template	(TareaBC1.asm)*

; Descripcion:
; Se implementará la siguiente operación 
; R = -A * 9 - (B / D + 1) + 100

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
msg1  BYTE "++++ Dato: ",0
msg2  BYTE "++++ El resultado R= ",0
msg3  BYTE "++++ El resultado Rh= ",0
msg4 BYTE  "++++ Hasta la vista" ,0
A     SDWORD  7
B     SDWORD  ?
D     SDWORD  -15
R     SDWORD  ?
aux   SDWORD ?

.CODE
; Procedimiento principal
main PROC

    ; Se lee el número del teclado
    call CrLf
    mov EDX, OFFSET msg1
    call WriteString
    call readInt  ; se guarda en EAX
    mov B, EAX

    ; Se lleva a cabo las operaciones

    mov  EAX, A
    neg  EAX
    mov  EBX, 9
    imul EBX ; guarda el valor en EAX
    mov  aux, EAX
    mov  EAX,B
    CDQ
    mov  EBX, D
    add  EBX,1
    idiv EBX
    neg  EAX
    add  EAX,aux
    add  EAX,100
    mov  R,EAX
    

    ; se imprimen los resultados
    mov  EDX, OFFSET msg2
    call writeString
    call writeInt
    call CrLf

    mov  EDX, OFFSET msg3
    call writeString
    call writeHex
    call CrLf

    ;se hace un vaciado por consola
    mov ESI, OFFSET A
    mov ECX, 1 
    mov EBX, 4 
    call DumpMem
    
    mov ESI, OFFSET B
    mov ECX, 1 
    mov EBX, 4 
    call DumpMem
    
    mov ESI, OFFSET D
    mov ECX, 1 
    mov EBX, 4 
    call DumpMem
    
    mov ESI, OFFSET R
    mov ECX, 1 
    mov EBX, 4 
    call DumpMem

    ; Mensaje de despedida
    
    mov EDX, OFFSET msg4      ; despliega "HASTA LA VISTA"
    call WriteString
    call CrLf
        
    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main