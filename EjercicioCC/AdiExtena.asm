; Ejemplo de Adicion Extendida           (AdiExtena.asm)

; Este programa calcula la suma de dos enteros de 9 bytes.
; Estos enteros estan almacenados como arreglos ("op1" y "op2"),
; con el byte menos significativo almacenado en la direccion mas baja.
; El resultado quedara en el arreglo "suma". 

INCLUDE myIrvine.inc

.DATA
op1 BYTE 20h,34h,12h,98h,74h,06h,0A4h,0B2h,0A2h
op2 BYTE 30h,02h,45h,23h,00h,00h,87h,10h,80h

suma BYTE 10 dup(0) 	; = 01 22 C3 2B 06 74 BB 57 36 50h
; El almacenamiento para esta variable "suma" debe ser de un
; byte mas largo que el de los operandos "op1" y "op2"
n       DWORD 0
aux     DWORD 0
dirRet  DWORD ?
sum     BYTE "Suma: ",0
.code
main PROC

; Calcula la adicion extendida
      
      push OFFSET op1
      push OFFSET op2
      push OFFSET suma
	call	AdicionExtendida

; Despliega la suma.
      push OFFSET suma
	call	DespliegaSuma
	call Crlf
	
	exit
main ENDP

;--------------------------------------------------------
AdicionExtendida PROC
; DESCRIPCION:
;   Calcula la suma de dos entero extendidos almacenados como arreglos de bytes.
; RECIBE:
; Por medio del stack,
;   los apuntadores a los dos enteros, colocandolos en ESI y EDI;
;   el numero de bytes a ser sumados se guardara en ECX;
;   el apuntador a la variable que guardara la suma, en EBX.
; REGRESA:
;   Nada.
;--------------------------------------------------------
      pop dirRet
      pop EBX   ;suma
      pop EDI   ;op2
      pop ESI   ;op1
      mov ECX, SIZEOF op1 ; #bytes a ser sumados.
      mov EDX,0 ;parte superior suma
      .WHILE n < ECX
            mov AL, [ESI]
            add AL, [EDI]
            adc EDX, 0
            inc ESI
            .IF CARRY? 
                mov AL, [ESI]               
                add AL, DL
            .ENDIF
            mov [EBX], EAX 
            inc EDI
            inc EBX
            inc n
      .ENDW
      mov [EBX],EDX
      mov AL, [EBX]
      push dirRet
	ret
AdicionExtendida ENDP

;-----------------------------------------------------------
DespliegaSuma PROC
; DESCRIPCION:
;   Despliega un entero largo que esta almacenado en orden
;   little endian (LSB to MSB).
;   La salida despliega el arreglo, con el resultado, en
;   hexadecimal, empezando con el MSB.
; RECIBE:
;   Por medio del stack,
;   el apuntador al arreglo con el resultado, en ESI;
;   el numero de bytes del arreglo, en ECX
; REGRESA:
;   Nada.
;-----------------------------------------------------------
      pop dirRet
      pop ESI ; EBX -> dir de suma

 
      mov ECX, SIZEOF suma
      sub ECX,1
      add ESI, ECX
      inc ECX
      mov EDX, OFFSET sum
      call writeString
      mov EBX,1
      .WHILE aux < ECX
         mov AL, [ESI]
         call writeHexB
         dec ESI
         inc aux
      .ENDW
      push dirRet     
	ret
DespliegaSuma ENDP


END main