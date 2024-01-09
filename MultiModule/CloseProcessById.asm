.386                ; Use 80386+ instruction set

.MODEL  Flat,StdCall
OPTION  CaseMap:None   
    include \masm32\include\windows.inc
    include \masm32\include\user32.inc
    include \masm32\include\kernel32.inc
        
    ;-------------------------------------------------
    ;              Linked Libraries
    ;-------------------------------------------------
    
    includelib \masm32\lib\user32.lib
    includelib \masm32\lib\kernel32.lib
INCLUDE File.inc


.data
processIDString BYTE 11 DUP (?) 
processID DWORD ?
processHandle DWORD ?
exitCode DWORD ?
msg BYTE "Process Closed", 0
errorMsg BYTE "Error", 0
promptMsg BYTE "Enter Process ID: ", 0
.code
CloseProcessById PROC
mov edx, offset promptMsg
call WriteString
mov edx, OFFSET processIDString
    mov ecx, SIZEOF processIDString
    call ReadString

    mov edx, OFFSET processIDString
    call atodw
    mov processID, eax
    ; Replace 15956 with the actual process ID you want to terminate
    ;mov processID, 9504

    ; Call OpenProcess to open the process
    invoke OpenProcess, PROCESS_TERMINATE, FALSE, processID
    mov processHandle, eax ; Store the process handle

    ; Check if OpenProcess succeeded
    .if processHandle == NULL
        ; Handle the error (check GetLastError for more information)
        invoke GetLastError
        mov edx, offset errorMsg
        call WriteString
        
    .else
        ; Call TerminateProcess to terminate the process
        
        invoke TerminateProcess, processHandle, exitCode

        ; Close the process handle
        invoke CloseHandle, processHandle
     
        mov edx, offset msg
        call WriteString

    .endif

    ; Exit the program
    ret
CloseProcessById ENDP

atodw PROC
    xor eax, eax
    mov ecx, 10  ; Set the divisor for decimal conversion

convert_loop:
    movzx ebx, byte ptr [edx] ; Load the next character from the string
    cmp ebx, 0 ; Check for null terminator
    je  convert_done ; If null terminator, exit the loop

    sub ebx, '0' ; Convert ASCII character to integer ('0' -> 0, '1' -> 1, ..., '9' -> 9)
    imul eax, 10 ; Multiply the current result by 10
    add eax, ebx ; Add the current digit to the result

    inc edx ; Move to the next character in the string
    loop convert_loop ; Repeat the loop

convert_done:
    ret
atodw ENDP
END
