.586
.MODEL  Flat,StdCall
OPTION  CaseMap:None 

INCLUDE File.inc

.data
    brandString BYTE 48 DUP(?)  ; Buffer to store the processor brand string

.code
ProcessorString PROC
    mov eax, 80000002h  ; Start of brand string
    cpuid

    ; Copy the processor brand string from registers to memory
    mov edi, OFFSET brandString
    mov [edi], eax
    mov [edi + 4], ebx
    mov [edi + 8], ecx
    mov [edi + 12], edx

    ; Repeat for additional parts of the brand string
    mov eax, 80000003h
    cpuid
    mov [edi + 16], eax
    mov [edi + 20], ebx
    mov [edi + 24], ecx
    mov [edi + 28], edx

    mov eax, 80000004h
    cpuid
    mov [edi + 32], eax
    mov [edi + 36], ebx
    mov [edi + 40], ecx
    mov [edi + 44], edx

    ; Print the processor brand string
    mov edx, OFFSET brandString
    call WriteString

  

    ; Move to the next line
    call Crlf

    ret
    
ProcessorString ENDP

END
