# Obtenir le nom de l'utilisateur actuel
    $userName = $env:USERNAME

# Vérifier si le profil existe
$profileUser = Get-WmiObject -Class Win32_UserProfile | Where-Object { $_.LocalPath -eq "C:\Users\$userName" }

if ($profileUser) {
    # Décharger le profil s'il est chargé
    if ($profileUser.Loaded) {
        try {
            & "C:\Windows\System32\psgetsid.exe" $userName
            Stop-Process -Name explorer -Force
        } catch {
            Write-Host "Impossible de décharger le profil. Le profil est peut-être en cours d'utilisation." -ForegroundColor Red
            exit 1
        }
    }

    # Supprimer le profil utilisateur
    try {
        $profileUser.Delete()
    } catch {
        Write-Host "profil non supprime"
        exit 1
    }
} else {
    Write-Host "profil non trouve"
}
