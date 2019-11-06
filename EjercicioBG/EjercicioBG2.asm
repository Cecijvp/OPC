TITLE *MASM Template	(EjerciciosBG2asm)*

; Descripcion:
; Se implementará la siguiente sumatoria
; calcular la multiplicación m*n sin utilizar multiplicación    

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
datoN  BYTE "Teclee el dato N:  ",0
datoM  BYTE "Teclee el dato M:  ",0
err    BYTE "   ERROR: ",0
bye    BYTE "  ADIOS.",0
prod   BYTE "PRODUCTO (",0
par1   BYTE "(",0
par2   BYTE ")",0
ast    BYTE "*",0
puntos BYTE ": ",0
coma BYTE ",",0

N SDWORD ?
M SDWORD ?
res SDWORD 0
aux SDWORD 1

.CODE
; Procedimiento principal
main PROC
    ; se piden los datos del teclado
      datos:
        call CrLf
        mov  EDX, OFFSET datoM
        call WriteString
        call readInt           ; se guarda en EAX
        mov M, EAX             ; guardamos el valor de m en memoria
        mov  EDX, OFFSET datoN
        call WriteString
        call readInt           ; se guarda en EAX el valor de N
        mov N, EAX

        ; se checa si m>=0 y n>=0
        mov EBX, M
        mov ECX, N
        cmp EBX, 0
        jl  error
        cmp EAX, 0
        jl  error
        jmp comparacion ; aqui es para comparar si m<=n

        error:
            mov EDX, OFFSET err
            call WriteString
            mov EAX, M
            call WriteInt
            mov EDX, OFFSET coma
            call WriteString
            mov EAX, N
            call WriteInt
            call CrLf
            jmp adios
            
        comparacion:
            ; aqui se verificara que  m<=n siempre se cumpla
            cmp EBX,ECX
            jg cambio
            jmp multiplicacion

        cambio: 
            ; aqui si no se cumple que m<=n se hara lo siguiente: m=n y n=m
            xchg EBX,ECX ; m=n y n=m
            mov M, EBX
            mov N, ECX
            
        multiplicacion:
            ; aqui se hace m veces n 
            cmp aux,EBX
            jg salida
            add res,ECX
            inc aux
            jmp multiplicacion

        salida:
            call CrLf
            mov  EDX, OFFSET prod
            call WriteString
            mov  EAX, M
            call writeInt
            mov  EDX, OFFSET par2
            call WriteString
            mov  EDX, OFFSET ast
            call WriteString
            mov  EDX, OFFSET par1
            call WriteString
            mov  EAX, N
            call WriteInt
            mov  EDX, OFFSET par2
            call WriteString
            mov  EDX, OFFSET puntos
            call WriteString
            mov  EAX, res
            call writeInt

        adios:
            call CrLf
            mov EDX, OFFSET bye
            call WriteString
              
            
        exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main