TITLE TareaCB           (TareaCB3.asm)

; leer un entero de 32 bits e imprimir su representación en 
; hexadecimal en 8 caracteres.

INCLUDE myIrvine.inc

.DATA
; Declaracion de datos
dirRet DWORD ?
numb   DWORD ?

msjEnt BYTE "Entero de 32 bits: ", 0
msjhex BYTE "El equivalente HEX a 32 bits es: ", 0
bye    BYTE "ADIOS.", 0

nStr BYTE 8 DUP(?), 0
nHex BYTE 8 DUP(?), 0

.CODE
; Procedimiento principal
main PROC

    mov EDX, OFFSET msjEnt
    call WriteString
    call ReadInt
    mov numb, EAX

    mov EDX, OFFSET msjhex
    call WriteString
    
    push OFFSET numb
    call convHex
    pop EDX
    call WriteString
    call CrLf

    mov EDX, OFFSET bye
    call WriteString
exit  
main ENDP
; Termina el procedimiento principal

convHex PROC
; convHex(dirNumb): nHex
; Recibe:
;   Stack: la dirección del número entero de 32 bits a convertir
;           en hexadecimal
; Regresa:
;   Stack: nHex, el string con la representación del entero en
;           hexadecimal.
; Variables automáticas y locales

    pop dirRet
    pop ESI ;dir numb
    mov EBX, 0
    .WHILE EBX < 8
        mov EAX, 0
        mov ECX, 0
        mov ECX, DWORD PTR [ESI]
        shld EAX, ECX, 4
        mov nHex[EBX], AL
        .IF AL <= 9
            add nHex[EBX], 48
        .ELSE
            add nHex[EBX], 65
            sub nHex[EBX], 10
        .ENDIF
        mov EAX, 0
        shld EAX, ECX, 8
        and AL, 00001111b
        mov nHex[EBX + 1], AL
        .IF AL <= 9
            add nHex[EBX + 1], 48
        .ELSE
            add nHex[EBX + 1], 65
            sub nHex[EBX + 1], 10
        .ENDIF
        dec ESI
        add EBX, 2
    .ENDW
    push OFFSET nHex
    push dirRet
    Ret
convHex ENDP

END main
; Termina el área de Ensamble