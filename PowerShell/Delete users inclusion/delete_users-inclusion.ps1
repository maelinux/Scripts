$includeUsers = Get-Content .\users.txt

Get-WmiObject -Class Win32_UserProfile | ForEach-Object {
    if ($includeUsers -contains $_.LocalPath.Split('\')[-1]) {
        $_.Delete()
        Write-Host "Profil $($_.LocalPath) bien supprime."
    } else {
        Write-Host "Profil $($_.LocalPath) conserve."
    }
}