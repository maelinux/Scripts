
Connect-ExchangeOnline

# Récupérer la liste de tous les utilisateurs
$utilisateurs = Get-Mailbox -ResultSize Unlimited

# Parcourir tous les utilisateurs et supprimer les alias
foreach ($utilisateur in $utilisateurs) {
    $alias = Get-Mailbox -Identity $utilisateur.Identity | Select-Object -ExpandProperty EmailAddresses | Where-Object { $_.PrefixString -eq "smtp" } | ForEach-Object { $_.SmtpAddress }
    
    foreach ($a in $alias) {
        Write-Host "Suppression de l'alias $a pour l'utilisateur $($utilisateur.UserPrincipalName)"
        Set-Mailbox -Identity $utilisateur.Identity -EmailAddresses @{remove=$a}
    }
}