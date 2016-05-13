@echo off
setlocal EnableDelayedExpansion
set path=%path%;%~dp0

if "%1"=="" (
echo Enter directory name now where the updates are stored:
set /p d=
)

if "%d%"=="" (
echo you have to enter direcotry name to start!
goto exit
)

if not exist "%~dp0%d%" (
echo the direcotry name %d% do not exist!
goto exit
)

for /f "tokens=*" %%i in ('dir /b "%~dp0%d%"') do (
echo %%i | sed "s/^.*(\|)//g" | grep "^.........$" > nul 2>&1
if !errorlevel!==0 (
for /f "tokens=*" %%a in ('echo %%i ^|
sed "s/^.*(\|)//g" ^|
sed "s/.\{2\}/&0/"') do (
echo %~dp0%d%\%%i
ren "%~dp0%d%\%%i" "%%a"
)
)

echo %%i | sed "s/^.*(\|)//g" | grep "^..........$" > nul 2>&1
if !errorlevel!==0 (
for /f "tokens=*" %%a in ('echo %%i ^|
sed "s/^.*(\|)//g" ^|
grep "^..........$"') do (
echo %~dp0%d%\%%i
ren "%~dp0%d%\%%i" "%%a"
)
)

)


:exit

endlocal

pause

