#=======================================================
#NAME:exerciceDHCP4.ps1
#AUTHOR: Garnier Théo
#DATE:11/12/2024
#
#VERSION:1.0
#COMMENTS: Création d'une étentue DHCP avec le nom,l'adresse réseau,le masque,la première adresse,la dernière,la passerelle,le domaine et l'adresse IP du serveur de domaine + boites de dialogue
#COMMENTS: Le nombre de Création peu etre sélectionner + possibilité d'avoir une reservation d'adresse
#=======================================================
[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

$nombre = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer le nombre d'étendue DHCP?","Saisir le nombre d'étendue DHCP")

for ($i = 0; $i -lt $nombre; $i++){
$nom = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer le nom d'étendue DHCP ?","Saisir le nom d'étendue DHCP")
$adresse_reseau = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer l'adresse réseau de l'étendue?","Saisir l'adresse réseau de l'étendue")
$masque = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer le masque de sous-réseau de l'étendue?","Saisir le masque de sous-réseau de l'étendue")
$premiere_adresse = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer la première adresse à distribuer?","Saisir la première adresse à distribuer")
$derniere_adresse = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer la dernière adresse à distribuer?","Saisir la dernière adresse à distribuer")
$passerelle = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer la passerelle à diffuser?","Saisir la passerelle à diffuser")
$domaine = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer le nom de domaine?","Saisir le nom de domaine")
$ipdomaine = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer l'adresse IP du serveur de domaine?","Saisir l'adresse IP du serveur de domaine")
$reservation = [Microsoft.VisualBasic.Interaction]::InputBox("voulez vous saisir une réservation d'adresse(OUI/NON)?","Saisir (OUI/NON)")
If($reservation -eq "OUI"){
$premiere_reservation = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer la première adresse de la reservation?","Saisir la première adresse de la reservation")
$derniere_reservation = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer la dernière adresse de la reservation?","Saisir la dernière adresse de la reservation")
}
Write-host -ForegroundColor Yellow "=======================Récapitulatif de la configuration============================"
Write-host -ForegroundColor Yellow "le nom d'étendue DHCP: $nom"
Write-host -ForegroundColor Yellow "l'adresse réseau de l'étendue: $adresse_reseau"
Write-host -ForegroundColor Yellow "le masque de sous-réseau de l'étendue: $masque"
Write-host -ForegroundColor Yellow "la première adresse à distribuer: $premiere_adresse"
Write-host -ForegroundColor Yellow "la dernière adresse à distribuer: $derniere_adresse"
Write-host -ForegroundColor Yellow "la passerelle à diffuser: $passerelle"
Write-host -ForegroundColor Yellow "le nom de domaine: $domaine"
Write-host -ForegroundColor Yellow "l'adresse IP du serveur de domaine: $ipdomaine"
If($reservation -eq "OUI"){
Write-host -ForegroundColor Yellow "la première adresse de la reservation: $premiere_reservation"
Write-host -ForegroundColor Yellow "la dernière adresse de la reservation: $derniere_reservation"
}
Write-host -ForegroundColor Yellow "===================================================================================="

$reponse = [Microsoft.VisualBasic.Interaction]::InputBox("Etes-vous sur d'avoir mis la bonne configuration(OUI/NON)?","Saisir (OUI/NON)")

If($reponse -eq "OUI"){
Add-DhcpServerv4Scope -name $nom -StartRange $premiere_adresse -EndRange $derniere_adresse -SubnetMask $masque -State Active
Add-DHCPServerV4ExclusionRange -ScopeId $adresse_reseau -StartRange 192.168.1.70 -EndRange 192.168.1.75
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
If($reservation -eq "OUI"){
Write-host -ForegroundColor Yellow "la première adresse de la reservation: $premiere_reservation"
Write-host -ForegroundColor Yellow "la dernière adresse de la reservation: $derniere_reservation"
}
Write-host -ForegroundColor Green "====================================================================================="
}
Else{
Write-host "Fin du script"
}
}