.386
.MODEL Flat, StdCall
OPTION CaseMap:None

INCLUDE \masm32\include\windows.inc
INCLUDE \masm32\include\kernel32.inc

includelib \masm32\lib\kernel32.lib

INCLUDE File.inc

.data
    message db 'Total Physical Memory: ', 0
    availableMemory db 'Available Physical Memory: ', 0
    availableVirtual db 'Available Virtual Memory: ', 0
    totalVirtual db 'Total Virtual Memory: ', 0
    phyMemoryBar1 db ".______    __    __  ____    ____  _______. __    ______     ___       __         .___  ___.  _______ .___  ___.   ______   .______     ____    ____", 0
    phyMemoryBar2 db "|   _  \  |  |  |  | \   \  /   / /       ||  |  /      |   /   \     |  |        |   \/   | |   ____||   \/   |  /  __  \  |   _  \    \   \  /   / ", 0
    phyMemoryBar3 db "|  |_)  | |  |__|  |  \   \/   / |   (----`|  | |  ,----'  /  ^  \    |  |        |  \  /  | |  |__   |  \  /  | |  |  |  | |  |_)  |    \   \/   /  ", 0
    phyMemoryBar4 db "|   ___/  |   __   |   \_    _/   \   \    |  | |  |      /  /_\  \   |  |        |  |\/|  | |   __|  |  |\/|  | |  |  |  | |      /      \_    _/   ", 0
    phyMemoryBar5 db "|  |      |  |  |  |     |  | .----)   |   |  | |  `----./  _____  \  |  `----.   |  |  |  | |  |____ |  |  |  | |  `--'  | |  |\  \----.   |  |     ", 0
    phyMemoryBar6 db "| _|      |__|  |__|     |__| |_______/    |__|  \______/__/     \__\ |_______|   |__|  |__| |_______||__|  |__|  \______/  | _| `._____|   |__|     ", 0


    virtualMemoryBar1 db "____    ____  __  .______     .___________. __    __       ___       __         .___  ___.  _______ .___  ___.   ______   .______     ____    ____", 0
    virtualMemoryBar2 db "\   \  /   / |  | |   _  \    |           ||  |  |  |     /   \     |  |        |   \/   | |   ____||   \/   |  /  __  \  |   _  \    \   \  /   / ", 0
    virtualMemoryBar3 db " \   \/   /  |  | |  |_)  |   `---|  |----`|  |  |  |    /  ^  \    |  |        |  \  /  | |  |__   |  \  /  | |  |  |  | |  |_)  |    \   \/   /  ", 0
    virtualMemoryBar4 db "  \      /   |  | |      /        |  |     |  |  |  |   /  /_\  \   |  |        |  |\/|  | |   __|  |  |\/|  | |  |  |  | |      /      \_    _/   ", 0
    virtualMemoryBar5 db "   \    /    |  | |  |\  \----.   |  |     |  `--'  |  /  _____  \  |  `----.   |  |  |  | |  |____ |  |  |  | |  `--'  | |  |\  \----.   |  |     ", 0
    virtualMemoryBar6 db "    \__/     |__| | _| `._____|   |__|      \______/  /__/     \__\ |_______|   |__|  |__| |_______||__|  |__|  \______/  | _| `._____|   |__|     ", 0



    gbMsg db " GB", 0
    percentage db "%", 0
    memoryUsageMsg db 'Total Memory Usage: ', 0

    mb db ' MB', 0
    error_message db 'Error: Unable to get memory information!', 0
    buffer db 16 dup(?)  ; Allocate space for the decimal or float string
     memoryStatusEx MEMORYSTATUSEX <>

.code
RamInfo PROC
    mov edx, offset phyMemoryBar1
    call WriteString
    call Crlf

    mov edx, offset phyMemoryBar2
    call WriteString
    call Crlf

    mov edx, offset phyMemoryBar3
    call WriteString
    call Crlf

    mov edx, offset phyMemoryBar4
    call WriteString
    call Crlf

    mov edx, offset phyMemoryBar5
    call WriteString
    call Crlf

    mov edx, offset phyMemoryBar6
    call WriteString
    call Crlf
    call Crlf
    call Crlf
    call Crlf

    ; Initialize the MEMORYSTATUSEX structure
    mov memoryStatusEx.dwLength, SIZEOF MEMORYSTATUSEX


    ; Call the MemoryStatusEx function
    invoke GlobalMemoryStatusEx, ADDR memoryStatusEx

  
    
; Display the total physical memory in gigabytes

    mov edx, offset message
    call WriteString
mov eax, dword ptr memoryStatusEx.ullTotalPhys
mov edx, dword ptr [memoryStatusEx.ullTotalPhys + 4] ; High-order DWORD

mov ecx, 1024 * 1024 * 1024
mov ebx, 0  ; Clear ebx to prevent division error
div ecx

; eax now contains the total physical memory in gigabytes
call WriteDec
mov edx, offset gbMsg
call WriteString

call Crlf

; Display the available physical memory in gigabytes

    mov edx, offset availableMemory
    call WriteString
mov eax, dword ptr memoryStatusEx.ullAvailPhys
mov edx, dword ptr [memoryStatusEx.ullAvailPhys + 4] ; High-order DWORD

mov ecx, 1024 * 1024 * 1024
mov ebx, 0  ; Clear ebx to prevent division error
div ecx

; eax now contains the total physical memory in gigabytes
call WriteDec
mov edx, offset gbMsg
call WriteString

call Crlf



  mov edx, offset memoryUsageMsg
    call WriteString
    
; Finding total Memory Usage
mov eax, dword ptr memoryStatusEx.dwMemoryLoad
mov edx, dword ptr [memoryStatusEx.dwMemoryLoad + 4] ; High-order DWORD

mov ebx, 0  ; Clear ebx to prevent division error


; eax now contains the total physical memory in gigabytes
call WriteDec


mov edx, offset percentage
call WriteString
call Crlf


 mov edx, offset virtualMemoryBar1
    call WriteString
    call Crlf


     mov edx, offset virtualMemoryBar2
    call WriteString
    call Crlf

     mov edx, offset virtualMemoryBar3
    call WriteString
    call Crlf


     mov edx, offset virtualMemoryBar4
    call WriteString
    call Crlf

     mov edx, offset virtualMemoryBar5
    call WriteString
    call Crlf

     mov edx, offset virtualMemoryBar6
    call WriteString
   

       call Crlf
    call Crlf
    call Crlf
    call Crlf


  mov edx, offset totalVirtual
    call WriteString

mov eax, dword ptr memoryStatusEx.ullTotalVirtual
mov edx, dword ptr [memoryStatusEx.ullTotalVirtual + 4] ; High-order DWORD

mov ebx, 0  ; Clear ebx to prevent division error

mov ecx, 1024 * 1024 * 1024
mov ebx, 0  ; Clear ebx to prevent division error
div ecx


call WriteDec


mov edx, offset gbMsg
call WriteString
call Crlf

  mov edx, offset availableVirtual
    call WriteString

mov eax, dword ptr memoryStatusEx.ullAvailVirtual
mov edx, dword ptr [memoryStatusEx.ullAvailVirtual + 4] ; High-order DWORD

mov ebx, 0  ; Clear ebx to prevent division error

mov ecx, 1024 * 1024 * 1024
mov ebx, 0  ; Clear ebx to prevent division error
div ecx

; eax now contains the total physical memory in gigabytes
call WriteDec


mov edx, offset gbMsg
call WriteString
call Crlf



    ; Exit program
    call WaitMsg
    ret

RamInfo ENDP

END