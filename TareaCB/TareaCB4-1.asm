TITLE *MASM Template	(ejerciciocb4.asm)*

; Descripcion general:
; convertir Dword en ASCII y SDWORD en ASCII

INCLUDE myIrvine.inc


.DATA
; Declaracion de datos
dirRet DWORD ?

numb SDWORD ?
bufferSize DWORD ?

nInt SDWORD ?
sizeDW DWORD ?
bufferToStr DWORD ?
ten DWORD 10
digito BYTE ?
asciiStr BYTE ?
tmp DWORD ?

msjN BYTE "Ingrese el numero: ", 0
msjB BYTE "Ingrese el tamano del buffer del String: ", 0

dwStr BYTE 10 DUP(0)
sdwStr BYTE 11 DUP(0)

.CODE
; Procedimiento principal
main PROC
    mov EDX, OFFSET msjN
    call WriteString
    call ReadInt
    mov numb, EAX
    mov EDX, OFFSET msjB
    call WriteString
    call ReadInt
    mov bufferSize, EAX

    push numb
    push bufferSize
    push LENGTHOF dwStr
    call dwToStr
    call CrLf

    push numb
    push bufferSize
    push LENGTHOF dwStr
    call sdwToStr

exit  
main ENDP
; Termina el procedimiento principal

dwToStr PROC
    pop dirRet
    pop sizeDW
    pop bufferToStr
    pop nInt

    mov ESI, bufferToStr
    dec ESI
    mov EBX, SDWORD PTR nInt
    mov digito, 0
    .WHILE SDWORD PTR EBX != 0
        mov EAX, EBX
        mov EDX, 0
        div ten
        mov EBX, EAX
        mov tmp, EDX
        mov DL, BYTE PTR tmp
        mov digito, DL
        mov asciiStr, 48
        mov AL, digito
        add asciiStr, AL
        mov AL, asciiStr
        mov dwStr[ESI], AL
        dec ESI
    .ENDW

    .IF SDWORD PTR ESI >= 0
        .WHILE SDWORD PTR ESI >= 0
            mov dwStr[ESI], 48
            dec ESI
        .ENDW
    .ENDIF

    mov EDX, OFFSET dwStr
    call WriteString
    push dirRet
    ret
dwToStr ENDP

sdwToStr PROC
    pop dirRet
    pop sizeDW
    pop bufferToStr
    pop nInt

    mov ESI, bufferToStr
    mov EBX, nInt
    mov digito, 0
    .IF SDWORD PTR EBX >= 0
        mov dwStr[0], '+'
    .ELSE
        mov dwStr[0], '-'
        neg EBX
    .ENDIF
    .WHILE SDWORD PTR EBX != 0
        mov EAX, EBX
        cdq
        idiv ten
        mov EBX, EAX
        mov tmp, EDX
        mov DL, BYTE PTR tmp
        mov digito, DL
        mov EAX, 0
        mov AL, digito
        mov asciiStr, 48
        mov AL, digito
        add asciiStr, AL
        mov AL, asciiStr
        mov dwStr[ESI], AL
        dec ESI
    .ENDW

    .IF SDWORD PTR ESI >= 1
        .WHILE SDWORD PTR ESI >= 1
            mov dwStr[ESI], 48
            dec ESI
        .ENDW
    .ENDIF

    mov EDX, OFFSET dwStr
    call WriteString
    push dirRet
    ret
sdwToStr ENDP

END main
; Termina el área de Ensamble