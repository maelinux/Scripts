$now = Get-Date
$nomfichier = Get-Date -Format "dddd-dd-MM-yyyy"
$cheminFichier = $nomfichier+'.txt'
# Calculer la date et l'heure d'il y a 24 heures
$24h = $now.AddHours(-24)

# Récupérer les événements de connexion pour les dernières 24 heures
$events = Get-WinEvent -FilterHashtable @{
    LogName = 'Security'
    ID = 4624, 4634, 4647, 4648
    StartTime = $24h
} | Where-Object { $_.Properties[5].Value -ne 'SYSTEM' -and ($_ | Where-Object { $_.Properties[5].Value -in @('m.donval', 'test') }) } | Sort-Object -Property TimeCreated -Unique

# Afficher les informations de connexion/déconnexion
foreach ($event in $events) {
    $time = $event.TimeCreated
    $user = $event.Properties[5].Value 
    $eventType = if ($event.Id -eq 4624) { "Connexion" } else { "Deconnexion" }

    Add-Content -Path $cheminFichierTexte  -Value "$eventType de l'utilisateur $user a $time"
#    Write-Output "$eventType de l'utilisateur $user a $time" | Out-File test.txt
}
# Spécifiez le chemin du fichier texte

# Lire le contenu du fichier et supprimer les doublons
$contenuSansDoublons = Get-Content $cheminFichier | Select-Object -Unique

# Écrire le résultat dans le même fichier (écrasement du fichier d'origine)
$contenuSansDoublons | Set-Content $cheminFichier

Type $cheminFichier