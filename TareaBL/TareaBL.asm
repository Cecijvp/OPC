TITLE Program Template          (TareaBL.asm)

; Programa para calcular n salarios. 

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine


.DATA
; PROC main
datoN  BYTE "Teclea el dato n: ", 0
result BYTE "Resultado: ", 0
bye    BYTE "ADIOS", 0
total  DWORD ?

fila   BYTE 8
colum  BYTE 14
n      DWORD ?

; PROC salarios, variables locales
suma   DWORD 0
ret1   DWORD ?
dirN   DWORD ?
contS  DWORD ?
salPos DWORD ?

; PROC possal, variables locales
SalIn  BYTE "Teclee el ", 0
SalFin BYTE " salario: ", 0
salar  DWORD  ?
cont   DWORD  0
ret2   DWORD  ?
dirCont DWORD ?

.CODE
main PROC
    ;Limpia la ventana y pide el numero de salarios solicitados.
    ;Posiciona la ventana en las coordenadas dadas.
    call Clrscr     ;Limpia la ventana
    mov dh, fila ; posicion de la fila
    inc Fila
    mov dl,colum ; posicion de la columna
    call Gotoxy  
    mov EDX, OFFSET datoN ; se pide el dato
    call WriteString
    call ReadInt
    mov n, EAX

    push OFFSET n
    call salarios
    ;imrime el resultado de la suma
    pop total
    mov dh, Fila ; fila
    inc Fila
    mov dl, colum ; columna
    call Gotoxy
    mov EDX, OFFSET result
    call WriteString
    mov EAX,total
    call writeInt
    call CrLf
    
    mov dh, Fila ; fila
    inc Fila
    mov dl, colum ; columna
    call Gotoxy
    mov EDX, OFFSET bye
    call WriteString
    call CrLf
    EXIT
main ENDP

salarios PROC
;Se encarga de pedir los n salarios y sumarlos
; invoca al procedimiento Possal
; Recibe
;   Stack: dirección de n (dirN)
; Regresa
;   Stack: suma de todos los salarios


    pop ret1 ;direccion de retorno de call salarios
    
    ;se obtiene la direccion de n 
    pop dirN
    mov ESI, dirN
    
    mov EBX,cont
    .WHILE EBX < [ESI]
        mov contS, EBX
        push OFFSET contS
        call possal
        pop  salPos
        mov EAX, salPos
        add suma,EAX
        mov EBX, contS
        inc EBX
    .ENDW
        push suma
        push ret1
    RET
salarios ENDP

possal PROC
      ; Procedimiento para obtener los n salarios
      ; Recibe:
      ;   Stack: dirección del contador (dirCont)
      ; Regresa:
      ;   Stack: el valor del nuevo salario

        pop ret2
        pop dirCont 
        mov EDI, dirCont
        
        mov dh, Fila ; fila
        inc Fila
        mov dl, colum ; columna
        call Gotoxy
        mov EDX, OFFSET SalIn  
        call WriteString
        mov EAX, [EDI]
        inc EAX
        call WriteInt
        mov EDX, OFFSET SalFin 
        call WriteString
        call ReadInt
        mov salar, EAX
        push salar
        call CrLf
        push ret2
    RET
possal ENDP

END main