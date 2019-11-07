TITLE *MASM Template	(TareaBJ.asm)*

; Descripcion:
; Guardar temperaturas en un arreglo, calcular e imprimir
; la menor temperatura  y su posición
; imprimir el arreglo en orden inverso 

INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib

.DATA
dato      BYTE   "Dato n:  ",0
error     BYTE   "ERROR por n<1 o n>10",0
bye       BYTE   "ADIOS.",0
msjT      BYTE   "Teclee la ",0
msjT2     BYTE   " temperatura: ",0
msjT3     BYTE   "Temperatura ",0
punto     BYTE   " : ",0
tempMin   BYTE   "Minimo de las temperaturas: ",0 
posMin    BYTE   "Posicion temperatura minima: ",0
cambMsj    BYTE   "Total de cambios: ",0
par       BYTE   " P",0
impar     BYTE   " I",0
n         DWORD   ?
cont      DWORD   0
min       SDWORD  100
aux       SDWORD   ?
limite    SDWORD   ?
indiceMin SDWORD   ?
dividir   SDWORD    2
temps     SDWORD  10 DUP(?) ; como n puede llegar hasta 10 el arreglo lo rellene de ? 10 veces.
cambios      DWORD  0
ind1      DWORD  0
ind2      DWORD  1
.CODE
; Procedimiento principal
main PROC

    lecturaN: 
       
         ; se lee el # del teclado 
         call CrLf
         mov EDX, OFFSET dato
         call WriteString
         call readInt  ; se guarda en EAX
         call CrLf
         mov n, EAX

        ; se checa si cumple con el rango.
        .IF n<1 || n>10
             call CrLf
             mov EDX, OFFSET error
             call WriteString
             jmp salida
        .ENDIF     

    Temperaturas:
    
          ; lectura de temperaturas.
          mov EBX,0
          mov ESI, OFFSET temps
         .WHILE EBX<n
                mov edx,OFFSET msjT
	          call WriteString
                mov EAX, EBX
                inc EAX
                call WriteInt
                mov edx,OFFSET msjT2
	          call WriteString
                call ReadInt 
                mov [ESI], EAX
                inc EBX
                add ESI, TYPE temps    
         .ENDW
                
                
      EncuentraMin:
      
          ;Dirección de la ultima temperatura
           sub ESI, TYPE temps      
                
          ;encontrar la temperatura minima
          mov EBX,1
          mov EDI, OFFSET temps
         .WHILE EBX < n
             mov ECX, [EDI]
             .IF ECX < min
                mov min, ECX
                mov indiceMin,EBX
             .ENDIF
             add EDI, TYPE temps 
             inc EBX   
         .ENDW
         
    ImprimeMin:
    
         ; imprimir temperatura minima y posición
            call CrLf
            mov edx,OFFSET tempMin
	      call WriteString
            mov EAX, min
            call writeInt
            call CrLf
            mov edx,OFFSET posMin
	      call WriteString
            mov EAX, indiceMin
            call WriteInt
            call CrLf

    ordenar:
        mov ESI, OFFSET temps
        mov EDI, OFFSET temps
        add EDI, TYPE temps
        mov EBX,ind1
        
        .WHILE EBX< (n-1) 
              mov ECX, ind2
             .WHILE  ECX < n
                mov EAX, [ESI]
                mov EDX, [EDI]
                .IF EAX>EDX
                    xchg EAX,EDX
                    mov [ESI], EAX
                    mov [EDI], EDX
                    inc cambios
                .ENDIF
                inc ECX
                add EDI,TYPE temps
             .ENDW
                inc EBX
                add ESI, TYPE temps
                mov EDI,ESI
                add EDI, TYPE temps
                inc ind2
        .ENDW

          mov ESI, OFFSET temps
          mov EBX,0  
         .WHILE EBX< n
             mov EAX, [ESI]
             call writeInt
             add ESI, TYPE temps
             call Crlf
             inc EBX
         .ENDW
         call Crlf
         mov EDX, OFFSET cambMsj
         call writeString
         mov EAX,cambios
         call writeInt
         call Crlf

           
    salida:
            call CrLf
            call CrLf
            mov EDX, OFFSET bye
            call WriteString
        
    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main