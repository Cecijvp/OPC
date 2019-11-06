TITLE *MASM Template	(EjerciciosBG1.asm)*

; Descripcion:
; Se implementará la siguiente sumatoria
; suma =-1 + 3 - 6 + 10 - 15 + 21 - 28 +...     

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
dato  BYTE "Teclee el dato N:  ",0
error BYTE " ERROR: ",0
total BYTE "Suma total de la serie: ",0
ter1  BYTE "  Termino[",0
ter2  BYTE "]: ",0
adios BYTE "ADIOS.",0
termino SDWORD   0
resultado  SDWORD  0
cont    SDWORD 1
exp     SDWORD 1


.CODE
; Procedimiento principal
main PROC

    datoN:
    
        ; Se lee el número del teclado
         call CrLf
         mov EDX, OFFSET dato
         call WriteString
         call readInt  ; se guarda en EAX


         mov EBX,EAX
         CMP EAX,1
         JGE suma
         call CrLf
         mov EDX, OFFSET error
         call WriteString
         call writeInt
         jmp datoN

    suma:
        cmp cont, EBX
        JG  salida
        neg exp
        mov ECX, cont
        imul ECX,ECX
        imul ECX,exp
        add  ECX, termino
        add  resultado,ECX
        mov termino,ECX
        
        mov EDX, OFFSET ter1
        call WriteString
        mov EAX,cont
        call writeInt
        mov EDX, OFFSET ter2
        call WriteString
        mov EAX, termino
        call WriteInt
        call CrLf
        
        inc  cont
        jmp suma
        

    salida:
            mov EAX, resultado
            call CrLf
            mov EDX, OFFSET total
            call WriteString
            call WriteInt 
            call CrLf 
            mov EDX, OFFSET adios
            call WriteString


        
        exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main