@echo off

:init
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
ECHO.

ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO args = "ELEV " >> "%vbsGetPrivileges%"
ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
ECHO Next >> "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
exit /B

:gotPrivileges
setlocal & pushd .
cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

SET mypath=%~dp0
rem echo %mypath:~0,-1% > %TEMP%\path.txt

setlocal enabledelayedexpansion

:: Emplacement du fichier contenant les utilisateurs à supprimer
set UserFile=%~dp0users.txt

:: Vérifiez si le fichier users.txt existe sur le support USB
if not exist "%UserFile%" (
    echo Le fichier %UserFile% n'existe pas sur le support USB.
    exit /b 1
)

:: Lecture des utilisateurs à supprimer depuis le fichier
for /f "usebackq tokens=*" %%i in ("%UserFile%") do (
    set "User=%%i"
    
    :: Suppression du profil de l'utilisateur du domaine
    echo Suppression du profil de l'utilisateur !User! du domaine.
    net user !User! /domain /delete

    :: Suppression du dossier utilisateur local dans C:\Users
    if exist "C:\Users\!User!" (
        echo Suppression du dossier utilisateur local !User! dans C:\Users.
        rd /s /q "C:\Users\!User!"
    ) else (
        echo Le dossier C:\Users\!User! n'existe pas.
    )
)
endlocal
pause
