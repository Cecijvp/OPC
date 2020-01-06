TITLE *MASM Template	(TareaCF2.asm)*

; Descripcion general:
; Tarea ejer2

; Librerias 
INCLUDE myirvine.inc


.DATA
; Declaracion de datos
    n DWORD 0
    factor DWORD 10
    arrLista REAL8 10 DUP(?)

    msjN BYTE "Valor de n: ", 0
    msjFactor BYTE "Valor de Factor: ", 0
    msjArrLista BYTE ". Valor de ArrLista: ", 0
    msjMenor BYTE "El menor de la lista es: ", 0
    coma BYTE ", ", 0
    bye BYTE "ADIOS", 0

    dirRet DWORD ?

    m DWORD 0
    f DWORD 10

    menor REAL8 ?
    menorIndex DWORD ?

.CODE
; Procedimiento principal
main PROC
    finit
    ; pide el dato factor
    .IF factor < 0 || factor > 9
        mov EDX, OFFSET msjFactor
        call WriteString
        call ReadInt
        mov factor, EAX
    .ENDIF
    ; pide el dato n 
    .IF n < 1 || n > 10
        mov EDX, OFFSET msjN
        call WriteString
        call ReadInt
        mov n, EAX
    .ENDIF
    push n
    push OFFSET arrLista
    CALL LeerLista

    push n
    push factor
    push OFFSET arrLista
    CALL FacLista

    push n
    push OFFSET arrLista
    CALL MenorLista
    call Crlf
    mov EDX, OFFSET msjMenor
    call WriteString
    CALL WriteFloat
    mov EDX, OFFSET coma
    call WriteString
    fstp menor
    pop EAX
    CALL WriteInt
    call CrLf

    push n
    push OFFSET arrLista
    CALL Imprime
    
    ; imprime “Adios”

    mov EDX, OFFSET bye
    call CrLf
    call WriteString

exit  
main ENDP
; Termina el procedimiento principal

LeerLista PROC
    pop dirRet
    pop ESI
    pop m

    mov EBX, 0
    .WHILE EBX < m
        mov EAX, EBX
        inc EAX
        call WriteInt
        mov EDX, OFFSET msjArrLista
        call WriteString
        call ReadFloat
        fstp REAL8 PTR [ESI + EBX * TYPE REAL8]
        inc EBX
    .ENDW

    push dirRet
    ret
LeerLista ENDP

FacLista PROC
    pop dirRet
    pop ESI
    pop f
    pop m

    mov EBX, 0
    .WHILE EBX < m
        fild f
        fmul REAL8 PTR [ESI + EBX * TYPE REAL8]
        fstp REAL8 PTR [ESI + EBX * TYPE REAL8]
        inc EBX
    .ENDW

    push dirRet
    ret
FacLista ENDP

MenorLista PROC
    pop dirRet
    pop ESI
    pop m

    mov EBX, 0
    fld REAL8 PTR [ESI + EBX * TYPE REAL8]
    fst menor
    .WHILE EBX < m
        fcomp REAL8 PTR [ESI + EBX * TYPE REAL8]
        fld menor
        fnstsw ax
        sahf
        .IF !Zero? && !Parity? && !Carry?
            fstp menor
            fld REAL8 PTR [ESI + EBX * TYPE REAL8]
            fst menor
            mov menorIndex, EBX
        .ENDIF
        inc EBX
    .ENDW

    inc menorIndex
    push menorIndex
    push dirRet
    ret
MenorLista ENDP

Imprime PROC
    pop dirRet
    pop ESI
    pop m

    mov EBX, 0
    call Crlf
    .WHILE EBX < m
        fld REAL8 PTR [ESI + EBX * TYPE REAL8]
        call WriteFloat
        call CrLf
        fstp REAL8 PTR [ESI + EBX * TYPE REAL8]
        inc EBX
    .ENDW

    push dirRet
    ret
Imprime ENDP

END main
; Termina el área de Ensamble