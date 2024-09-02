$email = Read-Host "saisir adresse mail source"
$serveursmtp = Read-Host "saisir serveur smtp (SSL)"
$port_smtp = Read-Host "saisir le port du serveur smtp"
$destination = Read-Host "saisir adresse de destination"
Write-Host -ForegroundColor "red" "saisir les identifiants (adresse mail + mdp)"
$identifiants = Get-Credential
Send-MailMessage -From $email -To $destination -Subject "Test Email" -Body "Test SMTP authentifie microsoft 365" -SmtpServer $serveursmtp -Credential $identifiants -UseSsl -Port $port_smtp

$saisie = Read-Host "Refaire un essai d'envoi de mail ? (y/n)"
while ("y","n" -notcontains $saisie) {
        write-host "veuillez saisir uniquement y pour oui  ou n pour non"
        $saisie = read-host "Refaire un essai d'envoi de mail ? (y/n)"
}
if ($saisie -eq "y") {
    Do {
        Send-MailMessage -From $email -To $destination -Subject "Test Email" -Body "Test SMTP authentifie microsoft 365" -SmtpServer $serveursmtp -Credential $identifiants -UseSsl -Port $port_smtp
        $saisie = read-host "Refaire un essai d'envoi de mail ? (y/n)"
        while ("y","n" -notcontains $saisie) {
            write-host "veuillez saisir uniquement y pour oui  ou n pour non"
            $saisie = read-host "Refaire un essai d'envoi de mail ? (y/n)"
        }
    }
    Until ("n" -contains $saisie) {
        Write-Host "fermeture du script..."
    }
}
else {
    Write-Host "fermeture du script..."
}
