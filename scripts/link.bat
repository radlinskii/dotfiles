REM Main script to create symbolic links for all items in a directory
set "sourceDirectory=C:\Users\irad\Projects\dotfiles\nvim"
set "destinationDirectory=C:\Users\irad\AppData\Local\nvim3"

REM Ensure destination directory exists
if not exist "%destinationDirectory%" (
    mkdir "%destinationDirectory%"
)

REM Function to create symbolic link
:CreateSymbolicLink
set "sourcePath=%~1"
set "destinationPath=%~2"

if exist "%destinationPath%" (
    echo Destination path "%destinationPath%" already exists. Skipping.
    goto :eof
)

if exist "%sourcePath%\*" (
    mklink /d "%destinationPath%" "%sourcePath%"
) else (
    mklink "%destinationPath%" "%sourcePath%"
)
goto :eof

REM Main script to create symbolic links for all items in the source directory

REM Iterate over all items (directories and files) in the source directory
for /r "%sourceDirectory%" %%I in (.) do (
    set "relativePath=%%I"
    set "relativePath=!relativePath:%sourceDirectory%=!"
    set "sourcePath=%%I"
    set "destinationPath=%destinationDirectory%!relativePath!"

    REM Create parent directory for destination path if needed
    if not exist "%destinationPath%" (
        mkdir "%destinationPath%"
    )

    REM Create symbolic link for the directory
    call :CreateSymbolicLink "%sourcePath%" "%destinationPath%"
)

REM Iterate over all files and create symbolic links
for /r "%sourceDirectory%" %%I in (*) do (
    set "relativePath=%%I"
    set "relativePath=!relativePath:%sourceDirectory%=!"
    set "sourcePath=%%I"
    set "destinationPath=%destinationDirectory%!relativePath!"

    REM Create parent directory for destination path if needed
    set "destParentDir=%destinationPath%"
    for %%J in ("%destParentDir%") do (
        if not exist "%%~dpJ" (
            mkdir "%%~dpJ"
        )
    )

    REM Create symbolic link for the file
    call :CreateSymbolicLink "%sourcePath%" "%destinationPath%"
)

echo Done.
endlocal
pause
