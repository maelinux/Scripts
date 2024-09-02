@echo off
setlocal enabledelayedexpansion

:: Emplacement du fichier contenant les utilisateurs à supprimer
set UserFile=%~dp0users.txt

:: Vérifiez si le fichier users.txt existe sur le support USB
if not exist "%UserFile%" (
    echo Le fichier %UserFile% n'existe pas sur le support USB.
    exit /b 1
)

:: Fonction pour trouver la lettre du lecteur contenant le dossier \Users
set DriveLetter=
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\Users\" (
        set DriveLetter=%%d:
        goto :found
    )
)

:found
if "%DriveLetter%"=="" (
    echo Le dossier \Users n'a pas été trouvé sur aucun lecteur.
    exit /b 1
)

echo Lecteur trouvé : %DriveLetter%

:: Lecture des utilisateurs à supprimer depuis le fichier
for /f "usebackq tokens=*" %%i in ("%UserFile%") do (
    set "User=%%i"
    
    :: Suppression du profil de l'utilisateur du domaine
    echo Suppression du profil de l'utilisateur !User! du domaine.
    net user !User! /domain /delete

    :: Suppression du dossier utilisateur local dans C:\Users
    if exist "%DriveLetter%\Users\!User!" (
        echo Suppression du dossier utilisateur local !User! dans %DriveLetter%\Users.
        rd /s /q "%DriveLetter%\Users\!User!"
    ) else (
        echo Le dossier %DriveLetter%\Users\!User! n'existe pas.
    )
)

echo Opération terminée.
endlocal
pause
