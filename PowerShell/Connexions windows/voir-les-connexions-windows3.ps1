$now = Get-Date
$nomfichier = Get-Date -Format "dddd-dd-MM-yyyy"
$nomPC = hostname
$CheminPC = 'C:\Users\m.donval\Groupe Connecs\Info - Production - Documents\Mael\Scripts\'+$nomPC
New-Item $cheminPC -ItemType Directory
#$cheminFichier = 'C:\Users\m.donval\Desktop\'+$nomfichier+'.xlsx'
$cheminFichierTexte = 'C:\Users\m.donval\Groupe Connecs\Info - Production - Documents\Mael\Scripts\'+$nomPC+'\'+$nomfichier+' - '+$nomPC+'.txt'
$cheminFichierExcel = 'C:\Users\m.donval\Groupe Connecs\Info - Production - Documents\Mael\Scripts\'+$nomPC+'\'+$nomfichier+' - '+$nomPC+'.xlsx'
$UtilisateursEnregistre = (Get-WmiObject -Class win32_UserAccount).Name


# Calculer la date et l'heure d'il y a 24 heures
$24h = $now.AddHours(-24)

# Récupérer les événements de connexion pour les dernières 24 heures
$events = Get-WinEvent -FilterHashtable @{
    LogName = 'Security'
    ID = 4624, 4634, 4647, 4648
    StartTime = $24h
} | Where-Object { $_.Properties[5].Value -ne 'SYSTEM' -and ($_ | Where-Object { $_.Properties[5].Value -in @($UtilisateursEnregistre) }) } | Sort-Object -Property TimeCreated -Unique

# Créez un objet Excel
$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false

if (Test-Path $cheminFichierExcel) {
    # Ouvrez le fichier Excel existant
    $workbook = $excel.Workbooks.Open($cheminFichierExcel)
}
else {

# Créez un nouveau fichier Excel
$workbook = $excel.Workbooks.Add()
#$workbook = $excel.Workbooks.Open("C:\Users\m.donval\Groupe Connecs\Info - Production - Documents\Mael\Scripts\"+$cheminFichierExcel)
$worksheet = $workbook.Worksheets.Item(1)
}
# En-têtes
$worksheet.Cells.Item(1, 1) = $nomPC
$worksheet.Cells.Item(2, 1) = "Connexion / Deconnexion"
$worksheet.Cells.Item(2, 2) = "Utilisateur"
$worksheet.Cells.Item(2, 3) = "Date et Heure"

#$worksheet.Cells.Item(1, 5) = "PC 2"
#$worksheet.Cells.Item(2, 5) = "Connexion / Deconnexion"
#$worksheet.Cells.Item(2, 6) = "Utilisateur"
#$worksheet.Cells.Item(2, 7) = "Date et Heure"

# Écrire les données dans le fichier Excel
foreach ($event in $events) {
    $time = $event.TimeCreated
    $user = $event.Properties[5].Value 
    $eventType = if ($event.Id -eq 4624) { "Connexion" } else { "Deconnexion" }

    # Ajoutez une nouvelle ligne pour chaque itération
    $prochaineLigne = $worksheet.UsedRange.Rows.Count + 1

    # Écrire les données dans les colonnes correspondantes
    $worksheet.Cells.Item($prochaineLigne, 1) = $eventType
    $worksheet.Cells.Item($prochaineLigne, 2) = $user
    $worksheet.Cells.Item($prochaineLigne, 3) = $time
    Add-Content -Path $cheminFichierTexte  -Value "$eventType $user $time"
}

#Autofit permet de réajuster automatiquement les colonnes
$worksheet.Columns.Item(3).AutoFit()


# Sauvegardez et fermez le fichier Excel
$workbook.SaveAs($cheminFichierExcel)
$excel.Quit()

# Lire le contenu du fichier texte et supprimer les doublons
$contenuSansDoublons = Get-Content $cheminFichierTexte | Select-Object -Unique

# Écrire le résultat dans le même fichier texte (écrasement du fichier d'origine)
$contenuSansDoublons | Set-Content $cheminFichierTexte
Type $cheminFichierTexte
#$worksheet.Cells.Item($2, 5) = $cheminFichierTexte