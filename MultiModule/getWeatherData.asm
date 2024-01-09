.386

.MODEL Flat, StdCall
OPTION CaseMap:None
INCLUDE \masm32\include\windows.inc
INCLUDE \masm32\include\kernel32.inc
INCLUDE \masm32\include\wininet.inc
INCLUDELIB \masm32\lib\winstrm.lib
INCLUDELIB \masm32\lib\kernel32.lib
INCLUDELIB \masm32\lib\wininet.lib
INCLUDE File.inc


.data
    cityPrompt byte "Enter city Name: ", 0
  szUrl       db "https://api.weatherapi.com/v1/current.json?key=e0f8de7b6aba4700a18152535231612%20&q=", 0
  city BYTE 10 DUP(?)
  hInternet   dd ?
  hConnect    dd ?
  pBuffer     BYTE 4096 dup(?)
  bytesRead   dd ?
  szAppName   db "SysForecast", 0
  doneMsg     db "Done", 0
  nameText BYTE "name", 0
  countryText BYTE "country", 0
  humidityText BYTE "humidity", 0
  weatherConditionText BYTE "text", 0
  windText BYTE "wind_mph", 0
  temperatureText BYTE "temp_c", 0
  pressureText BYTE "pressure_mb", 0
  precipitationText BYTE "precip_mm", 0
  gustText BYTE "gust_mph", 0
  viscosityText BYTE "vis_km", 0


  precipitationShowText BYTE "precipitation (mm): ", 0
  gustShowText BYTE "Gust Speed (mph): ", 0
  temperatureShowText BYTE "Temperature (C°): ", 0
  pressureShowText BYTE "Pressure (Millibar): ", 0
  weatherCondition BYTE "Weather Condition: ", 0
  nameShowText BYTE "City: ", 0
  windShowText BYTE "Wind (MPH): ", 0
  countryShowText BYTE "Country: ", 0
  humidityShowText BYTE "Humidity: ", 0
  viscosityShowText BYTE "Viscosity (km): ", 0

  pleaseWaitText BYTE "Please wait while we are fetching the weather data..... ", 0



.code
getWeather PROC

mov edx, offset cityPrompt
call WriteString

mov edx, OFFSET city
    mov ecx, SIZEOF city
    call ReadString
    
    push    OFFSET szUrl
        push    OFFSET city
        call    Str_concat


    call Crlf
    mov edx, OFFSET pleaseWaitText
    call WriteString
   
    call Crlf

  ; Initialize Wininet
 invoke InternetOpen, offset szAppName, INTERNET_OPEN_TYPE_DIRECT, 0, 0, 0
  mov hInternet, eax
  test eax, eax
  jz  cleanup

  ; Open the URL
  invoke InternetOpenUrl, hInternet, offset szUrl, 0, 0, INTERNET_FLAG_RELOAD, 0
  mov hConnect, eax
  

  ; Read data from the URL
  invoke InternetReadFile, hConnect, offset pBuffer, sizeof pBuffer, offset bytesRead
 


  call Crlf
  mov edx, offset nameShowText
  call WriteString
  invoke findStr, ADDR pBuffer, ADDR nameText
  call Crlf 

    Call Crlf
  mov edx, offset countryShowText
  call WriteString
  invoke findStr, ADDR pBuffer, ADDR countryText
  call Crlf
  

   Call Crlf
  mov edx, offset temperatureShowText
  call WriteString
  invoke findStr, ADDR pBuffer, ADDR temperatureText
  call Crlf
  
  Call Crlf
  mov edx, offset humidityShowText
  call WriteString
  invoke findStr, ADDR pBuffer, ADDR humidityText
  call Crlf

   Call Crlf
  mov edx, offset precipitationShowText
  call WriteString
  invoke findStr, ADDR pBuffer, ADDR precipitationText
  call Crlf
  
  Call Crlf
  mov edx, offset windShowText
  call WriteString
  invoke findStr, ADDR pBuffer, ADDR windText
  call Crlf

  Call Crlf
  mov edx, offset gustShowText
  call WriteString
  invoke findStr, ADDR pBuffer, ADDR gustText
  call Crlf
  
  Call Crlf
  mov edx, offset pressureShowText
  call WriteString
  invoke findStr, ADDR pBuffer, ADDR pressureText
  call Crlf

  Call Crlf
  mov edx, offset viscosityShowText
  call WriteString
  invoke findStr, ADDR pBuffer, ADDR viscosityText
  call Crlf

  Call Crlf
  mov edx, offset weatherCondition
  call WriteString
  invoke findStr, ADDR pBuffer, ADDR weatherConditionText

  call Crlf


    jmp quit


cleanup:
  ; Close handles and cleanup
  invoke InternetCloseHandle, hConnect
  invoke InternetCloseHandle, hInternet
  jmp quit

    
quit:
call Crlf
mov edx, offset doneMsg
call WriteString
call Crlf
ret
getWeather ENDP
Str_concat PROC
        push    ebp
        mov     ebp, esp
        pushad
        mov     edi, [ebp + 12] ; target string
        mov     esi, [ebp + 8]  ; source string

        xor     eax, eax
LScanString:
        scasb
        jne     LScanString
        dec     edi
        mov     ecx, 1
        cld
LConcatStrings:
        inc     ecx
        rep     movsb
        cmp     [esi], eax
        jne     LConcatStrings

LExitStr_concat:
        popad
        pop     ebp
        ret     8
Str_concat ENDP

end
