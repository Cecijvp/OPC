TITLE *MASM Template	(EjerciciosBG3.asm)*

; Descripcion:
; Se implementará la siguiente sumatoria
; calcular la multiplicación m*n sin utilizar multiplicación    

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
datoN  BYTE "Teclee el dato N:  ",0
def    BYTE "No definido",0
adios  BYTE "ADIOS.",0
par1   BYTE "(",0
par2   BYTE "!): ",0
N      SDWORD ?
aux    SDWORD 1
cont   SDWORD ?
res    SDWORD ?

.CODE
; Procedimiento principal
main PROC
    ; se piden los datos del teclado
    
      datos:
        call CrLf
        mov  EDX, OFFSET datoN
        call WriteString
        call readInt           ; se guarda en EAX
        mov N, EAX

        cmp N,0
        jl  negativo
        je  igual
        mov EAX, 1
        mov EBX,N
        mov cont, EBX
        jmp positivo

      negativo:
      
        call CrLf
        mov  EDX, OFFSET par1
        call WriteString
        mov EAX, N
        call WriteInt
        mov  EDX, OFFSET par2
        call WriteString
        mov  EDX, OFFSET def
        call WriteString
        jmp salida

        
      igual:
      
        call CrLf
        mov  EDX, OFFSET par1
        call WriteString
        mov EAX, N
        call WriteInt
        mov  EDX, OFFSET par2
        call WriteString
        mov EAX, 1
        call WriteInt
        jmp salida
        
        
      positivo: 
       
        cmp cont,0
        je  resultado
        mul aux
        dec cont
        inc aux
        jmp positivo 

      resultado: 
        mov res, EAX
        call CrLf
        mov  EDX, OFFSET par1
        call WriteString
        mov EAX, N
        call WriteInt
        mov  EDX, OFFSET par2
        call WriteString
        mov EAX, res
        call writeInt

     salida:
        call CrLf
        mov  EDX, OFFSET adios
        call WriteString


        exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main