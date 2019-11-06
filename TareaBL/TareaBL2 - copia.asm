TITLE Program Template          (TareaBL2.asm)

; Programa para calcular n salarios. 

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine


.DATA
; PROC main



; PROC leerStr, variables locales
    cad     BYTE "Ingrese una cadena de caracteres: ",0
    cade    DWORD 0     ;tam de la cadena
    cadS    BYTE "String: ",0
    buffCad BYTE 100 DUP('?')


; PROC analisis, variables locales
    cont    DWORD 1
    limMI    BYTE  01000000b
    limMS    BYTE  01011001b 
    limI     BYTE  01100000b 
    limS     BYTE  01111001b
    mayu     BYTE " MAYUSCULA",0
    min      BYTE " minuscula",0
    noC      BYTE " Char no alfa",0
    caract   BYTE "Caracter",0
    punto   BYTE ": " ,0
    bye     BYTE "ADIOS",0

; PROC convertir, variables locales
    buffConv BYTE 100 DUP('?')
    conv    BYTE "Conversion: ",0
.CODE
main PROC
    call leerStr
    EXIT
main ENDP

leerStr PROC
    mov EDX, OFFSET cad
    call writeString
    mov EDX, OFFSET buffCad
    mov ECX, 100
    call readString
    mov cade, EAX
    mov CL, buffCad
    mov buffConv, CL
    call Crlf

    mov EDX, OFFSET cadS
    call writeString
    mov EDX, OFFSET buffCad
    call writeString 
    call Crlf
leerStr ENDP

analisis PROC
    mov ESI, OFFSET buffCad
    mov EBX,0
    .WHILE EBX < cade
        mov EDX, OFFSET caract
        call writeString
        mov EAX, cont
        call writeInt
        mov EDX, OFFSET punto
        call writeString
        mov AL, [ESI]
        call writeChar
        mov EDX, OFFSET noC
        
        .IF (AL>limI) && (AL<limS)
            mov EDX, OFFSET min
        .ELSEIF (AL> limMI) && (AL< limMS)
            mov EDX, OFFSET mayu            
        .ENDIF
        
        call writeString
        call Crlf
        inc ESI
        inc EBX
        inc cont
    .ENDW
    
analisis ENDP

convertir PROC
    mov EDI, OFFSET buffCad
    mov EBX,0
    
    .WHILE EBX< cade
        mov AL,[EDI]
        .IF (AL>limI) && (AL<limS)
            and AL, 11011111b
             mov [EDI], AL
        .ELSEIF (AL> limMI) && (AL< limMS)
             or AL, 00100000b
             mov [EDI], AL
             
        .ENDIF
        inc EBX
        inc EDI   
    .ENDW
    mov EDX, OFFSET conv
    call WriteString
    mov EDX, OFFSET buffCad
    call writeString 
    call Crlf
    mov EDX, OFFSET bye
    call writeString


convertir ENDP

END main