$cred = Get-Credential -UserName "test@cgroupe.bzh" -Message "Entrer MDP"
$mailParams = @{
smtpServer = "smtp.office365.com"#"cgroupe-bzh.mail.protection.outlook.com"
Port = '25'
UseSSL = $true
Credential = $cred
From = "test@cgroupe.bzh"
To= "test@cgroupe.bzh"#"support@connecs-informatique.fr"#
Subject = "Test mail"
Body=" testmail"
DeliveryNotificationOption='onFailure', 'OnSuccess'
}
Send-MailMessage @mailParams