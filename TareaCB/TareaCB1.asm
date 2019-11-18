TITLE Multiple Doubleword Shift            (MultiShift.asm)

; Demonstration of multi-doubleword shift, using
; SHR and RCR instructions.

INCLUDE myIrvine.inc

ArraySize = 3

.DATA
diRet  DWORD ?
n      DWORD ?
numb   DWORD 4 DUP(?)
sf     DWORD ?

msjDw  BYTE "DWORD ", 0
msjDwF BYTE "o: ", 0
msjN   BYTE "N: ", 0
msjDes BYTE "Bits a desplazar: ", 0
msjAnt BYTE "Resultado Inicial: ", 0
msjD   BYTE "Resultado Final: ", 0
bye    BYTE "ADIOS.", 0

.CODE
main PROC
    push OFFSET msjN
    push OFFSET n
    call obtenerN

    mov EBX,0
    .WHILE EBX < n
        mov EDX, OFFSET msjDw
        call WriteString
        mov EAX, EBX
        inc EAX
        call WriteInt
        mov EDX, OFFSET msjDwF
        call WriteString
        call ReadHex
        mov numb[EBX * TYPE numb], EAX
        inc EBX
    .ENDW

    mov EAX, 0
    .WHILE (EAX < 1) || (EAX > 4) ;Mientras esté fuera del rango
        mov EDX, OFFSET msjDes
        call WriteString
        call ReadInt
        mov sf, EAX
    .ENDW

    ;Imprimir antes del movimiento
    mov EDX, OFFSET msjAnt
    call WriteString
    call CrLf
    push n
    push OFFSET numb
    call impBin

    ;Shiftear n veces
    push n
    push OFFSET sf
    push OFFSET numb
    call shiftNumb

    ;Imprime despues de movimientos
    mov EDX, OFFSET msjD
    call WriteString
    call CrLf
    push n
    push OFFSET numb
    call impBin

    mov EDX, OFFSET bye
    call WriteString
    
    EXIT
main ENDP

obtenerN PROC
; obtenerN (dirMsj, dirN)
; No regresa resultados.
; Obtener el valor de 'n' dado por el usuario e insertarlo en la
; dirección de memoria de 'n'
; Recibe
;   Stack: dirección de memoria de donde está el mensaje para pedir
;           el valor de n y dirN implica la dirección en memoria donde
;           se almacenará el valor de 'N'
; Variables automáticas y locales

    pop diRet
    pop ESI     ; N
    pop EDI     ; msjN
    
    .WHILE (EAX < 2) || (EAX > 8) ; mientras el valor de n se salga del rango pedira de nuevo el #
        mov EDX, EDI
        call WriteString
        call ReadInt
        mov DWORD PTR [ESI], EAX
    .ENDW
    push diRet
    RET
obtenerN ENDP

impBin PROC
; impBin(n, dirNumb)
; No regresa algun resultado
; Imprimir los DWORDS que se pidieron al principio del programa
; con o sin modificación en memoria
; Recibe
;   Stack: n y offset de numb
; Variables automáticas y locales

    pop diRet
    pop ESI    ;Offset Numb
    pop EBX    ;n
    
    dec EBX
    .WHILE SDWORD PTR EBX >= 0
        mov EAX, [ESI + EBX*TYPE ESI]
        call WriteBin
        dec EBX
    .ENDW
    call CrLf
    push diRet
    RET
impBin ENDP

shiftNumb PROC
; shiftNumb(n, dirSf, dirNumb)
; No regresa resultados
; Hace el movimiento "shift" bit a bit del arreglo de los números DWORD, hasta
; cumplir con el número de cambios dado por el usuario (sf)
; Recibe
;   Stack: n, las veces que se realizarán los movimientos, la dirección del arreglo
; Variables automáticas y locales

    pop diRet
    pop ESI ;dirección de numb
    pop EDX ;dirección de sf
    pop EAX ; n
    
    mov EBX, 0
    .WHILE EBX < [EDX]
        mov ECX, EAX
        dec ECX
        shr DWORD PTR [ESI], 1
        .WHILE SDWORD PTR ECX >= 0
            rcr DWORD PTR [ESI + ECX*TYPE ESI], 1
            dec ECX
        .ENDW
        inc EBX
    .ENDW
    push diRet
    ret
shiftNumb ENDP


END main