#ID DE FERMETURE DE SESSION : 4647 (100% Fonctionnel)
#ID D'OUVERTURE DE SESSION : 4648 (Fonctionnel, mais s'affiche en double ou triple, et s'affiche aussi pour un déverouillage)


# Surveiller les événements d'allumage/extinction des dernières 24 heures
$currentTime = Get-Date
$last24Hours = $currentTime.AddHours(-24)

Get-WinEvent -LogName System | 
    Where-Object { ($_.Id -eq 6005 -or $_.Id -eq 6006) -and $_.TimeCreated -gt $last24Hours } | 
    ForEach-Object {
        $eventTime = $_.TimeCreated
        $eventType = if ($_.Id -eq 6005) { "Allumage" } else { "Extinction" }
        Write-Host "$eventType a $eventTime"
    }
# Surveiller les événements de verrouillage/déverrouillage des dernières 24 heures
$currentTime = Get-Date
$last24Hours = $currentTime.AddHours(-24)

Get-WinEvent -LogName Security -MaxEvents 50 -ErrorAction SilentlyContinue |
    Where-Object { ($_.Id -eq 4800 -or $_.Id -eq 4801) -and $_.TimeCreated -gt $last24Hours } | 
    ForEach-Object {
        $eventTime = $_.TimeCreated
        $eventType = if ($_.Id -eq 4800) { "Déverrouillage" } else { "Verrouillage" }
        Write-Host "$eventType de session a $eventTime"
    }


#Surveiller les événements de connexion/déconnexion des dernières 24 heures
$currentTime = Get-Date
$last24Hours = $currentTime.AddHours(-24)

Get-WinEvent -LogName Security -MaxEvents 50 -ErrorAction SilentlyContinue |
    Where-Object { ($_.Id -eq 4648 -or $_.Id -eq 4647) -and $_.TimeCreated -gt $last24Hours } | 
    ForEach-Object {
        $eventTime = $_.TimeCreated
        $eventType = if ($_.Id -eq 4624) { "Connexion" } else { "Déconnexion" }
        Write-Host "$eventType à $eventTime"
    }

