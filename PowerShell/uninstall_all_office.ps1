$officeApps = Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name LIKE 'Microsoft Office%'" 

foreach ($app in $officeApps) {
    $appName = $app.Name
    Write-Host "Désinstallation en cours de $appName ..."
    $app.Uninstall()
}
