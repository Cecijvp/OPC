TITLE TareaCB           (TareaCB4.asm)

; convierte un DWORD a un ASCII y un SDWORD a ASCII

INCLUDE myIrvine.inc

.DATA
; Declaracion de datos
dirRet DWORD ?

numb SDWORD ?
buffS DWORD ?

numbInt SDWORD ?
sizeDW DWORD ?
buffStr DWORD ?
ten DWORD 10
digito BYTE ?
asciiStr BYTE ?
tmp DWORD ?

messageGetN BYTE "Ingrese el numero: ", 0
messageGetBuffer BYTE "Ingrese el tamano del buffer del String: ", 0

dwStr BYTE 10 DUP(0)
sdwStr BYTE 11 DUP(0)

.CODE
; Procedimiento principal
main PROC
    mov EDX, OFFSET messageGetN
    call WriteString
    call ReadInt
    mov number, EAX
    mov EDX, OFFSET messageGetBuffer
    call WriteString
    call ReadInt
    mov bufferSize, EAX

    push number
    push bufferSize
    push LENGTHOF dwStr
    call dwToStr
    call CrLf

    push number
    push bufferSize
    push LENGTHOF dwStr
    call sdwToStr

exit  
main ENDP
; Termina el procedimiento principal

dwToStr PROC
    pop dirTmp
    pop sizeDW
    pop bufferToStr
    pop numberInt

    mov ESI, bufferToStr
    dec ESI
    mov EBX, SDWORD PTR numberInt
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
    push dirTmp
    ret
dwToStr ENDP

sdwToStr PROC
    pop dirTmp
    pop sizeDW
    pop bufferToStr
    pop numberInt

    mov ESI, bufferToStr
    mov EBX, numberInt
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
    push dirTmp
    ret
sdwToStr ENDP

END main