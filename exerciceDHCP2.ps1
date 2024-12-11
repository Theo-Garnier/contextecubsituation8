#=======================================================
#NAME:exerciceDHCP2.ps1
#AUTHOR: Garnier Théo
#DATE:11/12/2024
#
#VERSION:1.0
#COMMENTS: Création d'une étentue DHCP avec le nom,l'adresse réseau,le masque,la première adresse,la dernière,la passerelle,le domaine et l'adresse IP du serveur de domaine
#
#=======================================================
[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

$nom = Read-host "Entrer le nom d'étendue DHCP ?"
$adresse_reseau = Read-host "Entrer l'adresse réseau de l'étendue?"
$masque = Read-host "Entrer le masque de sous-réseau de l'étendue?"
$premiere_adresse = Read-host "Entrer la première adresse à distribuer?"
$derniere_adresse = Read-host "Entrer la dernière adresse à distribuer?"
$passerelle = Read-host "Entrer la passerelle à diffuser?"
$domaine = Read-host "Entrer le nom de domaine?"
$ipdomaine = Read-host "Entrer l'adresse IP du serveur de domaine?"

Write-host -ForegroundColor Yellow "=======================Récapitulatif de la configuration============================"
Write-host -ForegroundColor Yellow "le nom d'étendue DHCP: $nom"
Write-host -ForegroundColor Yellow "l'adresse réseau de l'étendue: $adresse_reseau"
Write-host -ForegroundColor Yellow "le masque de sous-réseau de l'étendue: $masque"
Write-host -ForegroundColor Yellow "la première adresse à distribuer: $premiere_adresse"
Write-host -ForegroundColor Yellow "la dernière adresse à distribuer: $derniere_adresse"
Write-host -ForegroundColor Yellow "la passerelle à diffuser: $passerelle"
Write-host -ForegroundColor Yellow "le nom de domaine: $domaine"
Write-host -ForegroundColor Yellow "l'adresse IP du serveur de domaine: $ipdomaine"
Write-host -ForegroundColor Yellow "===================================================================================="


$reponse = Read-host "Etes-vous sur d'avoir mis la bonne configuration(OUI/NON)?"

If($reponse -eq "OUI"){
Add-DhcpServerv4Scope -name $nom -StartRange $premiere_adresse -EndRange $derniere_adresse -SubnetMask $masque -State Active
Set-DhcpServerv4OptionValue -OptionID 3 -Value $passerelle -ScopeID $adresse_reseau
Set-DhcpServerv4OptionValue -OptionID 6 -Value $ipdomaine -ScopeID $adresse_reseau
Set-DhcpServerv4OptionValue -OptionID 15 -Value $domaine -ScopeID $adresse_reseau

Write-host -ForegroundColor Green "===========================Configuration mise en place==============================="
Write-host -ForegroundColor Green "Configuration mise en place:"
Write-host -ForegroundColor Green "le nom d'étendue DHCP: $nom"
Write-host -ForegroundColor Green "l'adresse réseau de l'étendue: $adresse_reseau"
Write-host -ForegroundColor Green "le masque de sous-réseau de l'étendue: $masque"
Write-host -ForegroundColor Green "la première adresse à distribuer: $premiere_adresse"
Write-host -ForegroundColor Green "la dernière adresse à distribuer: $derniere_adresse"
Write-host -ForegroundColor Green "la passerelle à diffuser: $passerelle"
Write-host -ForegroundColor Green "le nom de domaine: $domaine"
Write-host -ForegroundColor Green "l'adresse IP du serveur de domaine: $ipdomaine"
Write-host -ForegroundColor Green "====================================================================================="
}
Else{
Write-host "Fin du script"
}