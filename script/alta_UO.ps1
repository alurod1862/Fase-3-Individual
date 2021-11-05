$ficheroCsvUO=Read-Host "Introduce el fichero csv de UO"
$fichero=import-csv -Path $ficheroCsvUO -delimiter : 
foreach($line in $fichero)
{
   New-ADOrganizationalUnit -Description:$line.Description -Name:$line.Name -Path:$line.Path -ProtectedFromAccidentalDeletion:$false
}