.386
.MODEL Flat, StdCall
OPTION CaseMap:None

INCLUDE File.inc

    INCLUDE C:/Irvine/Irvine32.inc
    INCLUDELIB C:/Irvine/Irvine32.lib
.data
    subStrlen DWORD ?
.code
findStr PROC,
string:PTR BYTE,
subString:PTR BYTE

    mov esi, string         ; ESI points to the string
    mov edi, subString         ; EDI points to the substring

    ; Check for empty string or substring
    cmp byte ptr [esi], 0   ; Check if the first byte of the string is null terminator
    je  Done

    cmp byte ptr [edi], 0   ; Check if the first byte of the substring is null terminator
    je  Done
    Invoke Str_length,string
    mov ecx,eax
    Invoke Str_length,subString
    mov subStrlen,eax
    mov eax, 0              ; Initialize a counter for matching characters

    @@FindNext:
        ; Load the current characters from string and substring
        mov bl, [esi + eax]
        mov bh, [edi + eax]

        ; Compare the characters
        cmp bl,bh
        jne @@Mismatch       ; Jump to Mismatch if characters are not equal

        ; Characters match, check for the end of the substring
        cmp bl, 0
        je  Done              ; Substring found, jump to Done

        inc eax
        jmp @@FindNext

    @@Mismatch:
        ; Characters do not match, reset the counter and move to the next character in the string
        cmp eax,subStrlen
        je Done
        mov eax, 0
        inc esi
        loop @@FindNext
    Done:
        add esi,eax

        add esi,2           ;moving to the next word

        loop1:
        mov al,[esi]
        cmp al,','
        je breakLoop
        cmp al,'}'
        je breakLoop
        cmp al,'"'
        je ignore

        call WriteChar
        ignore:
        inc esi
        loop loop1
        breakLoop:

    
    ret
findStr ENDP
END