$email = Read-Host "saisir adresse mail source"
Write-Host -ForegroundColor "red" "saisir les identifiants (adresse mail + mdp application)"
$identifiants = Get-Credential
Send-MailMessage -From $email -To "supervision@connecs-informatique.fr" -Subject "Test Email" -Body "Test SMTP authentifie microsoft 365" -SmtpServer smtp.office365.com -Credential $identifiants -UseSsl -Port 587 

$saisie = Read-Host "Refaire un essai d'envoi de mail ? (y/n)"
while ("y","n" -notcontains $saisie) {
        write-host "veuillez saisir uniquement y pour oui  ou n pour non"
        $saisie = read-host "Refaire un essai d'envoi de mail ? (y/n)"
}
if ($saisie -eq "y") {
    Do {
        Send-MailMessage -From $email -To "supervision@connecs-informatique.fr" -Subject "Test Email" -Body "Test SMTP authentifie microsoft 365" -SmtpServer smtp.office365.com -Credential $identifiants -UseSsl -Port 587 
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
