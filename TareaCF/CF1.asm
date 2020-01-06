TITLE CF1						(CF1.asm)

; FPU Stack TOP

INCLUDE myIrvine.inc
; INFIX = (2.0 + 3.0)/(-2.0) * 10.0 - 2.0 + 15.0
; POSTFIX = 2.0 3.0 + -2.0 / 10.0 * 2.0 - 15.0 +
.data
RA  REAL8 2.0
SB  REAL8 3.0
TC  REAL8 -2.0
UD  REAL8 10.0
VE  REAL8 15.0
val REAL8 ?

res  BYTE "Resultado = ",0
bye  BYTE "ADIOS",0

.code
main PROC

    finit   ; starts up the FPU
    
    fld RA      ;push RA
    fld SB      ;push SB
    fadd        ;+ operand - ST(0) <- RA + SB
    fld TC      ;push TC
    fdiv        ;/ operand - ST(0) <- (RA + SB) / TC
    fld UD      ;push UD
    fmul        ;* operand - ST(0) <- (RA + SB) / TC * UD
    fld RA      ;push RA
    fsub        ;- operand - ST(0) <- (RA + SB) / TC * UD - RA
    fld VE      ;push VE
    fadd        ;+ operand - ST(0) <- (RA + SB) / TC * UD - RA + VE
    
    mov EDX, OFFSET res
    call WriteString
    call WriteFloat
    call Crlf
    fstp val
    call ShowFPUStack
    call Crlf
    mov EDX, OFFSET bye
    call WriteString
    EXIT
main ENDP

END main