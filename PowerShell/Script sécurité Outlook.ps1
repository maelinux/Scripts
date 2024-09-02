$valeurParametreOutlook = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Wow6432Node\Microsoft\Office\16.0\Outlook\Security').ObjectModelGuard
if ($valeurParametreOutlook -eq '2')
{
    exit 
}
else
{
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Wow6432Node\Microsoft\Office\16.0\Outlook\Security' -name ObjectModelGuard -value 2
}
