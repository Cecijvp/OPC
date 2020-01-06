TITLE *MASM Template	(TareaCF2.asm)*

; Descripcion general:


; Librerias 
INCLUDE myirvine.inc


.DATA

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
x    REAL8 0.174532925
xAux REAL8 0.174532925

; variables para calcular el n termino de la sumatoria
suma REAL8 0.0


.CODE
; Procedimiento principal
main PROC

      

mov ECX, 1 
    .WHILE n < 10
   
        ; calcular alfa = 2n+1
        mov EAX, n
        mov EBX, 2
        mul EBX
        add EAX,1
        mov alfa, EAX  

        ; calcular x^alfa    
         
         
        .WHILE  ECX < alfa
            fld xAux
            fmul x
            fstp xAux
            inc ECX 
        .ENDW
        
       
         ;Ciclo para calcular el factorial 
         mov EBX, alfa
        .WHILE cont< EBX ; es hasta 21 porque es el factorial máximo que calcularemos si n=10
            fld fact
            fmul i
            fstp fact
            fld i
            fadd uno
            fstp i
            inc cont     
        .ENDW

         ;calcular -1^n
         mov EAX , imPar
         mov EBX, -1
         imul EBX
         mov imPar, EAX
         fild imPar ;convierte entero en float
         fstp res ;guardo en variable float
         

         ; calcular el termino de la sumatoria
         fld res ; cargo el -1^n a la pila
         fmul xAux
         fdiv fact
         fadd suma
         fstp suma
         inc n
    .ENDW

    fld suma
    call writeFloat
     

exit  
main ENDP
; Termina el procedimiento principal

END main
; Termina el área de Ensamble