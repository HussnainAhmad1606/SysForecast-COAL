.386
.MODEL Flat, StdCall
OPTION CaseMap:None

INCLUDE \masm32\include\windows.inc
INCLUDE \masm32\include\kernel32.inc

includelib \masm32\lib\kernel32.lib

INCLUDE File.inc

.data
  commandLine db "cmd.exe /c g++ D:\showRunningProcesses.cpp -o showRunningProcesses.exe -lpsapi && showRunningProcesses.exe", 0
  startupInfo STARTUPINFO <>
  processInfo PROCESS_INFORMATION <0, 0, 0, 0>


.code
RunProcessCommand PROC
  ; Initialize the STARTUPINFO structure
  INVOKE RtlZeroMemory, ADDR startupInfo, SIZEOF STARTUPINFO
  mov startupInfo.cb, SIZEOF STARTUPINFO
  mov startupInfo.dwFlags, STARTF_USESHOWWINDOW
  mov startupInfo.wShowWindow, SW_HIDE

  ; Call CreateProcess to run the shell command
  invoke CreateProcess, NULL, ADDR commandLine, NULL, NULL, FALSE, NORMAL_PRIORITY_CLASS, NULL, NULL, ADDR startupInfo, ADDR processInfo

  ; Check if CreateProcess succeeded
  test eax, eax
  jz error_exit

  ; Wait for the process to finish
  invoke WaitForSingleObject, processInfo.hProcess, INFINITE

  ; Close process and thread handles
  invoke CloseHandle, processInfo.hProcess
  invoke CloseHandle, processInfo.hThread

  ; Exit the program
  invoke ExitProcess, 0

error_exit:
  ; Handle error (print error message, etc.)
 

  ; Exit the program with an error code
  invoke ExitProcess, 1
RunProcessCommand ENDP
END
