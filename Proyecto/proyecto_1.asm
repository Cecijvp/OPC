TITLE Proyecto

INCLUDE myIrvine.inc

.DATA
welcome     BYTE    "Bienvenido!", 0
bye         BYTE    "Adios!", 0
invalido    BYTE    "Opcion no valida.", 0
datoX       BYTE    "Ingrese el valor de x: ", 0
opcion      DWORD   ?
xDataRad    REAL8   ?
xDataDeg    REAL8   ?
constant    REAL8   180.0

; Datos de impresion
opciones    BYTE    "Opciones disponibles:", 0
menuOP1     BYTE    "1. sen(x) con x en grados.", 0
menuOP2     BYTE    "2. sen(x) con x en radianes.", 0
menuOP3     BYTE    "3. Tabla de sen(x) dado x", 0
menuOP4     BYTE    "4. Salir.", 0
seleccion   BYTE    "Selecciona una opcion: ", 0
calculoFin  BYTE    "Valor del sen(x): ",0


; Variables de procedimientos
dirRet      DWORD   ?
dirRet1     DWORD   ?
dirRet2     DWORD   ?
dirRet3    DWORD   ?

; variables para calcular el factorial
fact REAL8 1.0
i    REAL8 1.0
uno  REAL8 1.0
cont DWORD 0

;variables para calcular -1^n
n    DWORD 0
imPar SDWORD -1 
res   REAL8 ?

;variables para calcular 2n+1
n2   REAL8 1.0
alfa SDWORD ?
two  REAL8 2.0

;variables para calcular x^2n+1
exp  SDWORD ?
x    REAL8 ?
xAux REAL8 ?

; variables para calcular el n termino de la sumatoria
suma REAL8 0.0

;Variables para convertir a radianes
conver REAL8 180.0


;Variables de impresión tabla
grados      BYTE "| Grados |",0
radianes    BYTE " Radianes |",0
seno        BYTE " Seno |",0
barra       BYTE "| ",0
barra2      BYTE " |",0
xTabla      REAL8 ?
ten         REAL8 10.0
grad        SDWORD 0
cero        REAL8 0.0

.CODE
; Procedimiento principal
main PROC
    mov EDX, OFFSET welcome
    call WriteString
    call Crlf
    call Crlf

    menu:
        call imprimeMenu
        call ReadInt
        mov opcion, EAX
        call Crlf
        
    .IF opcion < 1 || opcion > 4
        mov EDX, OFFSET invalido
        call WriteString
        call Crlf
        jmp menu
    .ELSEIF opcion == 4
        jmp opcion4
    .ELSE
        finit
      
        

        .IF opcion == 1
            mov EDX, OFFSET datoX
            call WriteString
            call ReadFloat
            fstp xDataDeg
            jmp opcion1
            
        .ELSEIF opcion == 2
            mov EDX, OFFSET datoX
            call WriteString
            call ReadFloat
            fstp xDataRad
            jmp opcion2
            
        .ELSEIF opcion == 3
            jmp opcion3
        .ENDIF
    .ENDIF

    opcion1:
        
        ;conversión de grados a radianes
        fldpi
        fmul xDataDeg
        fdiv conver
        fst x
        fstp xAux
        
        mov n, 0
        ;llamado  a la función para calcular el seno
        call calculoSeno
        fld suma
        mov EDX, OFFSET calculoFin
        call writeString
        call writeFloat
        call Crlf
        fldz
        fmul suma
        fstp suma
        
        fldz
        fmul x
        fstp x
        
        fldz
        fmul xAux
        fstp xAux
        
        jmp menu
            
    opcion2:

        call calculoSeno
        fld suma
        mov EDX, OFFSET calculoFin
        call writeString
        call writeFloat
        call Crlf
        jmp menu

    opcion3:

         mov EDX, OFFSET grados
         call writeString
         mov EDX, OFFSET radianes
         call writeString
         mov EDX, OFFSET seno
         call writeString
         call crlf
         
         mov EBX,0
        .WHILE EBX<39
            
            
            mov EDX, OFFSET barra
            call writeString
            
            mov EAX, grad
            call writeInt
            
            mov EDX, OFFSET barra2
            call writeString

            fild grad
            fstp xTabla
            fldpi
            fmul xTabla
            fdiv conver
            call writeFloat
            fst x
            fstp xAux  
     
            
            mov EDX, OFFSET barra
            call writeString

            ;llamado  a la función para calcular el seno
        
            call calculoSeno
            fld suma
            call writeFloat
            
            
            mov EDX, OFFSET barra2
            call writeString
            call crlf
            
            add grad,10
            mov n, 0
            inc EBX
            
        .ENDW
        jmp menu

    opcion4:
        call Crlf
        mov EDX, OFFSET bye
        call WriteString
    exit
main ENDP
; Termina el procedimiento principal

; Recibe: nada
; Regresa: nada
imprimeMenu PROC
    mov EDX, OFFSET opciones
    call WriteString
    call Crlf
    call Crlf
    mov EDX, OFFSET menuOP1
    call WriteString
    call Crlf
    mov EDX, OFFSET menuOP2
    call WriteString
    call Crlf
    mov EDX, OFFSET menuOP3
    call WriteString
    call Crlf
    mov EDX, OFFSET menuOP4
    call WriteString
    call Crlf
    mov EDX, OFFSET seleccion
    call WriteString
    ret
imprimeMenu ENDP

;procedimiento para calcular el seno
; no recibe nada
; devuelve la aproximación del sen(x)
calculoSeno PROC

     pop dirRet
     
     mov ECX,1
     finit
    .WHILE n < 10


        ;calcular -1^n
         call calculoSigno
         
            
        ; calcular alfa = 2n+1
        mov EAX, n
        mov EBX, 2
        mul EBX
        add EAX,1
        mov alfa, EAX  

        .WHILE ECX<alfa
        
            call calculoExp
            inc ECX
        .ENDW

        ;Ciclo para calcular el factorial 
        mov EBX, alfa
        .WHILE cont < EBX

             call calculoFactorial
             inc cont
        .ENDW

         ; calcular el termino de la sumatoria
         fld res ; cargo el -1^n a la pila
         fmul xAux ; multiplica el signo por x^2n+1
         fdiv fact  ; divide el resultado ant por el factorial
         fadd suma  ; lo agrega a la suma
         fstp suma  ; guarda el valor de la suma
 
         inc n 
         
           
                  
    .ENDW
     finit
     mov cont, 0
     push dirRet
     RET
calculoSeno ENDP

calculoFactorial PROC

    pop dirRet1
    
    fld fact
    fmul i
    fstp fact
    fld i
    fadd uno
    fstp i

    push dirRet1
    RET
calculoFactorial ENDP



calculoSigno PROC
    pop dirRet2
    mov EAX , imPar
    mov EBX, -1
    imul EBX
    mov imPar, EAX
    fild imPar ;convierte entero en float
    fstp res ;guardo en variable float
    push dirRet2
    RET
calculoSigno ENDP

calculoExp PROC

   pop dirRet3

   fld xAux
   fmul x
   fstp xAux
   push dirRet3
   RET
calculoExp ENDP

; Termina el area de Ensamble
END main