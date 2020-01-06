TITLE SgExm19.asm

; Esqueleto para el segundo examen.

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

.DATA
; DATA del procedimiento "main"
indices DWORD 7, 2, 8, 11, 14, 3, 20
        DWORD 10, 5, 0, 16, 9, 1, 4, 6
canin DWORD ?
consumos DWORD 1000, 2000, 3000, 4000
         DWORD 5000, 0, 12000, 11000
         DWORD 6000, 9000, 8000, 7000
canco DWORD ?


; DATA del procedimiento "ID"
textoID BYTE "Soy 150482CeciliaV", 0

; DATA del procedimiento ctaElemsArreglo
contInd SDWORD 0
dirRet  DWORD ?
auxElem DWORD 0

;  DATA del procedimiento ImprimirConsumos
dirRet1 DWORD 0
cont2   SDWORD 0
cont1   SDWORD 0
aux     DWORD ?
auxArr  DWORD 0
tipo    DWORD 4
msjIn   BYTE  "Consumo ",0
msjFin  BYTE  " con valor: ",0
bye BYTE "HASTA LUEGO.", 0
msjInd BYTE "Total de indices: ", 0
msjCon BYTE "Total de consumos de agua: ", 0
auxPar  SDWORD 0


.CODE
main PROC

    call ID
    call CrLF

    ; llamada al procedimiento para contar los elementos de indice
    mov canin, -1
    push OFFSET indices
    call ctaElemsArreglo
    pop canin

    ; llamada al procedimiento para contar los elementos de consumos
    mov canco, -1
    push OFFSET consumos
    call ctaElemsArreglo
    pop canco

    ;impresión del total de indices y consumos
    mov EDX, OFFSET msjInd
    call WriteString
    mov EAX, canin
    call WriteInt
    call CrLF

    mov EDX, OFFSET msjCon
    call WriteString
    mov EAX, canco
    call WriteInt
    call CrLF
    call CrLF


    
    ; llamada al procedimiento para imprimir el arreglo
    push OFFSET indices
    push OFFSET consumos
    push canin
    push canco
    call ImprimirConsumos
    
    call CrLF
    mov EDX, OFFSET bye
    call WriteString

    EXIT
main ENDP

; Procedimiento para imprimir mi ID
; No hay argumentos a pasar. El string es local.
; No hay resultado a regresar.
ID PROC
    call CrLF
    mov EDX, oFFSET textoID
    call WriteString
    call CrLF
    RET
ID ENDP

; Procedimiento para contar el numero de elementos de un arreglo
; Argumentos: Direccion de incio del arreglo.
; Resultado: El total de elementos del arreglo.
ctaElemsArreglo PROC
    POP dirRet
    POP EDI 

    mov contInd, 0
    mov EAX, [EDI]
    mov auxElem, -1
    .WHILE SDWORD PTR EAX > auxElem
        INC contInd
        add EDI, TYPE EAX
        mov EAX, [EDI]
    .ENDW

    push contInd
    push dirRet
    ret

ctaElemsArreglo ENDP

; Procedimiento para imprimir el contenido de consumos dado el arreglo de indices
; Argumentos: Direcciones de los arreglos.
; No hay resultado a regresar.
ImprimirConsumos PROC
    pop dirRet1
    pop cont2
    pop cont1
    pop auxArr
    pop EDI

    mov EBX,0
    mov aux,0
    .WHILE SDWORD PTR EBX < cont1
         mov EDX, [EDI]
         mov aux,EDX
        .IF SDWORD PTR EDX < cont2
             mov ESI, auxArr
             mov EAX, aux
             mul tipo
             add ESI, EAX
             mov EDX, OFFSET msjIn
             call WriteString
             mov EAX, aux
             call WriteInt
             mov EDX, OFFSET msjFin
             call WriteString
             
             mov ECX, auxPar
             and ECX,1
             mov EAX, DWORD PTR [ESI]
            .IF ECX ==0
                neg EAX
            .ENDIF
             call WriteInt
             call CrLF      
             inc auxPar 
         .ENDIF
        add EDI, TYPE EAX
        inc EBX     
        
    .ENDW
    push dirRet1
    RET
ImprimirConsumos ENDP


END main