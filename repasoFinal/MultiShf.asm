TITLE Multiple Doubleword Shift            (MultiShift.asm)

; Demonstration of multi-doubleword shift, using
; SHR and RCR instructions.

INCLUDE myIrvine.inc

ArraySize = 3

.DATA
array DWORD 12345678h, 9ABCDEF1h, 23456789h
before BYTE "Before",0 
after BYTE "After",0 

.CODE
main PROC
    ; BEFORE: display the array, HEXADECIMAL
    mov EDX, OFFSET before
    call WriteString
    call CrLf
    mov EAX, array+2*TYPE DWORD
    call WriteHex
    mov AL, '-'
    call WriteChar
    mov EAX, array+TYPE DWORD
    call WriteHex
    mov AL, '-'
    call WriteChar
    mov EAX, array
    call WriteHex
    mov AL, 'h'
    call WriteChar
    call CrLf

    ; BEFORE: display the array, BINARY
    mov EAX, array+2*TYPE DWORD
    call WriteBin
    mov AL, '-'
    call WriteChar
    mov EAX, array+TYPE DWORD
    call WriteBin
    mov AL, '-'
    call WriteChar
    mov EAX, array
    call WriteBin
    mov AL, 'b'
    call WriteChar
    call CrLf

    ; Shift the doublewords 1 bit to the right:
    mov ESI, 0
    shr array[ESI+2*TYPE DWORD], 1            ; highest dword
    rcr array[ESI+TYPE DWORD], 1              ; middle dword, include Carry flag
    rcr array[ESI],1     	                ; low dword, include Carry flag

    ; AFTER: display the array, HEXADECIMAL
    mov EDX, OFFSET after
    call WriteString
    call CrLf
    mov EAX, array+2*TYPE DWORD
    call WriteHex
    mov AL, '-'
    call WriteChar
    mov EAX, array+TYPE DWORD
    call WriteHex
    mov AL, '-'
    call WriteChar
    mov EAX, array
    call WriteHex
    mov AL, 'h'
    call WriteChar
    call CrLf

    ; AFTER: display the array, BINARY
    mov EAX, array+2*TYPE DWORD
    call WriteBin
    mov AL, '-'
    call WriteChar
    mov EAX, array+TYPE DWORD
    call WriteBin
    mov AL, '-'
    call WriteChar
    mov EAX, array
    call WriteBin
    mov AL, 'b'
    call WriteChar
    call CrLf

    EXIT
main ENDP

END main