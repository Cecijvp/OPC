TITLE TareaCF1						(TareaCF1.asm)

; FPU Stack TOP

INCLUDE myIrvine.inc
; INFIX = (2.0 + 3.0)/(-2.0) * 10.0 - 2.0 + 15.0
; POSTFIX = 2.0 3.0 + -2.0 / 10.0 * 2.0 - 15.0 +
.data
infix BYTE "(RA+SB)/TC*UD-RA+VE",0
posfi BYTE "0000000000000000", 0
RA     REAL8 2.0
SB     REAL8 3.0
TC     REAL8 -2.0
UD     REAL8 10.0
VE     REAL8 15.0

subCad BYTE "00",0
simb   BYTE '0',0
suma   BYTE '+',0
resta  BYTE '-',0
multi  BYTE '*',0
divi   BYTE '/',0
cont   BYTE 0  
msjInf BYTE "Infijo: ",0
msjPos BYTE "Posfijo: ",0
msjRes BYTE "Resultado: ",0
bye  BYTE "ADIOS",0

.code
main PROC

    mov EDX, OFFSET msjInf
    call writeString
    mov EDX, OFFSET infix
    call  WriteString
    call Crlf

    mov EBX,1
    mov ECX,0

    .WHILE cont<16
        mov AL, infix[EBX]
        .IF (AL==')') 
        .ELSEIF (AL!=suma) && (AL!=resta) && (AL!=multi) && (AL!=divi) && (AL!='(') && (AL!=')') 
            MOV posfi[ECX], AL
        .ELSEIF (AL==suma) && (cont==0)
            MOV simb, '+'
            DEC ECX
            INC cont
        .ELSEIF (AL==suma) && (cont==1)
            MOV AH, simb
            MOV posfi[ECX], AH
            MOV simb, '+'
        .ELSEIF (AL==resta) && (cont==0)
            MOV simb, '-'
            DEC ECX
            INC cont
        .ELSEIF (AL==resta) && (cont==1)
            MOV AH, simb
            MOV posfi[ECX], AH
            MOV simb, '-'
        .ELSEIF (AL==multi) && (cont==0)
            MOV simb, '*'
            DEC ECX
            INC cont
        .ELSEIF (AL==multi) && (cont==1)
            MOV AH, simb
            MOV posfi[ECX], AH
            MOV simb, '*'
        .ELSEIF (AL==divi) && (cont==0)
            MOV simb, '/'
            DEC ECX
            INC cont
        .ELSEIF (AL==divi) && (cont==1)
            DEC ECX
            MOV AH, simb
            MOV posfi[ECX], AH
            MOV simb, '/'
        .ENDIF
        INC ECX
        INC EBX
    .ENDW

    MOV AL, simb
    MOV posfi[ECX], AL

    call Crlf 
    MOV EDX, OFFSET msjPos
    call WriteString
    MOV EDX, OFFSET posfi
    call WriteString

    call evalua
    call Crlf
    MOV EDX, OFFSET bye
    call WriteString
    call Crlf
    
  EXIT
main ENDP

evalua PROC
    
    call Crlf 
    mov ECX,0
    .WHILE ECX<16
        MOV AL, posfi[ECX]
        .IF (AL!=suma) && (AL!=resta) && (AL!=multi) && (AL!=divi) 
            MOV subCad[ECX], AL
        .ELSEIF (AL==suma)
            FADD
        .ELSEIF (AL==resta)
            FSUB
        .ELSEIF (AL==multi)
            FMUL
        .ELSEIF (AL==divi)
            FDIV
        .ENDIF

        .IF AL=='R'
               fld RA
          .ELSEIF AL=='S'
                fld SB
            .ELSEIF AL=='T'
                fld TC
            .ELSEIF AL=='U'
                fld UD
             .ELSEIF AL=='V'
                fld VE
            .ENDIF
     INC ECX      
    .ENDW

call Crlf
mov EDX, OFFSET msjRes
call WriteString
call WriteFloat
call Crlf
call ShowFPUStack

RET
evalua ENDP
END main