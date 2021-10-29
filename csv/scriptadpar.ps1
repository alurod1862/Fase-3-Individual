 
param($dominio,$sufijoDominio)
$domainComponent="dc="+$dominio+"dc="+$sufijoDominio
{
  Import-Module ActiveDirectory
}
$fileUsersCsv=Read-Host "Introduce el fichero csv de los usuarios"
$fichero = import-csv -Path $fileUsersCsv -Delimiter : 				     
foreach($linea in $fichero)
{
	$containerPath =$linea.ContainerPath+","+$domainComponent 
	$passAccount=ConvertTo-SecureString $linea.Pass -AsPlainText -force
	$nameShort=$linea.Name+'.'+$linea.FirstName
	$Surnames=$linea.FirstName+' '+$linea.LastName
	$nameLarge=$linea.Name+' '+$linea.FirstName+' '+$linea.LastName

	New-ADUser 
    -SamAccountName $nameShort -UserPrincipalName $nameShort -Name $nameShort `
		-Surname $Surnames -DisplayName $nameLarge -GivenName $linea.Name `
		-Description "Cuenta de $nameLarge" `
		-AccountPassword $passAccount -Enabled $Habilitado `
		-CannotChangePassword $false -ChangePasswordAtLogon $true `
		-PasswordNotRequired $false -Path $containerPath `

	$cnGrpAccount="Cn="+$linea.Group+","+$containerPath
	Add-ADGroupMember -Identity $cnGrpAccount -Members $nameShort
}