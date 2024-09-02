$defaultexcludeUsers = @('Administrator','Administrateur','Utilisateur', 'Default', 'DefaultAppPool', 'Public')
$userInput = Read-Host -Prompt "Entrez les noms des utilisateurs a exclure sous cette forme (sans espace) : user1,user2,user3"
$UsersSupplementaire = $userInput -split ','
$excludeUsers = $defaultExcludeUsers + $UsersSupplementaire

Get-WmiObject -Class Win32_UserProfile | ForEach-Object {
    if ($excludeUsers -notcontains $_.LocalPath.Split('\')[-1]) {
        $_.Delete()
        Write-Host "Profil $($_.LocalPath) bien supprime."
    } else {
        Write-Host "Profil $($_.LocalPath) conserve."
    }
}