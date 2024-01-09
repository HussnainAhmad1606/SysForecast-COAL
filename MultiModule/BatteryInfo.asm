.386
.MODEL Flat, StdCall
OPTION CaseMap:None

INCLUDE \masm32\include\windows.inc
INCLUDE \masm32\include\kernel32.inc
includelib \masm32\lib\kernel32.lib
INCLUDE File.inc
.data
    batteryStatus SYSTEM_POWER_STATUS <>
    batteryText db "Battery Remaining: ", 0
    chargingText db "Charging Status: ", 0
    timeLeftText db "Battery Time Left: ", 0
    minutesText db " Minutes", 0

    batteryBar1 db ".______        ___   .___________..___________. _______ .______     ____    ____", 0
    batteryBar2 db "|   _  \      /   \  |           ||           ||   ____||   _  \    \   \  /   /", 0
    batteryBar3 db "|  |_)  |    /  ^  \ `---|  |----``---|  |----`|  |__   |  |_)  |    \   \/   / ", 0
    batteryBar4 db "|   _  <    /  /_\  \    |  |         |  |     |   __|  |      /      \_    _/  ", 0
    batteryBar5 db "|  |_)  |  /  _____  \   |  |         |  |     |  |____ |  |\  \----.   |  |    ", 0
    batteryBar6 db "|______/  /__/     \__\  |__|         |__|     |_______|| _| `._____|   |__|    ", 0

    bar db "=========================================================================", 0

    charging db "Charging", 0
    notCharging db "Not Charging", 0

    percentageText db "%", 0

.code
Battery PROC
    mov edx, offset batteryBar1
    call WriteString
    call Crlf

     mov edx, offset batteryBar2
    call WriteString
    call Crlf


     mov edx, offset batteryBar3
    call WriteString
    call Crlf


     mov edx, offset batteryBar4
    call WriteString
    call Crlf


     mov edx, offset batteryBar5
    call WriteString
    call Crlf


     mov edx, offset batteryBar6
    call WriteString
    call Crlf

    call Crlf
    call Crlf
    mov edx, offset bar
    call WriteString
    call Crlf
    call Crlf



    ; Call the GetSystemPowerStatus function
    invoke GetSystemPowerStatus, ADDR batteryStatus

   mov edx, offset batteryText
   call WriteString


    movzx eax, byte ptr [batteryStatus.BatteryLifePercent]
    call WriteDec

     mov edx, offset percentageText
   call WriteString
   call Crlf


   mov edx, offset chargingText
   call WriteString

    movzx eax, byte ptr [batteryStatus.ACLineStatus]
    .if eax == 0
        mov edx, offset notCharging
    .else
        mov edx, offset charging
    .endif
    call WriteString

   call Crlf

   mov edx, offset timeLeftText
   call WriteString

   mov eax, [batteryStatus.BatteryLifeTime]
   mov ebx, 60
   xor edx, edx       ; Clear edx to ensure it doesn't contain garbage
    div ebx

    call WriteDec


    mov edx, offset minutesText
    call WriteString



   
    invoke ExitProcess, 0

Battery ENDP

END