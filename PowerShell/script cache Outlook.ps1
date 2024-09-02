######Script pour mettre les ost par defaut dans un dossier D:\Profil Outlook\username et pour activer par défaut 3 mois de cache

function Test-RegistryValue {

    param (
    
     [parameter(Mandatory=$true)]
     [ValidateNotNullOrEmpty()]$Path,
    
    [parameter(Mandatory=$true)]
     [ValidateNotNullOrEmpty()]$Value
    )
    
    try {
    
    Get-ItemProperty -Path $Path | Select-Object -ExpandProperty $Value -ErrorAction Stop | Out-Null
     return $true
     }
    
    catch {
    
    return $false
    
    }    
}


if ($env:COMPUTERNAME -eq 'VSRV-RDS')
{ 
    $outlookvaleur = (Test-Path "HKCU:\Software\Microsoft\Office\16.0\Outlook")
    $CachedModevaleur = (Test-Path "HKCU:\Software\Microsoft\Office\16.0\Outlook\Cached Mode")
    $syncwindowsettingdaysvaleur = (Get-ItemProperty -path 'HKCU:\Software\Microsoft\Office\16.0\Outlook\Cached Mode').syncwindowsettingdays
    $syncwindowsettingvaleur = (Get-ItemProperty -path 'HKCU:\Software\Microsoft\Office\16.0\Outlook\Cached Mode').syncwindowsetting
    $enablevaleur = (Get-ItemProperty -path 'HKCU:\Software\Microsoft\Office\16.0\Outlook\Cached Mode').enable
    $ForceOSTPathvaleur = (Get-ItemProperty -path 'HKCU:\Software\Microsoft\Office\16.0\Outlook').ForceOSTPath
    $cheminProfile = (Test-Path "D:\Profil Outlook\$env:username")
    if ($cheminProfile = 'False')
    {
        New-Item "D:\Profil Outlook\$env:username" -ItemType Directory
    }
    else {
        Write-Host ''
    }

    if ($outlookvaleur -eq 'True' ) 
    {
        Write-Host ''
    }
    else 
    {
        New-Item "HKCU:\Software\Microsoft\Office\16.0\Outlook"
    }

    if ($ForceOSTPathvaleur -eq 'True')
    {
        Set-ItemProperty -path "HKCU:\Software\Microsoft\Office\16.0\Outlook" -name ForceOSTPath -value 'D:\Profil Outlook\%USERNAME%'
    }
    else {
        New-ItemProperty "HKCU:\Software\Microsoft\Office\16.0\Outlook" -Name ForceOSTPath -PropertyType ExpandString -value 'D:\Profil Outlook\%USERNAME%'
    }

    if ($CachedModevaleur -eq 'True' ) 
    {
        Write-Host ''
    }
    else 
    {
        New-Item "HKCU:\Software\Microsoft\Office\16.0\Outlook\Cached Mode"
        New-ItemProperty "HKCU:\Software\Microsoft\Office\16.0\Outlook\Cached Mode" -Name syncwindowsettingdays -value 60 -ErrorAction 'silentlycontinue'
        New-ItemProperty "HKCU:\Software\Microsoft\Office\16.0\Outlook\Cached Mode" -Name syncwindowsetting -value 3 -ErrorAction 'silentlycontinue'
        New-ItemProperty "HKCU:\Software\Microsoft\Office\16.0\Outlook\Cached Mode" -Name enable -value 1 -ErrorAction 'silentlycontinue'
    }

    if ($syncwindowsettingdaysvaleur -eq '60')
    {
    write-host ''
    }

    else
    {
        New-ItemProperty "HKCU:\Software\Microsoft\Office\16.0\Outlook\Cached Mode" -Name syncwindowsettingdays -value 60 -ErrorAction 'silentlycontinue'
        Set-Itemproperty -path "HKCU:\Software\Microsoft\Office\16.0\Outlook\Cached Mode" -name syncwindowsettingdays -value 60

    }

    if ($syncwindowsettingvaleur -eq '3')
    {
        write-host ''
    }

    else
    {
        New-ItemProperty "HKCU:\Software\Microsoft\Office\16.0\Outlook\Cached Mode" -Name syncwindowsetting -value 3 -ErrorAction 'silentlycontinue'
        Set-Itemproperty -path "HKCU:\Software\Microsoft\Office\16.0\Outlook\Cached Mode" -name syncwindowsetting -value 3
    }

    if ($enablevaleur -eq '1')
    {
        write-host ''
    }

    else
    {
        New-ItemProperty "HKCU:\Software\Microsoft\Office\16.0\Outlook\Cached Mode" -Name enable -value 1 -ErrorAction 'silentlycontinue'
        Set-Itemproperty -path "HKCU:\Software\Microsoft\Office\16.0\Outlook\Cached Mode" -name enable -value 1
    }
}
else {
    Write-Host ''
}
