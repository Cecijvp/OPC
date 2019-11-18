TITLE Multiple Doubleword Shift            (MultiShift.asm)

; Descripción general:
; Programa que ejecuta una multiplicacion binaria dados dos numeros M y N

INCLUDE myIrvine.inc

.DATA

numero DWORD 4
msjM    BYTE "M: ", 0
msjN    BYTE "N: ", 0
msjProd BYTE "Producto: ", 0
msjPot  BYTE "Potencia de 2 ",0
msjPes  BYTE "peso ",0
bye     BYTE "ADIOS", 0
M DWORD 0
N DWORD 0
alfa DWORD 0
residuo DWORD 0
producto DWORD 0

.CODE
main PROC

    call Crlf
    MOV EDX, OFFSET msjM
    call WriteString
    call ReadInt
    MOV M, EAX
    MOV alfa, EAX

    call Crlf
    MOV EDX, OFFSET msjN
    call WriteString
    call ReadInt
    MOV N, EAX
    MOV residuo, EAX

    .IF EAX>M
        MOV EBX, M
        MOV M, EAX
        MOV alfa, EAX
        MOV N, EBX
        mov residuo, EBX
    .ENDIF
    
    call multiplicar
        
    EXIT
main ENDP

multiplicar PROC
calcula:
    
    MOV EAX, 1
    MOV CL, 0
    
    .IF residuo==1
        INC CL
        JMP evalua
    .ENDIF
    
    .WHILE EAX<=residuo
        INC CL
        MOV EAX, 1
        SHL EAX, CL
    .ENDW
    JMP evalua
    
evalua: 
    DEC CL
    MOV EAX, 0
    MOV AL, CL
    
    SHL alfa, CL
    MOV EAX, alfa 
    MOV EDX, alfa
    ADD producto, EDX
    MOV EBX, M
    MOV alfa, EBX

    MOV EBX, residuo
    MOV EAX, 1
    SHL EAX, CL
    SUB EBX, EAX
    MOV residuo, EBX
    
    .IF residuo==0
        JMP imprime
    .ELSE
        JMP calcula
    .ENDIF

imprime:

    call Crlf
    MOV EDX, OFFSET msjM
    call WriteString
    MOV EAX, M
    call WriteInt
    
    call Crlf
    MOV EDX, OFFSET msjN
    call WriteString
    MOV EAX, N
    call WriteInt
    
    call Crlf
    MOV EDX, OFFSET msjProd
    call WriteString
    MOV EAX, producto
    call WriteInt 

    call Crlf
    MOV EDX, OFFSET bye
    call WriteString
RET
multiplicar ENDP

END main