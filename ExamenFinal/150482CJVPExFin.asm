TITLE ExamenFinal						(150482CJVPExFin.asm)

;Convierte y despliega en ASCII (0's y 1's) el contenido binario de la representación 
;de un numero real 

INCLUDE myIrvine.inc

.data

seis4real REAL4 -14.0,23.0,-61.0,120.0
msjSoy    BYTE "Soy CJVP 150482",0
msjReal   BYTE "REAL",0
msjSigno  BYTE "SIGN: ",0
msjExp    BYTE "EXPONENTE: ",0
msjFrac   BYTE "FRACCION: ",0
bye       BYTE "ADIOS!.",0    

dirRet    DWORD ?
buffer2   BYTE ?,0
buffer    BYTE 8 DUP (?),0
buffer1   BYTE 23 DUP (?),0



.code
main PROC

    mov EDX, OFFSET msjSoy
    call writeString
    call Crlf
    call Crlf
    
    mov EBX,0
    .WHILE EBX <= LENGTHOF seis4real
        PUSH DWORD PTR seis4real[EBX * TYPE seis4real]
        call conversionABin
        inc EBX
    .ENDW
    
    call Crlf
    mov EDX, OFFSET bye
    call writeString
    call Crlf
EXIT
main ENDP

conversionABin PROC

    pop dirRet
    pop EAX
 signo:
 
    mov ECX, 0          ; counter
    mov EDX, 1		; number of bits in EAX
    mov ESI, offset buffer2
    

    .WHILE (ECX < EDX )
        MOV BYTE PTR [ESI], '0'     ; choose char 0 as default digit;
        SHL EAX, 1          ; shift high bit into Carry flag
        .IF ( CARRY? )
            MOV BYTE PTR [ESI], '1'     ; else move char 1 to buffer
        .ENDIF
        inc ESI     ; next buffer position
        inc ECX     ; shift another bit to left
    .ENDW       
     call Crlf
    mov EDX, OFFSET msjReal 
    call WriteString
    call Crlf
    mov EDX, OFFSET  msjSigno
    call WriteString
    mov EDX, OFFSET buffer2
    call WriteString
    call Crlf

 exponente:
   
    mov EDX, 9
    mov ESI, offset buffer

    .WHILE (ECX < EDX )
        mov BYTE PTR [ESI], '0'     ; choose char 0 as default digit;
        shl EAX, 1          ; shift high bit into Carry flag
        .IF ( CARRY? )
            mov BYTE PTR [ESI], '1'     ; else move char 1 to buffer
        .ENDIF
        inc ESI     ; next buffer position
        inc ECX     ; shift another bit to left
    .ENDW 

    mov EDX, OFFSET  msjExp
    call WriteString
    mov EDX, OFFSET buffer
    call WriteString
    call Crlf
    
mantissa:

    mov EDX, 32
    mov ESI, offset buffer1

    .WHILE (ECX < EDX )
        mov BYTE PTR [ESI], '0'     ; choose char 0 as default digit;
        shl EAX, 1          ; shift high bit into Carry flag
        .IF ( CARRY? )
            mov BYTE PTR [ESI], '1'     ; else move char 1 to buffer
        .ENDIF
        inc ESI     ; next buffer position
        inc ECX     ; shift another bit to left
    .ENDW 

    MOV EDX, OFFSET  msjFrac
    CALL WriteString
    mov EDX, OFFSET buffer1
    call WriteString
    call Crlf
    push dirRet
    RET
conversionABin ENDP


END main