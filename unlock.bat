@echo off
set actstaty=Account active               Yes

:ntlog
cls
set /P ntlog=NT Login:

cls

echo NT Login is %ntlog%
echo.
set /p ask=is this correct? (y/n)
if %ask%==n (goto :ntlog) else goto :conf
:conf

cls

echo Checking status of %ntlog%...

net user %ntlog% /DOMAIN | FIND /I "Account Active" > temp.txt

set /p actstat=<temp.txt
del /f temp.txt
echo.
echo %actstat%
echo.

pause

cls

IF "%actstat%"=="%actstaty%" (
	cls
	echo This user is not currently locked out. . .
	echo.
	pause
	goto :eof
) ELSE (
	echo User is locked
	echo.
	pause
	goto :unlock
)


:unlock
cls
Unlocking user. . .
echo.
net user %ntlog% /DOMAIN /active:YES
echo.
echo User is now unlocked. . .

pause
