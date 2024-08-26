@echo off
setlocal enabledelayedexpansion

:hello

:prompt_operation
echo.
echo.
set /p operation=Are we adding or removing something to a file name? (A/R): 
if /i not "!operation!"=="A" if /i not "!operation!"=="R" (
    echo Invalid input. Please enter A for "add" or R for "remove".
    goto :prompt_operation
)

if /i "!operation!"=="A" (
    set operation=add
) else if /i "!operation!"=="R" (
    set operation=remove
)

:prompt_string
echo.
echo.
set /p string=What string of text or characters are we adding/removing?: 
if "!string!"=="" (
    echo String cannot be empty. Please enter a valid string.
    goto :prompt_string
)

:prompt_position
echo.
echo.
if /i "!operation!"=="add" (
    set /p position="Should we Prepend or Append? (P/A): "
    if /i not "!position!"=="P" if /i not "!position!"=="A" (
        echo Invalid input. Please enter P for "prepend" or A for "append".
        goto :prompt_position
    )
) else (
    set /p position="Is the string Prepended or Appended? (P/A): "
    if /i not "!position!"=="P" if /i not "!position!"=="A" (
        echo Invalid input. Please enter P for "prepended" or A for "appended".
        goto :prompt_position
    )
)

if /i "!position!"=="P" (
    set position=prepend
) else (
    set position=append
)

:prompt_extension
echo.
echo.
set /p extension=What file types are we editing? Do not add the prefixing dot. Examples: TXT, JSON, PDF, etc... Do not add the prefixing dot: 

if "!extension!"=="" (
    echo File extension cannot be empty. Please enter a valid extension.
    goto :prompt_extension
)
:: add the dot to the extension
set "extension=.!extension!"

:select_folder
for /f "delims=" %%F in ('powershell -command "Add-Type -AssemblyName System.Windows.Forms; $fbd = New-Object System.Windows.Forms.FolderBrowserDialog; [System.Windows.Forms.DialogResult]::OK -eq $fbd.ShowDialog(); $fbd.SelectedPath"') do set "folder=%%F"
if "!folder!"=="" (
    echo No folder selected. Please select a valid folder.
    exit /b
)

if not exist "!folder!" (
    echo The selected folder does not exist. Please select a valid folder.
    echo Press any key to try again...
    pause>nul
    goto :select_folder
)

:grammar
if /i "!operation!"=="add" (
    set operation_grammar=to
) else (
    set operation_grammar=from
)

if /i "!position!"=="prepend" (
    set position_grammar=the beginning of
) else (
    set position_grammar=the end of
)

:confirm
cls
echo.
echo.
echo DOUBLE CHECK...
echo.
echo    You have chosen to !operation! "!string!" !operation_grammar! !position_grammar! all !extension! file names in this directory:
echo.
echo         !folder!
echo.
set /p confirm=Type Y to proceed or N to cancel and press Enter: 
if /i "!confirm!"=="N" (
    echo Operation canceled.
    echo Press any key to start over...
    pause>nul
    goto hello
)
if /i not "!confirm!"=="Y" (
    echo Invalid input. Please type Y to proceed or N to cancel.
    goto :confirm
)

:: Perform the operation
cd /d "!folder!"

echo.
echo.
echo Renamed:

for %%A in (*!extension!) do (
    set "filename=%%~nA"
    
    if /i "!operation!"=="add" (
        if /i "!position!"=="prepend" (
			set newname=!string!!filename!
        ) else (
			set newname=!filename!!string!
        )
    ) else if /i "!operation!"=="remove" (
        if /i "!position!"=="prepend" (
            set "newname=!filename:%string%=!"
        ) else (
            set "newname=!filename:%string%=!"
        )
    )
	ren "%%A" "!newname!!extension!"
    echo               !newname!!extension!
    echo.
    echo.
)

echo.
echo.
echo Operation completed.
pause

endlocal
