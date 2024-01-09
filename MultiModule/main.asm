
.386
.MODEL Flat, StdCall
OPTION CaseMap:None

 include \masm32\include\windows.inc
    include \masm32\include\user32.inc
    include \masm32\include\kernel32.inc
        
    ;-------------------------------------------------
    ;              Linked Libraries
    ;-------------------------------------------------
    
    includelib \masm32\lib\user32.lib
    includelib \masm32\lib\kernel32.lib

    INCLUDE C:/Irvine/Irvine32.inc
    INCLUDELIB C:/Irvine/Irvine32.lib

INCLUDE File.inc
.data
    message db 'Total Physical Memory: ', 0
    availableMemory db 'Available Physical Memory: ', 0
    availableVirtual db 'Available Virtual Memory: ', 0
    totalVirtual db 'Total Virtual Memory: ', 0
    Projectname1 byte "                                      _______     _______ _______ ______ __  __   ______ ____  _____  ______ _____           _____ _______ ", 0
    Projectname2 byte "                                     / ____\ \   / / ____|__   __|  ____|  \/  | |  ____/ __ \|  __ \|  ____/ ____|   /\    / ____|__   __|", 0
    Projectname3 byte "                                    | (___  \ \_/ / (___    | |  | |__  | \  / | | |__ | |  | | |__) | |__ | |       /  \  | (___    | |   ", 0
    Projectname4 byte "                                     \___ \  \   / \___ \   | |  |  __| | |\/| | |  __|| |  | |  _  /|  __|| |      / /\ \  \___ \   | |   ", 0
    Projectname5 byte "                                     ____) |  | |  ____) |  | |  | |____| |  | | | |   | |__| | | \ \| |___| |____ / ____ \ ____) |  | |   ", 0
    Projectname6 byte "                                    |_____/   |_| |_____/   |_|  |______|_|  |_| |_|    \____/|_|  \_\______\_____/_/    \_\_____/   |_|   ", 0
    Projectname7 byte "                                    -------------------------------------------------------------------------------------------------------",0
    Projectname8 byte "                                    *******************************************************************************************************",0
    Projectname9 byte "                                    -------------------------------------------------------------------------------------------------------",0
    features byte "          System forecast Features",0
    choice byte "Select One of them to learn how it Work",0
    choose dd 0
    feature0 byte "| -----------------------------------------  |",0
    feature7 byte "| |                                        | |",0
    feature1 byte "| | 1-     RAM Info                        | |",0
    feature2 byte "| | 2-     Battery Status                  | |",0
    feature3 byte "| | 3-     Processor Brand String          | |",0
    feature4 byte "| | 4-     Weather Updates                 | |",0
    feature5 byte "| | 5-     Currently Running Processes     | |",0
    closeProcessFeature byte "| | 6-     Close a Process                 | |",0
    feature6 byte "| -----------------------------------------  |",0
    feature8 byte "----------------------------------------------",0

weather1 byte "                                     __    __           _   _                                    _ _             _             ",0 
weather2 byte "                                    / / /\ \ \___  __ _| |_| |__   ___ _ __    /\/\   ___  _ __ (_) |_ ___  _ __(_)_ __   __ _ ",0
weather3 byte "                                    \ \/  \/ / _ \/ _` | __| '_ \ / _ \ '__|  /    \ / _ \| '_ \| | __/ _ \| '__| | '_ \ / _` |",0
weather4 byte "                                     \  /\  /  __/ (_| | |_| | | |  __/ |    / /\/\ \ (_) | | | | | || (_) | |  | | | | | (_| |",0
weather5 byte "                                      \/  \/ \___|\__,_|\__|_| |_|\___|_|    \/    \/\___/|_| |_|_|\__\___/|_|  |_|_| |_|\__, |",0
weather6 byte "                                                                                                                         |___/ ",0
weather7 byte "                                     __________________________________________________________________________________________",0                     

rain1 byte "                                                                                                         __-__                                             ",0
;rain2 byte "                                                                                                     .-'"  .  "'-.                                         ",0
rain3 byte "                                                                                                  .'  / . ' . \  '.                                       ",0
rain4 byte "                                                                                                 /_.-..-..-..-..-._\ .---------------------------------.  ",0
rain5 byte "                                                                                                          #  _,,_   ( I hear it might rain people today ) ",0
rain6 byte "                                                                                                          #/`    `\ /'---------------------------------'  ",0
rain7 byte "                                                                                                          / / 6 6\ \                                      ",0
rain8 byte "                                                                                                          \/\  Y /\/       /\-/\                          ",0
rain9 byte "                                                                                                          #/ `'U` \       /a a  \               _         ",0
rain10 byte "                                                                                                        , (  \   | \     =\ Y  =/-~~~~~~-,_____/ )        ",0
rain11 byte "                                                                                                        |\|\_/#  \_/       '^--'          ______/         ",0
rain12 byte "                                                                                                        \/'.  \  /'\         \           /                ",0
rain13 byte "                                                                                                         \    /=\  /         ||  |---'\  \                ",0
rain14 byte "                                                                                                         /____)/____)       (_(__|   ((__|                ",0
 
sun1 byte "                    ;          ",0
sun2 byte "                ;   :   ;      ",0
sun3 byte "             .   \_,!,_/   ,   ",0
sun4 byte "              `.,'     `.,'    ",0
sun5 byte "               /         \     ",0
sun6 byte "          ~ -- :         : -- ~",0
sun7 byte "               \         /     ",0
sun8 byte "              ,'`._   _.'`.    ",0
sun9 byte "             '   / `!` \   `;  ",0
sun10 byte"                ;   :   ;      ",0
                 
cloudy1  byte"                                   _                                             ",0  
cloudy2  byte"                                  (`  ).                   _                     ",0
cloudy3  byte"                                 (     ).              .:(`  )`.                 ",0
cloudy4  byte"                    )           _(       '`.          :(   .    )                ",0
cloudy5  byte"                            .=(`(      .   )     .--  `.  (    ) )               ",0
cloudy6  byte"                           ((    (..__.:'-'   .+(   )   ` _`  ) )                ",0  
cloudy7  byte"                    `.     `(       ) )       (   .  )     (   )  ._             ",0
cloudy8  byte"                      )      ` __.:'   )     (   (   ))     `-'.-(`  )           ",0
cloudy9  byte"                    )  )  ( )       --'       `- __.'         :(      ))         ",0
cloudy10 byte"                    .-'  (_.'          .')                    `(    )  ))        ",0
cloudy11 byte"                                      (_  )                     ` __.:'          ",0 
cloudy12 byte"                                                                                 ",0
cloudy13 byte"                    --..,___.--,--'`,---..-.--+--.,,-,,..._.--..-._.--_.--_.--_  ",0
                                                        
bye1 byte"                                                             ____  _  _  ____ ",0
bye2 byte"                                                            (  _ \( \/ )( ___)",0
bye3 byte"                                                             ) _ < \  /  )__) ",0
bye4 byte"                                                            (____/ (__) (____)",0

runningProc1 byte"                                                  ______                  _              ______                                      ",0
runningProc2 byte"                                                  | ___ \                (_)             | ___ \                                     ",0
runningProc3 byte"                                                  | |_/ /   _ _ __  _ __  _ _ __   __ _  | |_/ / __ ___   ___ ___  ___ ___  ___  ___ ",0
runningProc4 byte"                                                  |    / | | | '_ \| '_ \| | '_ \ / _` | |  __/ '__/ _ \ / __/ _ \/ __/ __|/ _ \/ __|",0
runningProc5 byte"                                                  | |\ \ |_| | | | | | | | | | | | (_| | | |  | | | (_) | (_|  __/\__ \__ \  __/\__ \",0
runningProc6 byte"                                                  \_| \_\__,_|_| |_|_| |_|_|_| |_|\__, | \_|  |_|  \___/ \___\___||___/___/\___||___/",0
runningProc7 byte"                                                                                   __/ |                                             ",0
runningProc8 byte"                                                                                  |___/                                              ",0


Bstring1 byte "                                        ______                                        ______                     _   _____ _        _             ",0
Bstring2 byte "                                        | ___ \                                       | ___ \                   | | /  ___| |      (_)            ",0
Bstring3 byte "                                        | |_/ / __ ___   ___ ___  ___ ___  ___  _ __  | |_/ /_ __ __ _ _ __   __| | \ `--.| |_ _ __ _ _ __   __ _ ",0
Bstring4 byte "                                        |  __/ '__/ _ \ / __/ _ \/ __/ __|/ _ \| '__| | ___ \ '__/ _` | '_ \ / _` |  `--. \ __| '__| | '_ \ / _` |",0
Bstring5 byte "                                        | |  | | | (_) | (_|  __/\__ \__ \ (_) | |    | |_/ / | | (_| | | | | (_| | /\__/ / |_| |  | | | | | (_| |",0
Bstring6 byte "                                        \_|  |_|  \___/ \___\___||___/___/\___/|_|    \____/|_|  \__,_|_| |_|\__,_| \____/ \__|_|  |_|_| |_|\__, |",0
Bstring7 byte "                                                                                                                                             __/ |",0
Bstring8 byte "                                                                                                                                            |___/ ",0 

userchoice byte "Do you want to go back main menu?",0
char byte ?
enterchoice byte "Enter Y/N or y/n",0



.code
main PROC

 call Crlf
  call Crlf
   call Crlf
    call Crlf
     call Crlf
      call Crlf
       call Crlf
        call Crlf

mov eax,11
call SetTextColor
    mov edx, offset Projectname1
    call WriteString
    call Crlf
    mov edx, offset Projectname2
    call WriteString
    call Crlf
    mov edx, offset Projectname3
    call WriteString
    call Crlf
    mov edx, offset Projectname4
    call WriteString
    call Crlf
    mov edx, offset Projectname5
    call WriteString
    call Crlf
    mov edx, offset Projectname6
    call WriteString
    call Crlf
    call Crlf
    mov edx, offset Projectname7
    call WriteString
    call Crlf
    mov edx, offset Projectname8
    call WriteString
    call Crlf
    mov edx, offset Projectname9
    call WriteString
    call Crlf
  mov eax,15
call SetTextColor

mov eax,3000
call Delay
call Clrscr


mov eax,14
call SetTextColor
call Crlf
call Crlf
l1:
    mov edx, offset features
    call WriteString
    call Crlf
    call Crlf
    mov edx, offset feature8
    call WriteString
    call Crlf
    mov edx, offset feature0
    call WriteString
    call Crlf
    mov edx, offset feature7
    call WriteString
    call Crlf
    mov edx, offset feature7
    call WriteString
    call Crlf
    mov edx, offset feature1
    call WriteString
    call Crlf
    mov edx, offset feature2
    call WriteString
    call Crlf
    mov edx, offset feature3
    call WriteString
    call Crlf
    mov edx, offset feature4
    call WriteString
    call Crlf
    mov edx, offset feature5
    call WriteString
    call Crlf
    mov edx, offset closeProcessFeature
    call WriteString
    call Crlf
    mov edx, offset feature7
    call WriteString
    call Crlf
    mov edx, offset feature7
    call WriteString
    call Crlf
     mov edx, offset feature6
    call WriteString
    call Crlf 
    mov edx, offset feature8
    call WriteString
    call Crlf
    call Crlf
    call Crlf
  
    mov edx, offset choice
    call WriteString
    call Crlf
   
mov eax,15
call SetTextColor
mov eax, choose
   call ReadDec
   mov choose,eax
   cmp choose,1
   je case_1
   cmp choose,2
   je case_2
   cmp choose,3
   je case_3
   cmp choose,4
   je case_4
   cmp choose,5
   je case_5
   cmp choose, 6
   je case_6
   jmp quit

   case_1:
   invoke RamInfo
    
    call Crlf
    jmp quit
    

  case_2:
    invoke Battery
    jmp l1

   jmp quit
  case_3:

    mov edx, offset Bstring1
    call WriteString
    call Crlf
    mov edx, offset Bstring2
    call WriteString
    call Crlf
    mov edx, offset Bstring3
    call WriteString
    call Crlf
    mov edx, offset Bstring4
    call WriteString
    call Crlf
    mov edx, offset Bstring5
    call WriteString
    call Crlf
    mov edx, offset Bstring6
    call WriteString
    call Crlf
    mov edx, offset Bstring7
    call WriteString
    call Crlf
    mov edx, offset Bstring8
    call WriteString
    call Crlf

    call ProcessorString
     jmp quit

  case_4:
  
  
  call Crlf
  call Crlf
  call Crlf
  call Crlf
  call Crlf
    mov edx, offset weather1
    call WriteString
    call Crlf
    mov edx, offset weather2
    call WriteString
    call Crlf
    mov edx, offset weather3
    call WriteString
    call Crlf
    mov edx, offset weather4
    call WriteString
    call Crlf
    mov edx, offset weather5
    call WriteString
    call Crlf
    mov edx, offset weather6
    call WriteString
    call Crlf
    mov edx, offset weather7
    call WriteString
    call Crlf
    call Crlf
    call Crlf

    invoke getWeather
    


    call Crlf
    call Crlf
    call Crlf
    call Crlf
 jmp quit

  case_5:

    mov edx, offset runningProc1
    call WriteString
    call Crlf
    mov edx, offset runningProc2
    call WriteString
    call Crlf
    mov edx, offset runningProc3
    call WriteString
    call Crlf
    mov edx, offset runningProc4
    call WriteString
    call Crlf
    mov edx, offset runningProc5
    call WriteString
    call Crlf
    mov edx, offset runningProc6
    call WriteString
    call Crlf
    mov edx, offset runningProc7
    call WriteString
    call Crlf
     mov edx, offset runningProc8
    call WriteString
    call Crlf

    call RunProcessCommand
    
    
   jmp quit

    case_6:
   
    invoke CloseProcessById
   
    
  quit:

  mov eax,11
  call Crlf
  call SetTextColor
    mov edx, offset  bye1
    call WriteString
    call Crlf
     mov edx, offset bye2
    call WriteString
    call Crlf
    mov edx, offset bye3
    call WriteString
    call Crlf
    mov edx, offset bye4
    call WriteString
    call Crlf
    call Crlf
    call Crlf

      mov eax,15
  call SetTextColor
   

   ; Exit the program
    invoke ExitProcess, 0
main ENDP
END main
