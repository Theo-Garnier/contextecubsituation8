#=======================================================
#NAME:exerciceDHCP1.ps1
#AUTHOR: Garnier Th�o
#DATE:11/12/2024
#
#VERSION:1.0
#COMMENTS: Cr�ation d'une �tentue DHCP avec le nom,l'adresse r�seau,le masque,la premi�re adresse,la derni�re et la passerelle
#
#=======================================================

$nom = Read-host "Entrer le nom d'�tendue DHCP ?"
$adresse_reseau = Read-host "Entrer l'adresse r�seau de l'�tendue?"
$masque = Read-host "Entrer le masque de sous-r�seau de l'�tendue?"
$premiere_adresse = Read-host "Entrer la premi�re adresse � distribuer?"
$derniere_adresse = Read-host "Entrer la derni�re adresse � distribuer?"
$passerelle = Read-host "Entrer la passerelle � diffuser?"

Write-host -ForegroundColor Yellow "=======================R�capitulatif de la configuration============================"
Write-host -ForegroundColor Yellow "le nom d'�tendue DHCP: $nom"
Write-host -ForegroundColor Yellow "l'adresse r�seau de l'�tendue: $adresse_reseau"
Write-host -ForegroundColor Yellow "le masque de sous-r�seau de l'�tendue: $masque"
Write-host -ForegroundColor Yellow "la premi�re adresse � distribuer: $premiere_adresse"
Write-host -ForegroundColor Yellow "la derni�re adresse � distribuer: $derniere_adresse"
Write-host -ForegroundColor Yellow "la passerelle � diffuser: $passerelle"
Write-host -ForegroundColor Yellow "===================================================================================="

$reponse = Read-host "Etes-vous sur d'avoir mis la bonne configuration(OUI/NON)?"

If($reponse -eq "OUI"){
Add-DhcpServerv4Scope -name $nom -StartRange $premiere_adresse -EndRange $derniere_adresse -SubnetMask $masque -State Active
Set-DhcpServerv4OptionValue -OptionID 3 -Value $passerelle -ScopeID $adresse_reseau

Write-host -ForegroundColor Green "===========================Configuration mise en place==============================="
Write-host -ForegroundColor Green "Configuration mise en place:"
Write-host -ForegroundColor Green "le nom d'�tendue DHCP: $nom"
Write-host -ForegroundColor Green "l'adresse r�seau de l'�tendue: $adresse_reseau"
Write-host -ForegroundColor Green "le masque de sous-r�seau de l'�tendue: $masque"
Write-host -ForegroundColor Green "la premi�re adresse � distribuer: $premiere_adresse"
Write-host -ForegroundColor Green "la derni�re adresse � distribuer: $derniere_adresse"
Write-host -ForegroundColor Green "la passerelle � diffuser: $passerelle"
Write-host -ForegroundColor Green "====================================================================================="
}
Else{
Write-host "Fin du script"
}


