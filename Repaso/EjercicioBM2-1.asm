TITLE *MASM Template	(EjercicioBM2-1.asm)*

; Descripcion:
; Guardar temperaturas en un arreglo, calcular e imprimir
; la menor temperatura  y su posición
; imprimir el arreglo en orden inverso 

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
texto BYTE "El coronel no tiene"
      BYTE " quien le escriba."
      BYTE  0
msjTxt BYTE "Texto: ",0
msjLong BYTE " Longitud: ",0
conul BYTE "enur"  ; caracteres a contabilizar
acont DWORD 4 DUP(?) ; total de cada carácter
msjCar BYTE "Caracter",0
msjCant BYTE "Cantidad",0
m     DWORD 0
dirRet DWORD ?
dirRet2 DWORD ?
tam     DWORD ?
tamCuenta DWORD ?    
cont DWORD 0
aux DWORD 0
impAc   DWORD ?
fila   BYTE 40
colum  BYTE 38
colum1  BYTE 50


.CODE
; Procedimiento principal
main PROC

    push OFFSET texto
    
    
    call totCar

            
main ENDP
    

totCar PROC

    pop dirRet
    pop ESI
    mov AL, [ESI]
    .WHILE AL != 0
        inc m
        inc ESI
        mov AL, [ESI]
    .ENDW
    push m
totCar ENDP

impCad PROC
    ; Se recibe el tam de la cadena como parametro

    pop tam 
    mov EDI, OFFSET texto

    mov AL, [EDI]
    mov ECX,0
    mov EDX, OFFSET msjTxt
    call writeString 
    .WHILE ECX <= tam
        call writeChar
        inc ECX
        inc EDI 
        mov AL,[EDI]    
    .ENDW
    mov EDX, OFFSET msjLong
    call writeString
    mov EAX, tam
    call writeInt
    push tam

impCad ENDP

cuenta PROC
    pop tamCuenta
    mov ESI, OFFSET texto
    mov EDI, OFFSET conul
    mov EBP, OFFSET acont
    mov EAX,0
    mov EBX,0
    mov AL,[ESI]
    mov BL,[EDI] 
    mov ECX,0
    .WHILE cont<= 4 
            mov EDX, 0
        .WHILE EDX <= tamCuenta
             .IF AL==BL
                inc ECX
             .ENDIF
             inc EDX
             inc ESI
             mov AL,[ESI]
        .ENDW
        mov [EBP], ECX
        add EBP, TYPE acont
        inc EDI
        mov BL, [EDI]
        inc cont
    .ENDW

    push EBP
cuenta ENDP

impTot PROC
    pop EDI ; cont conul
    mov ESI, OFFSET conul
    mov AL, [ESI]
    

    call Clrscr     ;Limpia la ventana
    mov dh, fila ; posicion de la fila
    mov dl,colum ; posicion de la columna
    call Gotoxy  
    mov EDX, OFFSET msjCar 
    call WriteString
    
    mov dh, fila ; posicion de la fila
    inc Fila
    mov dl,colum1 ; posicion de la columna
    call Gotoxy  
    mov EDX, OFFSET msjCant
    call WriteString

    mov EBX,0
    .WHILE EBX < 4
        mov dh, fila ; posicion de la fila
        mov dl,colum ; posicion de la columna
        call Gotoxy  
        
        call writeChar

        mov dh, fila ; posicion de la fila
        inc Fila
        mov dl,colum1 ; posicion de la columna
        call Gotoxy  
        mov EAX, [EDI]
        call WriteInt

        inc ESI
        mov AL, [ESI]
        inc EDI
        inc EBX   

    .ENDW

    
        
  RET
impTot ENDP

; Termina el procedimiento principal
END main
; Termina el area de Ensamble